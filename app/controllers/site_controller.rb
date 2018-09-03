class SiteController < ApplicationController
  before_action :user

  def index
    @weeks = Week.where(locked: true, finalized: true)
  end

  def current_week
    @current_week = Week.last
    @games        = Game.where(week_id: @current_week.id).order(:date, :start_time)

    @picks = {}
    @games.each do |g|
      user_pick = g.picks.where(user_id: current_user.id)
      if user_pick[0] != nil
        @picks[user_pick[0].game_id] = { :pick => user_pick[0].pick, :away_home => user_pick[0].away_home }

        if user_pick[0].tbreak_pts != nil
          @tbreak_pts = user_pick[0].tbreak_pts
        end
      end
    end
  end

  def game_pick
    @current_pick = @user.picks.where(game_id: params[:pick][:game_id])

    respond_to do |format|
      if @current_pick == []
        @pick = Pick.new(user_id: params[:pick][:user_id], game_id: params[:pick][:game_id], pick: params[:pick][:pick].strip, away_home: params[:pick][:away_home])

        if @pick.save
          format.json { render json: @pick.to_json }
        else
          # TODO: error msg
        end
      else
        @pick = Pick.update(@current_pick[0].id, pick: params[:pick][:pick], away_home: params[:pick][:away_home])
        format.json { render json: @pick.to_json }
      end
    end
  end

  def tbreak_pick
    @tbreak_pick = @user.picks.where(game_id: params[:pick][:game_id])

    respond_to do |format|
      if @tbreak_pick == []
        @tbreak = Pick.new(user_id: params[:pick][:user_id], game_id: params[:pick][:game_id], tbreak_pts: params[:pick][:tbreak_pts])

        if @tbreak.save
          format.json { render json: @tbreak.to_json }
        else
          # TODO: error msg
        end
      else
        @tbreak = Pick.update(@tbreak_pick[0].id, tbreak_pts: params[:pick][:tbreak_pts])
        format.json { render json: @tbreak.to_json }
      end
    end
  end

  def standings
    @current_week    = Week.last
    @week            = Week.where(locked: true, finalized: true).last
    @standings       = Standing.order(wins: :desc)
    @most_wins       = Standing.order(:wins).last.wins
    @fewest_wins     = Standing.order(:wins).first.wins
    @last_weeks_wins = []

    # TODO: better way? edge case for wk 1
    if @week != nil
      @standings.each_with_index do |st, index|
        games = Game.where(week_id: @week.id)

        @last_weeks_wins[index] = 0

        games.each do |g|
          pick = Pick.where(game_id: g.id, user_id: st.user_id)

          if pick[0] && pick[0].correct == true
              @last_weeks_wins[index] += 1
          end
        end
      end
    end
  end

  def history
    @weeks = Week.where(locked: true, finalized: true)

    @weekly_user_win_total = []

    @weeks.each_with_index do |wk, index|
      games = Game.where(week_id: wk.id)

      @weekly_user_win_total[index] = 0

      games.each do |g|
        pick = Pick.where(game_id: g.id, user_id: current_user.id)

        if pick[0] && pick[0].correct == true
            @weekly_user_win_total[index] += 1
        end
      end
    end
  end

  def archived
    @weeks         = Week.where(locked: true, finalized: true)
    @archived_week = Week.find(params[:week])
    @games         = Game.where(week_id: params[:week]).order(:date, :start_time)

    @weekly_user_win_total = 0

    @picks = {}
    @games.each do |g|
      user_pick = g.picks.where(user_id: current_user.id)

      if user_pick[0]
        @picks[user_pick[0].game_id] = { pick: user_pick[0].pick, correct: user_pick[0].correct }

        if user_pick[0].correct == true
          @weekly_user_win_total += 1
        end

        if user_pick[0].tbreak_pts != nil
          @tbreak_pts = user_pick[0].tbreak_pts
        end
      else
        @picks[g.id] = { pick: 'n/a', correct: false }
      end
    end
  end

private

  def user
    @user = User.find(current_user.id)
  end

end
