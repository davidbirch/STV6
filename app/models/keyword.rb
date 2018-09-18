# == Schema Information
#
# Table name: keywords
#
#  id                 :integer          not null, primary key
#  value              :string(255)
#  url_friendly_value :string(255)
#  sport_id           :integer
#  priority           :integer
#  black_flag         :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Keyword < ActiveRecord::Base
  
  belongs_to :sport
  has_many :programs, dependent: :destroy
  has_many :broadcast_events, through: :programs
  
  extend FriendlyId
  friendly_id :url_friendly_value
  
  validates_presence_of :value, :sport_id, :priority
  
  validates_uniqueness_of :value
  
  before_save :set_url_friendly_value
  
  class << self
    
    def find_based_on_title(attr_program_title,attr_episode_title)
      
      # if there is a sport keyword match return the Sport
      sport_keyword = check_sport_keyword_match(attr_program_title,attr_episode_title)
      return sport_keyword unless sport_keyword.nil?
      
      # else check for a generic 'sport' keyword match and return 'Other Sport'
      sport_keyword = check_generic_sport_match(attr_program_title,attr_episode_title)
      return sport_keyword unless sport_keyword.nil?
   
    end
        
    def check_sport_keyword_match(attr_program_title,attr_episode_title)
      list_of_sport_keywords = Keyword.order("priority DESC, length(value) DESC").pluck(:value).map(&:downcase)
         
      list_of_sport_keywords.each do |sport_keyword|
        if attr_program_title.downcase.include? sport_keyword
          return Keyword.find_by_value(sport_keyword)
        elsif attr_episode_title.downcase.include? sport_keyword
          return Keyword.find_by_value(sport_keyword)
        end  
      end
      return nil
    end
     
    def check_generic_sport_match(attr_program_title,attr_episode_title)
      if attr_program_title.downcase.include?("sport") || attr_episode_title.downcase.include?("sport")
        return Keyword.find_by_value("Other Sport")
      end
      return nil
    end
   
  end
  
  protected
    def set_url_friendly_value
      self.url_friendly_value = value.parameterize
    end
  
end
