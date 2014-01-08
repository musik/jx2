module PageRankr
  class Indexes
    class Baidu
      include Index
      
      def url
        "http://www.baidu.com/s"
      end

      def params
        {:wd => "site:#{tracked_url}",:ie=>'UTF-8'}
      end

      def xpath
        "//span[@class='nums']/text()"
      end

      def name
        :indexes_baidu
      end
    end
  end
end
