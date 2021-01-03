require_relative '../lib/json_converter'

json_converter = JsonConverter.new('../csv/learning_data.csv', '../json/learning_data.json')
json_converter.csv_to_hash
puts "\n========================================================================="
puts "Loading CSV file: {}: #{json_converter.csv_path}"
json_converter.hash_to_json
puts "CSV file has successfully been loaded"
puts "\n========================================================================="
puts "JSON file has successfully been exported: #{json_converter.json_path}"
puts "The number of Q&A: #{json_converter.obj.dig(:learning_data).size}"
