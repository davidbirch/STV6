# == Schema Information
#
# Table name: keywords
#
#  id                 :bigint(8)        not null, primary key
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

  def count_of_words_in_program_full_titles
    counts = Hash.new 0
    entries = programs.pluck(
      :'title',
      :'episode_title'
      )
    entries.each do |entry|
      (entry[0] + entry[1]).split(/\W+/).each do |word|
        counts[word] += 1
      end
    end   
    counts  
  end

  def truncated_and_sorted_count_of_words_in_program_full_titles
    count_of_words_in_program_full_titles.delete_if {|word, count| count < 5 or word.length == 1}.sort_by { |word, count| count }.reverse!
  end
  
  class << self
    
    def find_based_on_title(attr_program_title,attr_episode_title)
      
      # the non-sport keyword
      non_sport_keyword = Keyword.find_by_value("Non sport")

      # if there is a sport keyword match return the Sport
      sport_keyword = check_sport_keyword_match(attr_program_title,attr_episode_title)
      if sport_keyword.nil?
        return non_sport_keyword
      else
        return sport_keyword
      end
         
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
   
  end
  
  protected
    def set_url_friendly_value
      self.url_friendly_value = value.parameterize
    end
  
end
