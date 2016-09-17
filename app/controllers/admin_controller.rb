class AdminController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :user_is_admin?

  def active_week
    @new_game = Game.new
    @active_week = Week.last

    @games = Game.where(week_id: @active_week.id).order(:date, :start_time)
    @max_games = @games.where(tiebreaker: false).count

    @tiebreaker_game = @games.where(tiebreaker: true)
    @tiebreaker = @games.where(tiebreaker: true).count

    @times = @new_game.game_times()
  end

  def add_new_game
    @new_game = Game.new(game_params)

    if @new_game.save
      redirect_to admin_active_week_path
    else
      # TODO: error msg
    end
  end

  def delete_game
    Game.delete(params[:id])
    redirect_to admin_active_week_path
  end

  def lock
    @active_week = Week.last
    @games = Game.where(week_id: @active_week.id).order(:date, :start_time)
    @max_games = @games.where(tiebreaker: false).count
    @tiebreaker_game = @games.where(tiebreaker: true)
    @tiebreaker = @games.where(tiebreaker: true).count
  end

  def locked
    @active_week = Week.last
    Week.update(@active_week.id, locked: true)

    redirect_to admin_active_week_path
  end

  def scores
    @points = []
    101.times { |i| @points.push i }
    @locked_week = Week.where(locked: true).last
    @games = Game.where(week_id: @locked_week.id).order(:date, :start_time)
  end

  def finalize
    @games = Game.where(week_id: Week.last.week)

    if Week.last.locked == true
      Week.last.update(finalized: true)

      params.each do |key, value|
        game = key.split("-")
        game_id   = game[0]
        away_home = game[1]
        pts = value

        case away_home
        when "away"
          Game.update(game_id, away_pts: pts)
        when "home"
          Game.update(game_id, home_pts: pts)

          # TODO: break out method
          # TODO: make one call to get game
          game = Game.find(game_id)
          if game.away_pts > ( game.home_pts + game.spread )
            Game.update(game_id, winner: "away")
          elsif game.away_pts < ( game.home_pts + game.spread )
            Game.update(game_id, winner: "home")
          else
            Game.update(game_id, winner: "push")
          end
        when "tbreak"
          Game.update(game_id, total_pts: pts)
        end
      end

      @users = User.where(admin: false)
      # @users = User.where(id: 2)

      @games.each do |game|
        picks = Pick.where(game_id: game.id)
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

        @users.each do |user|
          puts "USER: " + user.inspect

          pick = Pick.where(game_id: game.id, user_id: user.id)
          puts "PICK: " + pick.inspect

          if pick[0].correct
            if pick[0].correct == true
              standing = Standing.where(user_id: user.id)
              puts "STANDING: " + standing.inspect
              incremented = standing[0].wins + 1
              Standing.update(standing[0].id, wins: incremented)
              puts "STANDING2: " + standing.inspect

            else

            end
          else

          end
        end


      end



      redirect_to root_path
    else
      # TODO: error msgs/route
    end
  end

  def new_week
    current_week = Week.last
    if current_week.locked == true && current_week.finalized == true
      new_week = Week.new(locked: false, finalized: false)

      if new_week.save
        redirect_to admin_active_week_path
      else
        # TODO: error msgs/route
      end
    else
      # TODO: error msgs/route
    end
  end

  private

  def user_is_admin?
    unless current_user.admin
      redirect_to root_path
    end
  end

  def game_params
    params.require(:game).permit(:week_id, :away, :home, :spread, :location, :tiebreaker, :date, :start_time)
  end

end