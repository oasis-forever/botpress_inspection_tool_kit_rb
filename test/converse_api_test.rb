require 'minitest/autorun'
require 'json'
require 'csv'
require_relative '../lib/converse_api'
require_relative '../lib/concerns/matrix_exporter'

class ConverseApiTest < Minitest::Test
  def setup
    protocol      = 'https'
    host          = 'oasist-botpress-server.herokuapp.com'
    bot_id        = 'sample-bot'
    user_id       = 'oasist'
    @converse_api = ConverseApi.new(protocol, host, bot_id, user_id)
    @matrix_chart = "../csv/matrix_chart_#{Time.now.strftime("%Y%m%d")}.csv"
    @test_data    = '../csv/test_data.csv'
    @converse_api.export_csv(@matrix_chart, @test_data)
  end

  def test_status_code
    assert_equal '200', @converse_api.res.code
  end

  def test_has_state_key?
    assert_equal true, JSON.parse(@converse_api.res.body).key?('state')
  end

  def test_has_suggestions_key?
    assert_equal true, JSON.parse(@converse_api.res.body).key?('suggestions')
  end

  def test_export_csv
    test_rows_num   = CSV.read(@test_data, headers: true)['Serial_Nums'].size
    matrix_rows_num = CSV.read(@matrix_chart, headers: true)['Serial_Nums'].size
    assert_equal test_rows_num, matrix_rows_num
  end
end
