class Bug < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  enum status: { pending: "pending", started: "started", fixed: "fixed" }
end
