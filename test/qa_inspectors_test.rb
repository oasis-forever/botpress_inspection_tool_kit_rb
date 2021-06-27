require 'minitest/autorun'
require 'json'
require 'csv'
require_relative '../lib/qa_inspectors'
require_relative '../lib//modules/format'

class QaInspectorsTest < Minitest::Test
  def setup
    @qa_inspector = QaInspectors.new(
      scheme: 'https',
      host: 'oasist-botpress-server.herokuapp.com',
      bot_id: 'sample-bot',
      user_id: 'oasist',
      test_data: '../csv/test_data.csv'
    )
    @path = "../csv/#{Format.matrix_filename}"
    @qa_inspector.export(@path)
  end

  def test_status_code
    assert_equal '200', @qa_inspector.res.code
  end

  def test_has_state_key?
    assert_equal true, JSON.parse(@qa_inspector.res.body).key?('state')
  end

  def test_has_suggestions_key?
    assert_equal true, JSON.parse(@qa_inspector.res.body).key?('suggestions')
  end

  def test_export_csv
    test_rows_num = CSV.read(@qa_inspector.test_data, headers: true)['Serial_Nums'].size
    matrix_rows_num = CSV.read(@path, headers: true)['Serial_Nums'].size
    assert_equal test_rows_num, matrix_rows_num
  end
end
