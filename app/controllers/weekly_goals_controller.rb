class WeeklyGoalsController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :create, :destroy, :update ]

  def index
    if weekly_goals = this_week_goals
      #取得するデータの情報
      weekly_data = { info: weekly_info }
      #今週分のデータを取得
      weekly_goals_array = weekly_goals.map do | goal |
        {
          id:   goal.id,
          goal: goal.goal,
          created_at: goal.created_at,
          updated_at: goal.updated_at,
        }
      end
      weekly_data[:data] = weekly_goals_array
      render status: 200, json: weekly_data
    else
      render status: 500
    end
  end

  def create
    weekly_goal = current_user.weekly_goals.build( weekly_goal_params )
    if weekly_goal.save
      render status: 200, json: weekly_goal
    else
      render status: 500
    end
  end

  def destroy
    weekly_goal = current_user.weekly_goals.find( params[:id] )
    if weekly_goal.destroy
      render status: 200
    else
      render status: 500
    end
  end

  def update
    weekly_goal = current_user.weekly_goals.find( params[:id] )
    if weekly_goal.update( weekly_goal_params )
      render status: 200, json: weekly_goal
    else
      render status: 500
    end
  end

  private

  def weekly_goal_params
    # params.permit( :goal )
    params.require( :weekly_goal ).permit( :goal )
  end

    #テスト？
    #月をまたいだ週でもその週を取得
    def this_week_goals
      current_user.weekly_goals.where( created_at: Time.now.all_week )
    end

    #いつからいつまでのデータか
    def weekly_info
      this_week = Time.now.all_week
      weeks_info = {
        this_year:  Time.now.year,
        this_month: {
          from: this_week.first.month,
          to:   this_week.last.month
        },
        this_week:  {
          from:  this_week.first.day,
          to:    this_week.last.day
        }
      }
    end

    # #何月の第何週のデータか（月曜始まり）
    # #いつからいつまでのデータか
    #   #2021 12-20 ~ 12-26
    # def weeks_in
    #   day_of_week = { 0 => "日", 1 => "月", 2 => "火", 3 => "水", 4 => "木", 5 => "金", 6 => "土" }
    #   #今月の1日の曜日
    #   month_first_day = Time.now.all_month.first.strtime("%w").to_i
    #   #今週初めの日にち
    #   week_first_day = Time.now.all_week.first.day
    #   #メソッドを実行した日までに、月曜日が何回繰り返されたか
    #   if month_first_day != 1
    #     count_mon = Time.now.day - (  )
    #   else
    #     return 1
    #   end

    #   day = week_first_day + 1
    #   #割り切れない場合、第一週
    #   if day %7 == 
    #   return day / 7
    # end

end
