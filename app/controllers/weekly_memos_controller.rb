class WeeklyMemosController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy ]

  def create
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    memo = weekly_goal.weekly_memos.create( weekly_memo_params )
    if memo.save
      render status: 200, json: memo
    else
      render status: 500
    end
  end

  def destroy
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    memo = weekly_goal.weekly_memos.find( params[:id] )
    if memo.destroy
      render status: 200
    else
      render statu: 500
    end
  end

  private

    def weekly_memo_params
      params.permit( :memo )
      # params.require( :weekly_memo ).permit( :memo )
    end
end
