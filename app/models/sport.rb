# == Schema Information
#
# Table name: sports
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  url_friendly_name :string(255)
#

class Sport < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }

  before_save :set_url_friendly_name
  
  class << self
    
    def find_for_raw_program(raw_program)
      
      # pseudocode for finding the sport based on a raw program
      #
      # - if a black keyword is present return no sport
      # - else if there is a sport name match return the Sport
      # - else if there is a sport keyword match return the Sport
      # - else check for a generic 'sport' keyword match and return 'Other Sport' unless there is a news or weather match
      
      # check for a black keyword
      if black_keyword_match(raw_program)
        # black keyword match so return nil
        return nil
      else
        # check for a sport name match
        sport = check_sport_name_match(raw_program)
        return sport unless sport.nil?
        # check for a sport keyword match
        sport = check_sport_keyword_match(raw_program)
        return sport unless sport.nil?
        # check for a generic sport match ex news/weather
        sport = check_generic_sport_match(raw_program)
        return sport unless sport.nil?
      end
      return nil
    end
    
    def black_keyword_match(raw_program)
      # no black keywords yet so return false
      return false
    end
    
    def check_sport_name_match(raw_program)
      raw_program_title = raw_program["title"].downcase
      raw_program_subtitle = raw_program["subtitle"].downcase
      raw_program_category = raw_program["category"].downcase
      list_of_sport_names =  Sport.pluck(:name).map(&:downcase).sort_by(&:length).reverse
      
      list_of_sport_names.each do |sport_name|
        if sport_name.include? " "
          # the sport_name contains a space so it has multiple words
          # use the include? method
          if raw_program_title.include? sport_name
            return Sport.find_by_name(sport_name)
          elsif raw_program_subtitle.include? sport_name
            return Sport.find_by_name(sport_name)
          elsif raw_program_category.include? sport_name
            return Sport.find_by_name(sport_name)
          end  
        else
          # the sport_name contains no space so it has only one word
          # use a standard include search
          raw_program_title.split.each do |s|
            return Sport.find_by_name(sport_name) if s == sport_name
          end
          raw_program_subtitle.split.each do |s|
            return Sport.find_by_name(sport_name) if s == sport_name
          end
          raw_program_category.split.each do |s|
            return Sport.find_by_name(sport_name) if s == sport_name
          end
        end
      end
      return nil
    end  
    
    def check_sport_keyword_match(raw_program)
      return nil
    end
     
    def check_generic_sport_match(raw_program)
      raw_program_title = raw_program["title"].downcase
      raw_program_subtitle = raw_program["subtitle"].downcase
      raw_program_category = raw_program["category"].downcase
      
      if raw_program_title.include?("sport") || raw_program_subtitle.include?("sport") || raw_program_category.include?("sport")
        if raw_program_category.include?("news") || raw_program_category.include?("weather")
          return nil
        else
          return Sport.find_by_name("Other Sport")
        end
      end
      return nil
    end
   
  end
  
  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
