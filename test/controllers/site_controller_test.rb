require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    # @site = site(:one)
  end

  test "should get index" do
    assert_generates '/', :controller => "site", :action => "index"
  end

  test "should get current_week" do
    assert_generates '/site/current_week', :controller => "site", :action => "current_week"
  end

  test "should get standings" do
    assert_generates '/site/standings', :controller => "site", :action => "standings"
  end

  test "should get history" do
    assert_generates '/site/history', :controller => "site", :action => "history"
  end

  test "should get archived" do
    assert_generates '/site/archived', :controller => "site", :action => "archived"
  end

end
