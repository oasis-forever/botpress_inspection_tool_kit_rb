module FileHandler
  def write_json(path, hash)
    File.open(path, 'w') do |f|
      JSON.dump(hash, f)
    end
  end
end
