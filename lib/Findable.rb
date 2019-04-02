module Concerns::Findable

  def find_by_name(song)
    self.all.detect { |instance| instance.name == song }
  end

  def find_or_create_by_name(song)
    find_by_name(song) || create(song)
  end

end
