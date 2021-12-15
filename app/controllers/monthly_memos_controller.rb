class MonthlyMemosController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy, :update]

  def create
    monthly_goal = current_user.monthly_goals.find( params[:monthly_goal_id] )
    memo = monthly_goal.monthly_memos.build( monthly_memo_params )
    if memo.save
      render status: 200, json: memo
    else
      render status: 500
    end
  end

  def destroy
    #不必要なSQL文が発行されていないか
    memo = current_user.monthly_goals.find( params[:monthly_goal_id] ).monthly_memos.find( params[:id])
    if memo.destroy
      render status: 200
    else
      render status: 500
    end
  end

  def update
    memo = current_user.monthly_goals.find( params[:monthly_goal_id] ).monthly_memos.find( params[:id])
    if memo.update( monthly_memo_params )
      render status: 200
    else
      render status: 500
    end
  end

  private

    def monthly_memo_params
      # params.permit( :memo )
      params.require( :monthly_memo ).permit( :memo )
    end

end
