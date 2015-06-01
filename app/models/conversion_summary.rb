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
#  conversion_completed    :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class ConversionSummary < ActiveRecord::Base
end
