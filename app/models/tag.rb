class Tag < ApplicationRecord
  belongs_to :user

  validates :tag_name, presence: true, length: { maximum: 12 }, uniqueness: { scope: :user }

end
