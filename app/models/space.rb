# == Schema Information
#
# Table name: spaces
#
#  id          :integer          not null, primary key
#  sf          :integer
#  monthly     :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  building_id :integer
#  suite       :string(255)
#  user_id     :integer
#  company     :string(255)
#  status      :string(255)
#  _3dplanurl  :string(255)
#

class Space < ActiveRecord::Base
  belongs_to :building
  has_many :leases, :dependent => :destroy
  has_many :microposts, :dependent => :destroy

  attr_accessible :monthly, :sf, :suite, :company, :status, :_3dplanurl  
  
  def feed
    Micropost.where("space_id = ?", id)
  end

  default_scope :order => 'spaces.suite ASC'
end
