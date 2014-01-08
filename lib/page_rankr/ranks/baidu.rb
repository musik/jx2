module PageRankr
  class Ranks
    class Baidu
      include Rank

      def url
        "http://www.aizhan.com/getbrinfo.php"
      end

      def params
        { :url => tracked_url}
      end

      def regex
        /brs\/(\d).gif/
      end

      def name
        :ranks_baidu
      end
    end
  end
end
