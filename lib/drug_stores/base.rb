module DrugStores
  class Base
    def fetch_page url
      response = Typhoeus::Request.get url
      if response.success?
        return Nokogiri::HTML(response.body)
        else
        raise "ERROR:DrugStores.fetch_page #{url} #{response.inspect}"
      end
    end
  end
end
