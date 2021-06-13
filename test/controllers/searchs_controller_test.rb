# frozen_string_literal: true

require 'test_helper'

class SearchsControllerTest < ActionDispatch::IntegrationTest
  test 'should get Search' do
    get searchs_Search_url
    assert_response :success
  end
end
