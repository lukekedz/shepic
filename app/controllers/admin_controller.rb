class AdminController < ApplicationController
    before_action :user_is_admin?
    
    before_action :get_active_week,        except: [:add_new_game, :delete_game, :export_results]
    before_action :get_active_week_games,  except: [:add_new_game, :delete_game, :export_results, :locked]
    before_action :tbreak_in_active_week?, only:   [:active_week, :lock]

    def active_week
        @new_game = Game.new
        @teams    = Team.all.order(:name)
        @times    = @new_game.game_times()
    end

    def add_new_game
        year  = params[:game][:date][6..9].to_i
        month = params[:game][:date][0..1].to_i
        day   = params[:game][:date][3..4].to_i
        hour  = params[:game][:start_time][0..1].to_i
        min   = params[:game][:start_time][2..3].to_i

        params[:game][:date] = DateTime.new(year, month, day, hour, min)
        params[:game][:spread] = params[:game][:spread].to_i

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
    end

    def locked
        Week.update(@active_week.id, locked: true)
        redirect_to admin_active_week_path
    end

    def scores
        @points = Array.new(101){ |i| i }
    end

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
                        game.update(home_pts: pts)

                        # TODO: break out method
                        # also calculating in _active_week_games.html.erb
                        if game.away_pts > ( game.home_pts + game.spread )
                            game.update(winner: "away")
                        elsif game.away_pts < ( game.home_pts + game.spread )
                            game.update(winner: "home")
                        else
                            game.update(winner: "push")
                        end
                    end
                end

            end
        end
    end

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
                new_week = Week.new(week: @active_week.week + 1)

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
        @weeks = Week.where(locked: true, finalized: true)
        # rails c
        # weeks.first.picks OR weeks.each do { |w| w.picks }
        # have to tie-in username and standings

        respond_to do |format|
            format.html
            format.xlsx
        end
    end

private

    def user_is_admin?
        unless current_user.admin
            redirect_to root_path
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
        params.require(:game).permit(:week_id, :away, :home, :spread, :location, :tiebreaker, :date, :start_time, :game_started)
    end

end
