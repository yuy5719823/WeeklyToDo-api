class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    if tags_data
      render status: 200, json: tags_data
    else
      render status: 500
    end
  end

  # 週の目標の設定と同時にタグの生成、紐付けはできるか
  # 現状、タグ作成　-> 週の目標と紐付ける　流れ
  # ここではあくまでもタグの生成のみ
  def create
    if tag = current_user.tags.create( tag_params )
      p tag.errors.full_messages
      render status: 200, json: tags_data
    else
      render status: 500
    end
  end

  def update
    tag = current_user.tags.find( params[:id] )
    if tag.update( tag_params )
      render status: 200, json: tags_data
    else
      render status: 500
    end
  end

  def destroy
    tag = current_user.tags.find( params[:id] )
    if tag.destroy
        render status: 200, json: tags_data
    else
      render status: 500
    end
  end


  private

    def tag_params
      params.permit(:name)
      # params.require(:tag).permit(:name)
    end


    def tags_data
      current_user.tags.map do | tag |
        {
          id:   tag.id,
          name: tag.name
        }
      end
    end

end
