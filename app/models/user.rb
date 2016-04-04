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

class User < ActiveRecord::Base
  
  def assign_admin
    self.update(admin: true)
  end

  def remove_admin
    self.update(admin: false)
  end
    
  class << self
  
    def from_omniauth(auth)
      where(provider: auth["provider"], uid: auth["uid"]).first || create_from_omniauth(auth)
    end
    
    def create_from_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.nickname = auth["info"]["nickname"]
        user.image = auth["info"]["image"]
        user.source = auth
        user.admin = false
      end
    end
  end
end
