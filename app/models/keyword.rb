# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  sport_id           :integer
#  priority           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  url_friendly_value :string(255)
#

class Keyword < ActiveRecord::Base
  
  belongs_to :sport
  has_many :programs
  
  extend FriendlyId
  friendly_id :url_friendly_value
  
  validates_presence_of :value, :sport_id, :priority
  
  validates_uniqueness_of :value
  
  before_save :set_url_friendly_value
  
  class << self
    
    def find_for_raw_program(raw_program)
      
      # pseudocode for finding the sport based on a raw program
      #
      # - if a black keyword is present return no sport
      # - else if there is a sport keyword match return the Sport
      # - else check for a generic 'sport' keyword match and return 'Other Sport' unless there is a news or weather match
      
      # check for a black keyword
      if black_keyword_match(raw_program)
        # black keyword match so return nil
        return nil
      else
        # check for a sport keyword match
        sport_keyword = check_sport_keyword_match(raw_program)
        return sport_keyword unless sport_keyword.nil?
        # check for a generic sport match ex news/weather
        sport_keyword = check_generic_sport_match(raw_program)
        return sport_keyword unless sport_keyword.nil?
      end
      return nil
    end
    
    def black_keyword_match(raw_program)
      # no black keywords yet so return false
      return false
    end
        
    def check_sport_keyword_match(raw_program)
      raw_program_title = raw_program["title"].downcase
      raw_program_subtitle = raw_program["subtitle"].downcase
      raw_program_category = raw_program["category"].downcase
      list_of_sport_keywords = Keyword.order("priority DESC, length(value) DESC").pluck(:value).map(&:downcase)
         
      list_of_sport_keywords.each do |sport_keyword|
        if sport_keyword.include? " "
          # the sport_name contains a space so it has multiple words
          # use the include? method
          if raw_program_title.include? sport_keyword
            return Keyword.find_by_value(sport_keyword)
          elsif raw_program_subtitle.include? sport_keyword
            return Keyword.find_by_value(sport_keyword)
          elsif raw_program_category.include? sport_keyword
            return Keyword.find_by_value(sport_keyword)
          end  
        else
          # the sport_name contains no space so it has only one word
          # use a standard include search
          raw_program_title.split.each do |s|
            return Keyword.find_by_value(sport_keyword) if s.gsub(/\W+/, '') == sport_keyword
          end
          raw_program_subtitle.split.each do |s|
            return Keyword.find_by_value(sport_keyword) if s.gsub(/\W+/, '') == sport_keyword
          end
          raw_program_category.split.each do |s|
            return Keyword.find_by_value(sport_keyword) if s.gsub(/\W+/, '') == sport_keyword
          end
        end
      end
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
          return Keyword.find_by_value("Other Sport")
        end
      end
      return nil
    end
   
  end
  
  protected
    def set_url_friendly_value
      self.url_friendly_value = value.parameterize
    end 
  
end
