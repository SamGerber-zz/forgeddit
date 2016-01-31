# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token_is_set

  def self.generate_token
    SecureRandom.urlsafe_base64(21)
  end

  def self.find_by_credentials(credentials)
    user = User.find_by(username: credentials[:username])
    user if user && user.is_password?(credentials[:password])
  end

  attr_reader :password

  has_many :moderated_subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    dependent: :destroy

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    dependent: :destroy

  def password=(password)
    @password = String(password)
    self.password_digest = BCrypt::Password.create(@password).to_s
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(String(password))
  end

  def ensure_session_token_is_set
    self.session_token ||= self.class.generate_token
  end

  def reset_session_token!
    self.session_token = self.class.generate_token
    save!
    session_token
  end
end
