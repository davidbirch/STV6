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

FactoryGirl.define do
  factory :conversion_summary do
    raw_channel_count 1
    final_raw_channel_count 1
    starting_channel_count 1
    channels_created 1
    channels_skipped 1
    final_channel_count 1
    raw_program_count 1
    final_raw_program_count 1
    starting_program_count 1
    programs_created 1
    programs_skipped 1
    final_program_count 1
    conversion_completed false
  end

end
