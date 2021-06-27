require 'minitest/autorun'
require 'csv'
require 'json'
require_relative '../lib/training_data'
require_relative '../lib//modules/format'

class TrainingDataTest < Minitest::Test
  def setup
    @training_data = TrainingData.new('../csv/training_data.csv')
    @qnas = JSON.parse(@training_data.json)
  end

  def test_json_presence
    path = "../json/#{Format.json_filename}"
    @training_data.export(path)
    assert_equal true, File.exist?(path)
  end

  def test_number_of_training_data
    assert_equal CSV.read('../csv/training_data.csv', headers: true)['Serial_Nums'].uniq!.size, @qnas.dig('qnas').size
  end

  def test_qa_num
    assert_equal 'QA001', @qnas.dig('qnas').first.dig('id')
  end

  def test_questions
    assert_equal 'GitHubとは何ですか', @qnas.dig('qnas').first.dig('data').dig('questions').dig('ja')[0]
    assert_equal 'GitHubとはどんなシステムか', @qnas.dig('qnas').first.dig('data').dig('questions').dig('ja')[1]
    assert_equal 'GitHubって何', @qnas.dig('qnas').first.dig('data').dig('questions').dig('ja')[2]
    assert_equal 'GitHubってなに', @qnas.dig('qnas').first.dig('data').dig('questions').dig('ja')[3]
  end

  def test_answers
    assert_equal 'ソフトウェア開発のプラットフォームであり、ソースコードをホスティングする。コードのバージョン管理システムにはGitを使用します。', @qnas.dig('qnas').first.dig('data').dig('answers').dig('ja')[0]
  end
end
