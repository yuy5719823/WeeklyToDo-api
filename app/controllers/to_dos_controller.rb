class ToDosController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def create
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    todo = weekly_goal.to_dos.build( todo_params )
    if todo.save
      render status: 200, json: todo
    else
      render status: 500
    end
  end

  private

    def todo_params
      # params.permit( :goal )
      params.require( :todo ).permit( :goal )
    end

end
