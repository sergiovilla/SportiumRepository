#encoding: utf-8

require 'test_helper'

class ForoTest < ActionDispatch::IntegrationTest
  
  test "foro" do
    sergio = new_session_as(:sergio)
    felipe = new_session_as(:felipe)
    post = sergio.post_to_foro :post => {
    	:nombre => 'Troyan',
    	:subject => 'DownTime',
    	:texto => 'Sportium está down'
    }
    felipe.view_foro
    sergio.view_foro

    felipe.view_post post
    felipe.reply_to_post(post, :post => {
    	:nombre => 'Felipe',
    	:subject => 'Mierda!',
    	:texto => 'Foro HORRIBLE!!'
    	})
  end

  private

  module ForoTestDSL
  	attr_writer :nombre

  	def post_to_foro(params)
  		get "/foro/post"
  		assert_response :success
  		assert_template "foro/post"

  		post "/foro/create", params

  		assert_response :redirect
  		follow_redirect!
  		assert_response :success
  		assert_template "foro/index"
  		return Post.find_by_subject(params[:post][:subject])
  	end

  	def view_foro
  	  get "/foro"

  	  assert_response :success
  	  assert_template "foro/index"
  	  assert_tag :tag => 'h2', :content => 'Foro'
  	  assert_tag :tag => 'a', :content => 'Nuevo Post'
  	end

  	def view_post(post)
  	  get "/foro/post/#{post.id}"

  	  assert_response :success
  	  assert_template "foro/show"
  	end

  	def reply_to_post(post, params)
  	  get "foro/post/#{post.id}/reply"

  	  assert_response :success

  	  post "foro/create", params
  	  follow_redirect!
  	  assert_response :success
  	  assert_template "foro/index"
  	  assert_tag 'a', :content => post.subject
  	end

  end

  def new_session_as(nombre)
  	open_session do |session|
  		session.extend(ForoTestDSL)
  		session.nombre = nombre
  		yield session if block_given?
  	end
  end
end
