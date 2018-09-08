# == Schema Information
#
# Table name: programs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  episode_title :string(255)
#  keyword_id    :integer
#  duration      :integer
#  black_flag    :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Program < ActiveRecord::Base
  
  belongs_to :keyword
  has_many :broadcast_events
    
  validates_presence_of :title
  validates_presence_of :keyword_id
  validates_presence_of :duration
  validates_uniqueness_of :title , :scope => [:episode_title, :duration]
  
  def formatted_full_title
    if episode_title != ""
      title + " (" + episode_title + ")"
    else
      title
    end
  end
    
  class << self
    
    def create_from_raw_program(raw_program, broadcast_service)
      
      if raw_program.placeholder?
        # do nothing
        
      else 
        if broadcast_service
          attr_program_hash = eval(raw_program.program_hash)
          attr_program_title = attr_program_hash["programTitle"]
          attr_episode_title = attr_program_hash["episodeTitle"]                  
          attr_duration = attr_program_hash["duration"]                  
              
          # if nil then default to an empty string
          attr_program_title ||= ""
          attr_episode_title ||= ""
          attr_duration      ||= 0
              
          # get the keyword ...?
          keyword = Keyword.find_based_on_title(attr_program_title,attr_episode_title)
                
          Program.create(
            :title                  => attr_program_title,
            :episode_title          => attr_episode_title,
            :duration               => attr_duration,
            :keyword_id             => (keyword.id unless keyword.nil?),
          )        
                      
        else
          # no broadcast service
              
        end          
      end
    end

  end
    
end
