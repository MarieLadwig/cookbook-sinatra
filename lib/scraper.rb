require_relative 'recipe.rb'
require 'nokogiri'
require 'open-uri'

class Scraper
  def initialize(keyword)
    @keyword = keyword
    @suggestions = []
    @url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword.downcase}"
    @doc = Nokogiri::HTML(open(@url))
  end

  def obtain_scraped_info
    @doc.search('.m_contenu_resultat').each do |element|
      name = element.search('.m_titre_resultat a').text.strip
      description = element.search('.m_texte_resultat').text.strip
      difficulty_long_text = element.search('.m_detail_recette').text.strip
      difficulty = difficulty_long_text.split(" - ")[2]
      prep_time_long = element.search('.m_detail_time').text.strip
      prep_time = string_prep_time(prep_time_long)
      @suggestions << Recipe.new(name, description, difficulty, prep_time)
    end
    @suggestions[0...5]
  end

  private

  def string_prep_time(time_array)
    if time_array[1].nil?
      prep_time = "n/a"
    elsif time_array.split[3].nil?
      prep_time = "#{time_array.split[1]} min"
    else
      prep_time = "#{time_array.split[1]} min (+ #{time_array.split[3]} min in the oven)"
    end
    prep_time
  end
end
