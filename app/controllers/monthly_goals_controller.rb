class MonthlyGoalsController < ApplicationController

  before_action :authenticate_user!, only: [ :index, :create, :destroy, :update]

  def index
    if monthly_goals = current_user.monthly_goals.all
      monthly_goals_array = monthly_goals.map do | goal |
        {
          id:         goal.id,
          goal:       goal.goal,
          created_at: goal.created_at,
          updated_at: goal.updated_at,
          memo:       goal.monthly_memos,
        }
      end
      render status: 200, json: monthly_goals_array
    end
  end

  def create
    monthly_goal = current_user.monthly_goals.new( monthly_goal_params )
    if monthly_goal.save
      render status: 200, json: monthly_goal
    else
      render status: 500
    end
  end

  def destroy
    monthly_goal = current_user.monthly_goals.find( params[:id] )
    if monthly_goal.destroy
      render status: 200
    else
      render status: 500
    end
  end

  def update
    monthly_goal = current_user.monthly_goals.find( params[:id] )
    if monthly_goal.update( monthly_goal_params )
      render status: 200, json: monthly_goal
    else
      render status: 500
    end
  end

  private

    def monthly_goal_params
      # params.permit( :goal )
      params.require( :monthly_goal ).permit( :goal )
    end

end
