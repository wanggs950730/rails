class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
  end

  test "login with valid information" do
    get sessions_login_path
    post sessions_login_path(params: {session: {email: @user.email, password: 'password'}})
    assert_redirected_to controller: :homes, action: :home
    follow_redirect!
    assert_template 'homes/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", rails_chats_path, count: 0
  end
end