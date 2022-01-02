# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
  
  validates :name, presence: true, length: { maximum: 24 }

  has_many :monthly_goals, dependent: :destroy
  has_many :weekly_goals, dependent: :destroy
  has_many :tags, dependent: :destroy
end
