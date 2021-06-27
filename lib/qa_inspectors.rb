require 'net/http'
require 'json'
require 'csv'
require_relative './modules/chart'
require_relative './modules/converse_api'

class QaInspectors
  extend Chart
  extend ConverseApi

  attr_reader :test_data, :url, :req, :res

  def initialize(scheme:, host:, bot_id:, user_id:, test_data:)
    @url, @req = ConverseApi.set_request(scheme, host, bot_id, user_id)
    @test_data = test_data
  end

  def export(path)
    CSV.open(path, 'w') do |csv|
      test_csv = CSV.read(test_data, headers: true)
      csv << Chart.set_header(test_csv['Serial_Nums'])
      answers_arr = test_csv['Answers']
      test_csv.each do |row|
        @res = ConverseApi.get_response(url: url, req: req, text: row['Questions'])
        csv << Chart.set_row(row, answers_arr, res.body)
      end
    end
  end
end
