# class User < ApplicationRecord
#     validates (:name, presence: true), length: { maximum: 50 }
#     validates (:email, presence: true), length: { maximum: 255 }
# end

class User < ApplicationRecord
  has_many :bugs, dependent: :destroy
  has_many :comments
  # attr_accessor : remember_token, :activation_token
  before_save :downcase_email
  # before_create :create_activation_digest

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: {
              maximum: 255
            },
            format: {
              with: VALID_EMAIL_REGEX
            }
  # uniqueness: true
  # uniqueness: case_sensitive: false
  # uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  enum role: { manager: 1, qa: 2, developer: 3 }

  private

  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  # # Creates and assigns the activation token and digest.
  # def create_activation_digest
  #     self.activation_token = User.new_token
  #     self.activation_digest = User.digest(activation_token)
  # end
end
