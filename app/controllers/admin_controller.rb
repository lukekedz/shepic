class AdminController < ApplicationController
  before_action :user_is_admin?, except: [:active_game_slate, :game_started, :update_score, :week_number_for_scripts]
  before_action :ip_authorized?, only:   [:active_game_slate, :game_started, :update_score, :week_number_for_scripts]
  skip_before_action :verify_authenticity_token, only: [:game_started, :update_score]

  before_action :get_active_week,        except: [:add_new_game, :delete_game, :export_results]
  before_action :get_active_week_games,  except: [:add_new_game, :delete_game, :export_results, :locked]
  before_action :tbreak_in_active_week?, only:   [:active_week, :lock]

  def active_week
    if params[:game_added] then @game_added = params[:game_added] end

    @new_game = Game.new
    @teams    = Team.all.order(:name)
    @times    = @new_game.game_times()
  end

  # TODO: can be optimized! if Pick.table has week_id along with game_id...
  def user_pick_summary
    @users        = User.where(admin: false)
    @pick_summary = []

    @users.each do |u|
      user_pick_count = 0

      @active_week.games.each do |g|
        if g.picks.where(user_id: u.id)[0]
          user_pick_count += 1
        end
      end

      @pick_summary.push user_pick_count
      user_pick_count = 0
    end
  end

  def add_new_game
    params[:game][:spread] = params[:game][:spread].to_f

    @new_game = Game.new(game_params)

    if @new_game.save
      redirect_to admin_active_week_path(:game_added => "#{params[:game][:away]} vs. #{params[:game][:home]} added!")
    else
      # TODO: error msg/route
    end
  end

  def delete_game
    Game.delete(params[:id])
    redirect_to admin_active_week_path
  end

  def lock; end

  def locked
    Week.update(@active_week.id, locked: true)
    redirect_to admin_active_week_path
  end

  def scores
    @points = Array.new(101){ |i| i }
  end

  # TODO: refactor/OO
  def review
    if @active_week.locked == true
      params.each do |key, value|

        # TODO: better logic
        if key != 'controller' &&
          key != 'admin' &&
          key != 'action' &&
          key != 'review' &&
          key != 'authenticity_token'

          game = key.split("-")
          game_id   = game[0]
          away_home = game[1]
          pts = value

          game = Game.find(game_id)

          case away_home
          when "away"
            game.update(away_pts: pts)
          when "home"
            winner = current_game_winner(game.away_pts, game.home_pts, game.spread)
            game.update(home_pts: pts, winner: winner)
          end
        end

      end
    end
  end

  # TODO: refactor/OO
  def finalize
    if @active_week.locked == true
      @active_week.update(finalized: true)

      users = User.where(admin: false)

      @games.each do |game|
        if game.tiebreaker == true
          pts = game.away_pts.to_i + game.home_pts.to_i
          game.update(total_pts: pts)
        end

        picks = Pick.where(game_id: game.id)

        # update all the @games picks in the @active_week
        picks.each do |pick|
          if game.winner == "push" || game.winner == nil
            Pick.update(pick.id, correct: nil)
          else
            if game.winner == pick.away_home
              Pick.update(pick.id, correct: true)
            else
              Pick.update(pick.id, correct: false)
            end
          end
        end

        # calculate new Standings
        users.each do |user|
          pick = Pick.where(game_id: game.id, user_id: user.id)

          if pick.any? && pick[0].correct == true
            standing    = Standing.where(user_id: user.id)
            incremented = standing[0].wins + 1

            Standing.update(standing[0].id, wins: incremented)
          else
            # TODO: anything?
          end
        end
      end

      # both these booleans should be true; this is just a double check
      if @active_week.locked == true && @active_week.finalized == true
        week_id_and_num = @active_week.week + 1
        new_week = Week.new(id: week_id_and_num, week: week_id_and_num)

        if new_week.save
          redirect_to admin_active_week_path
        else
          # TODO: error msgs/route
        end
      else
        # TODO: error msgs/route
      end
    else
      # TODO: error msgs/route
    end
  end

  def export_results
    @users = User.where(admin: false).order(:id)
    @weeks = Week.where(locked: true, finalized: true)

    if params[:id]
      @week = Week.find(params[:id])
    end

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  # raspi route
  def week_number_for_scripts
    active_week = Week.where(locked: true, finalized: false).last
    render json: active_week, :status => 200
  end

  # raspi route
  def active_game_slate
    active_week     = Week.where(locked: true, finalized: false).last
    response_object = active_week ? active_week.games.order(:date).order(:start_time) : nil

    render json: response_object, :status => 200
  end

  # raspi route
  def game_started
    updated_game_record = Game.update(params[:id], game_started: true, away_pts: 0, home_pts: 0)
    render json: updated_game_record, :status => 200
  end

  # raspi route
  def update_score
    winner = current_game_winner(params[:away_pts].to_i, params[:home_pts].to_i, params[:spread].to_i) 
    updated_score = Game.update(params[:id], 
      away_pts: params[:away_pts], 
      home_pts: params[:home_pts], 
      game_finished: params[:game_finished], 
      time_remaining: params[:time_remaining],
      winner: winner
    )
    render json: updated_score, :status => 200
  end

private
  def current_game_winner(away_pts, home_pts, spread)
    if away_pts > ( home_pts + spread )
      'away'
    elsif away_pts < ( home_pts + spread )
      'home'
    else
      'push'
    end
  end

  def user_is_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  # for raspi routes
  def ip_authorized?
    unless ENV['RASPI'] == request.remote_ip && ENV['SECRET'] == params[:secret]
      puts "******************************"
      puts
      puts 'IP IP IP'
      puts request.remote_ip.inspect
      puts
      puts "******************************"

      # TODO: email alert
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
  end

  def get_active_week
    @active_week = Week.last
  end

  def get_active_week_games
    @games = Game.where(week_id: @active_week.id).order(:date, :start_time)
  end

  def tbreak_in_active_week?
    @tiebreaker = @games.where(tiebreaker: true).count
  end

  def game_params
    params.require(:game).permit(:week_id, :away, :home, :spread, :location, :tiebreaker, :date, :start_time, :game_started, :game_finished)
  end
end
