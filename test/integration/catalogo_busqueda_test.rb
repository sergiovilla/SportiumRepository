require 'test_helper'

class CatalogoBusquedaTest < ActionDispatch::IntegrationTest

  def latest_ropa
    get 'catalog/latest'
    assert_response :success
    assert_template 'catalog/latest'
    assert_tag :tag => 'dl', :attributes => { :id => 'ropa' },
               :children => { :count => 5, :only => { :tag => 'dt' } }
    @ropa = ropa.latest(5)
    @ropa.each do |a|
      assert_tag :tag => 'dt', :content => a.title
    end
  end


end
