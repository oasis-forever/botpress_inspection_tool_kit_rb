require 'minitest/autorun'
require 'csv'
require_relative '../lib/json_converter'

class JsonConverterTest < Minitest::Test
  def setup
    csv_path        = '../csv/learning_data.csv'
    json_path       = '../json/learning_data.json'
    @json_converter = JsonConverter.new(csv_path, json_path)
    @json_converter.csv_to_hash
    @first_qna = @json_converter.obj.dig(:qnas).first
  end

  def test_number_of_learning_data
    assert_equal CSV.read(@json_converter.csv_path, headers: true)['Serial_Nums'].uniq!.size, @json_converter.obj.dig(:qnas).size
  end

  def test_qa_num
    assert_equal 'QA001', @first_qna.dig(:id)
  end

  def test_questions
    assert_equal 'GitHubとは何ですか', @first_qna.dig(:data).dig(:questions).dig(:ja)[0]
    assert_equal 'GitHubとはどんなシステムか', @first_qna.dig(:data).dig(:questions).dig(:ja)[1]
    assert_equal 'GitHubって何', @first_qna.dig(:data).dig(:questions).dig(:ja)[2]
    assert_equal 'GitHubってなに', @first_qna.dig(:data).dig(:questions).dig(:ja)[3]
  end

  def test_answers
    assert_equal 'ソフトウェア開発のプラットフォームであり、ソースコードをホスティングする。コードのバージョン管理システムにはGitを使用します。', @first_qna.dig(:data).dig(:answers).dig(:ja)[0]
  end

  def test_json_presence
    @json_converter.hash_to_json
    assert_equal true, File.exist?(@json_converter.json_path)
  end
end
