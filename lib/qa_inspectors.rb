require 'net/http'
require 'json'
require 'csv'
require_relative './modules/chart'
require_relative './modules/converse_api'

class QaInspectors
  extend Chart
  extend ConverseApi

  attr_reader :url, :req, :res

  def initialize(scheme:, host:, bot_id:, user_id:)
    @url, @req = ConverseApi.set_request(scheme, host, bot_id, user_id)
  end

  def export_csv(matrix_chart, test_data)
    CSV.open(matrix_chart, 'w') do |csv|
      test_data = CSV.read(test_data, headers: true)
      csv << Chart.set_header(test_data['Serial_Nums'])
      answers_arr = test_data['Answers']
      test_data.each do |test_datum|
        @res = ConverseApi.get_response(url: url, req: req, text: test_datum['Questions'])
        csv << Chart.set_row(test_datum, answers_arr, res.body)
      end
    end
  end
end
