# -*- encoding : utf-8 -*-
class Chengfen < ActiveRecord::Base
  attr_accessible :meta, :name
  has_and_belongs_to_many :drugs
  resourcify
  
  def to_param
    (name.present? and name.match(/\//).nil?) ? name : id
  end
  def metahash
    YAML.load(meta) rescue nil
  end
  
  class << self
    def find *args
      return find_by_name(args[0]) if args.size == 1 and args[0].is_a? String
      super
    end
    def import data
      name = data.delete :name
      return if name.nil?
      e = where(:name=>name).first_or_create :meta=>data
      e.update_attribute :meta,data if e.meta.nil?
      e
    end
  end
end
