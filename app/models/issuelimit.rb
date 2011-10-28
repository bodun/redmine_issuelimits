class Issuelimit < ActiveRecord::Base
  unloadable
  has_many :limits, :dependent => :destroy
  accepts_nested_attributes_for :limits
end
