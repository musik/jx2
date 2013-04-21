# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at,:contact,:phone,:company_name
  validates_uniqueness_of :name,:email
  validates_presence_of :name,:email

  has_many :entries
  
  def max_entries
    20
  end
  def contact_empty?
    company_name.blank? or contact.blank? or phone.blank?
  end
  def entries_full?
    entries.size >= max_entries
  end
end
