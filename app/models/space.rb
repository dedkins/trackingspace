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
