class View
  def display_recipe_long(recipe)
    puts "#{recipe.name} - #{recipe.description} (Difficulty: #{recipe.difficulty}, prep time: #{recipe.prep_time})."
  end

  def display_list_reduced(recipes)
    recipes.each_with_index do |recipe, index|
      puts "Recipe no. #{index + 1}: #{read?(recipe)} #{recipe.name}"
    end
  end

  def ask_for_index
    puts "Which recipe number do you want to delete?"
    gets.chomp.to_i - 1
  end

  def ask_for_name
    puts "What is the name of your recipe?"
    gets.chomp
  end

  def ask_for_description
    puts "How would you describe your recipe?"
    gets.chomp
  end

  def ask_for_difficulty
    puts "What is the level of difficulty?"
    gets.chomp
  end

  def ask_for_prep_time
    puts "How long does it take to prepare the dish?"
    gets.chomp
  end

  def ask_for_ingredient
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end

  def search_confirmation(ingredient)
    puts "Looking for #{ingredient} on LetsCookFrench"
  end

  def ask_for_search_selection
    puts "Which recipe would you like to import? Please give the index number."
    gets.chomp
  end

  def selection_confirmation(selected_recipe)
    puts "Importing #{selected_recipe.name}."
  end

  def ask_for_recipe_read?
    puts "Which recipe have you read? Please provide index number."
    gets.chomp.to_i
  end

  def read?(recipe)
    if recipe.read == true
      "[X]"
    else
      "[ ]"
    end
  end

  def ask_for_recpie_to_display_detailed
    puts "Which recipe do you want to view?"
    gets.chomp.to_i
  end
end
