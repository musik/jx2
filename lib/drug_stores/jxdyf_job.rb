#encoding: utf-8
module DrugStores
  class JxdyfJob
    @queue = 'stores_search'
    def self.perform name
      Jxdyf.new.search name
    end
  end
end
