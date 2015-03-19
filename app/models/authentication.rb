class Authentication < ActiveRecord::Base
  attr_accessor :user_id, :provider, :uid
  belongs_to :user
end