# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  email      :string(255)
#  source     :text(65535)
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  
  it "can assign the admin privilege" do
    user = FactoryGirl.create(:valid_user)
    user.assign_admin
    expect(user.admin?).to be true 
  end
  
  it "can remove the admin privilege" do
    user = FactoryGirl.create(:valid_admin_user)
    user.remove_admin
    expect(user.admin?).to be false 
  end
end
