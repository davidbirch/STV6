# == Schema Information
#
# Table name: providers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  url_friendly_name :string(255)
#  service_tier      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe Provider, type: :model do
  
  it "has a valid factory" do
    expect(FactoryGirl.create(:provider)).to be_valid
  end
  
  it "is invalid without a name" do
    expect(FactoryGirl.build(:provider, name: nil)).to validate_presence_of(:name)
  end
 
  it "is invalid without a unique name" do
    expect(FactoryGirl.build(:provider)).to validate_uniqueness_of(:name)
  end
  
  it "sets a url friendly name" do
    @provider = FactoryGirl.create(:provider)
    expect(@provider.url_friendly_name).to eq(@provider.name.parameterize)
  end
  
  it "should have many channels" do
    expect(FactoryGirl.build(:provider)).to have_many(:channels)
  end
  
  it "can be found by the friendly id" do
    @provider = FactoryGirl.create(:provider)
    expect(Provider.find(@provider.id)).to eq(@provider)
    expect(Provider.friendly.find(@provider.id)).to eq(@provider)
    expect(Provider.friendly.find(@provider.url_friendly_name)).to eq(@provider)
  end
  
  describe "sort in alphabetical order by default" do
  
    context "where the providers are created in the correct sequence" do
      it "should be in alphabetical order by default" do
          @another_provider = FactoryGirl.create(:another_provider)
          @freeview_provider = FactoryGirl.create(:freeview_provider)
          providers = Provider.all
          expect(providers.count).to eq(2)
          expect(providers.first).to eq(@another_provider)
      end
    end
    
    context "where the providers are created in the correct sequence" do
      it "should be in alphabetical order by default" do
          @freeview_provider = FactoryGirl.create(:freeview_provider)
          @another_provider = FactoryGirl.create(:another_provider)
          providers = Provider.all
          expect(providers.count).to eq(2)
          expect(providers.first).to eq(@another_provider)
      end
    end
  end
  
end
