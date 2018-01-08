class User < ActiveRecord::Base

  has_many :messages
  has_and_belongs_to_many :chats

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_many :implyfriendships
  has_many :implyfriends, :through => :implyfriendships
  has_many :inverse_implyfriendships, :class_name => "Implyfriendship", :foreign_key => "implyfriend_id"
  has_many :inverse_implyfriends, :through => :inverse_implyfriendships, :source => :user

  before_save :downcase_email
  attr_accessor :remember_token
  validates :name, presence: true, length: {maximum: 50},
            uniqueness: {case_sensitive: false}
  
  #validates_presence_of :name, :message => "用户名不能为空!"
  #validates_length_of :name, :maximum => 50,  :message => "用户名长度不得长于50位字母或数字!"
  #validates_uniqueness_of :name,:case_sensitive => false, :message => "该用户名已存在!"
  #validates_presence_of :password, :message =>"密码不能为空!"
  #validates_length_of :password, :minimum => 6, :message=>"密码长度不得短于6位字母或数字! " 
  #validates_format_of :email, :message => "邮箱格式不正确!", :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  #validates_uniqueness_of :email,:case_sensitive => false, :message => "该邮箱已注册!"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  #1. The ability to save a securely hashed password_digest attribute to the database
  #2. A pair of virtual attributes (password and password_confirmation), including presence validations upon object creation and a validation requiring that they match
  #3. An authenticate method that returns the user when the password is correct (and false otherwise)
  has_secure_password
  # has_secure_password automatically adds an authenticate method to the corresponding model objects.
  # This method determines if a given password is valid for a particular user by computing its digest and comparing the result to password_digest in the database.

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def self.filter_by_type(type)
    User.where("role = :type", type: type)
  end

  def self.none_hidden_users
    User.where("hidden = :type", type: false)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def user_remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def user_forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def user_authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  def self.search(params)
    User.where("users.name LIKE ?", "%#{params[:query]}%")
  end

  def self.search_friends(params, current_user)
    User.all_except(current_user).all_except(current_user.friends).where("users.name LIKE ?", "%#{params[:query]}%")
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def self.all_except(user)
    where.not(id: user)
  end

end
