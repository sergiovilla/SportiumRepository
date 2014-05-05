require File.dirname(__FILE__) + '/../test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  def setup
    User.create(:name => 'Usuario Test', :login => 'usuariotest', :email => 'usuariotest@sportium.com',
                :password => 'password', :password_confirmation => 'password')
  end

  test "successful_login" do
    usuariotest = new_session_as(:usuariotest)
    usuariotest.tries_to_go_to_admin
    usuariotest.logs_in_succesfully("usuariotest", "password")
  end

  test "failed_login" do
    usuarioerroneo = new_session_as(:usuarioerroneo)
    usuarioerroneo.tries_to_go_to_admin
    usuarioerroneo.fails_login("usuarioerroneo", "pass")
  end

  private

  module NavegacionTestDSL
    include ERB::Util
    attr_writer :name

    def tries_to_go_to_admin
      get '/admin/ropas'
      assert_response :redirect
      assert_redirected_to '/user_session/new'
    end

    def logs_in_succesfully(login, password)
      post_login(login, password)
      assert_response :redirect
      assert_redirected_to '/admin/ropas'
    end

    def fails_login(login, password)
      post_login(login, password)
      assert_response :success
      assert_template 'user_session/new'
      assert_tag :tag => 'div', :attributes => { :id => 'errorExplanation' }
      assert_tag :tag => 'li', :content => 'Login is not valid'
    end

    private

    def post_login(login, password)
      post '/user_session/create', :user_session => { :login => login, :password => password }
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(NavegacionTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
