require 'csv'
require_relative '../lib/converse_api'

protocol      = 'https'
host          = 'oasist-botpress-server.herokuapp.com'
bot_id        = 'sample-bot-1'
user_id       = 'oasist'
matrix_chart  = "../csv/matrix_chart_#{Time.now.strftime("%Y%m%d")}.csv"
test_data     = '../csv/test_data.csv'
learning_data = '../csv/learning_data.csv'

converse_api = ConverseApi.new(protocol, host, bot_id, user_id)
puts "\n========================================================================="
puts "\nExporting Matrix CSV file..."
converse_api.export_csv(matrix_chart, test_data, learning_data)
puts "\n========================================================================="
puts "\nMatrix CSV file has successfully been exported: '#{matrix_chart}'"
