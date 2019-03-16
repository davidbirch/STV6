# == Schema Information
#
# Table name: sports
#
#  id                :bigint(8)        not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  black_flag        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Sport < ActiveRecord::Base
  
  
  extend FriendlyId
  friendly_id :url_friendly_name
  
  has_many :keywords, dependent: :destroy
  has_many :programs, through: :keywords
  has_many :broadcast_events, through: :programs
  
  validates_presence_of :name
  
  validates_uniqueness_of :name
  
  default_scope { order(:name) }
  scope :whitelisted, ->{where(black_flag: false)}
  
  before_save :set_url_friendly_name
    
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

    def event_time_series_data_points_by_day_and_sport
      # the data points for the broadcast events by time series chart
      data_series = Hash.new 0
      data_series = BroadcastEvent.includes(:sport).chronological.group(:'sports.name', :'formatted_local_start_date').references(:sport).count
      data_labels = BroadcastEvent.group(:'formatted_local_start_date').pluck(:'formatted_local_start_date')
      data_series_names = Sport.pluck(:name)

      return data_labels, data_series_names, data_series
    end

  end

  protected
    def set_url_friendly_name
      self.url_friendly_name = name.parameterize
    end 

end
