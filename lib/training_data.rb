require_relative './modules/format'

class TrainingData
  extend Format

  attr_reader :json

  def initialize(training_data)
    @json = Format.to_json(training_data)
  end

  def export(path)
    File.open(path, 'w') { |f| f.write(json) }
  end
end
