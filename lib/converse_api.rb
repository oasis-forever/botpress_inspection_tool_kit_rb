require 'net/http'
require 'json'
require 'csv'
require_relative './concerns/matrix_exporter'
require_relative './concerns/api_caller'

class ConverseApi
  include MatrixExportor
  include ApiCaller

  attr_reader :url, :req, :res

  def initialize(protocol, host, bot_id, user_id)
    @url, @req = authenticate(protocol, host, bot_id, user_id)
  end

  def export_csv(matrix_chart, test_data)
    CSV.open(matrix_chart, 'w') do |csv|
      test_data = CSV.read(test_data, headers: true)
      csv << set_header(test_data['Serial_Nums'])
      answers_arr = test_data['Answers']
      test_data.each do |test_datum|
        @res = get_api_response(test_datum['Questions'], url, req)
        csv << set_row(test_datum, answers_arr, res.body)
      end
    end
  end
end
