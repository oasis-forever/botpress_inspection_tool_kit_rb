module JsonExportor
  def gen_hash_template
    {
      id: '',
      data: {
        action: 'text',
        contexts: [
          'hoge'
        ],
        enabled: true,
        answers: {
          ja: []
        },
        questions: {
          ja: []
        },
        'redirectFlow': '',
        'redirectNode': ''
      }
    }
  end

  def gen_learning_data_arr(csv_path)
    learning_data = []
    hash_template = gen_hash_template
    CSV.foreach(csv_path, headers: true) do |learning_datum|
      if hash_template[:data][:answers][:ja].last == learning_datum['Answers']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
      else
        hash_template = gen_hash_template
        hash_template[:id] = learning_datum['Serial_Nums']
        hash_template[:data][:questions][:ja] << learning_datum['Questions']
        hash_template[:data][:answers][:ja] << learning_datum['Answers']
      end
      hash_template[:data][:questions][:ja].uniq!
      learning_data << hash_template
    end
    learning_data.uniq
  end
end
