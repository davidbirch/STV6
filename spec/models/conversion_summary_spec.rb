# == Schema Information
#
# Table name: conversion_summaries
#
#  id                      :integer          not null, primary key
#  raw_channel_count       :integer
#  final_raw_channel_count :integer
#  starting_channel_count  :integer
#  channels_created        :integer
#  channels_skipped        :integer
#  final_channel_count     :integer
#  raw_program_count       :integer
#  final_raw_program_count :integer
#  starting_program_count  :integer
#  programs_created        :integer
#  programs_skipped        :integer
#  final_program_count     :integer
#  start_datetime          :datetime
#  end_datetime            :datetime
#  conversion_completed    :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'rails_helper'

RSpec.describe ConversionSummary, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:conversion_summary)).to be_valid
  end
    
end
