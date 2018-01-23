require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(name: "Example User",sex:"male", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "@user should be valid" do
    assert  @user.valid?
  end
  
  test "name should be present" do
    @user.name=" "
    assert_not @user.valid?
  end
    
  test "email validation should accepte valid addresses" do
    valid_addresses = %w[user@exampel.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
 #密码测试 
  def setup
    @user = User.new(name: "user",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end
  
end
