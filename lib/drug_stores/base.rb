module DrugStores
  class Base
    def fetch_page url
      response = Typhoeus::Request.get url
      Nokogiri::HTML(response.body)
    end
  end
end
