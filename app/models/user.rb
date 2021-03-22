class User < ApplicationRecord

  before_save :format_username

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  has_secure_password

  validates :username, presence: true,
            format: { with: /\A[A-Z0-9]+\z/i,
            message: "only allows alphanumeric characters" },
            uniqueness: { case_sensitive: false }

  validates :name, presence: true
  validates :email, format: { with: /\S+@\S+/ },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, allow_blank: true }

  scope :by_name, -> { order(:name) }
  scope :non_admin, -> { by_name.where(admin: false) }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    username
  end

  private

  def format_username
    self.username = username.downcase
  end

end
