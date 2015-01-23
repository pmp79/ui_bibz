require 'test_helper'
require 'will_paginate'

include WillPaginate::ActionView
class StoreTest < ActionView::TestCase

  setup do
    create_list(:user, 25)
    users   = User.paginate(page: 1, per_page: 10)
    @store  = UiBibz::Ui::Store.new users
    #will_paginate users, params: { controller: 'users'}
  end

  test 'total pages' do
    assert_equal @store.total_pages, 3
  end

  test 'current page' do
    assert_equal @store.current_page, 1
  end

  test 'limit value' do
    assert_equal @store.limit_value, 10
  end

  test 'model' do
    assert_equal @store.model, 'User'
  end

end