class Recipe
  attr_accessor :name, :description, :difficulty, :prep_time, :read

  def initialize(name, description, difficulty, prep_time)
    @name = name
    @description = description
    @difficulty = difficulty
    @prep_time = prep_time
    @read = false
  end
end
