require 'csv'
require 'json'
require_relative './concerns/json_exporter'
require_relative './concerns/file_handler'

class JsonConverter
  include JsonExportor
  include FileHandler

  attr_reader :csv_path, :json_path, :obj

  def initialize(csv_path, json_path)
    @csv_path  = csv_path
    @json_path = json_path
  end

  def csv_to_hash
    @obj = { qnas: gen_learning_data_arr(@csv_path) }
  end

  def hash_to_json
    write_json(@json_path, @obj)
  end
end
