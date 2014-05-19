require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  test "create_post_and_reply"  do
  	post = Post.new(:nombre => 'Sergio', 
  		            :subject => 'Subject',
  		            :texto => 'Texto')

  	assert post.save
  	assert_not_nil Post.find_by_nombre('Sergio')

  	reply = Post.new(:nombre => 'Felipe',
  		             :subject => 'Respuesta',
  		             :texto => 'Texto respuesta',
  		             :parent_id => post.id)

  	assert reply.save
  	assert reply.child?

  	post.reload

  	assert post.root?
  	assert_equal 1, post.all_children.size
  	assert_equal reply, post.all_children()[0]
  end
end
