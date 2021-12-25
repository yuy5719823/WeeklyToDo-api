class ToDosController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy, :update, :update_flag ]

  def create
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    todo = weekly_goal.to_dos.build( todo_params )
    if todo.save
      render status: 200, json: todo
    else
      render status: 500
    end
  end

  def destroy
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    todo = weekly_goal.to_dos.find( params[:id] )
    if todo.destroy
      render status: 200, json: todo
    else 
      render status: 500
    end
  end

  # ToDoデータの更新
  # 目標と完了フラグ
  def update
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    todo = weekly_goal.to_dos.find( params[:id] )
    if todo.update( todo_params )
      render status: 200
    else
      render status: 500
    end
  end

  # 完了フラグのみ更新
  def update_flag
    weekly_goal = current_user.weekly_goals.find( params[:weekly_goal_id] )
    todo = weekly_goal.to_dos.find( params[:to_do_id] )
    # 完了済みなら未完了へ,未完了なら完了済みへ
    if todo.complete?
      if todo.update( complete_flag: false )
        render status: 200, json: todo
      else
        render status: 500
      end
    else
      if todo.update( complete_flag: true )
        render status: 200, json: todo
      else
        render status: 500
      end
    end
  end

  private

    def todo_params
      # params.permit( :goal, :complete_flag )
      params.require( :todo ).permit( :goal, :complete_flag )
    end

end
