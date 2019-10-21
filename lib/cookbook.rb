require 'csv'
require_relative 'recipe.rb'

class Cookbook
  def initialize(csv_file_path = nil)
    @csv_file_path = csv_file_path
    @recipes = []
    unless @csv_file_path.nil?
      CSV.foreach(csv_file_path) do |row|
        @recipes << Recipe.new(row[0], row[1], row[2], row[3])
      end
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save(@recipes)
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save(@recipes)
  end

  def mark_recipe_as_read(given_index)
    selected_recipe = @recipes.select.with_index do |_recipe, index|
      index == given_index - 1
    end
    selected_recipe[0].read = true
    save(@recipes)
  end

  private

  def save(array_recipes)
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    unless @csv_file_path.nil?
      CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
        array_recipes.each do |instance|
          csv << [instance.name, instance.description, instance.difficulty, instance.prep_time, instance.read]
        end
      end
    end
  end
end
