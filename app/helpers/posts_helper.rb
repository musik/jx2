module PostsHelper
  def autolink_content(text,keywords)
    hash = Jibing.select("name,id").collect{|r|
      [r.name,"/jibing/#{r.id}"]
    }
    if keywords.present?
      #hash += Drug.search(keywords.gsub(',',' | '),match_mode: :extended2,per_page: 50).collect{|r|
      hash += Drug.where(name: keywords.split(',')).select("name").collect{|r|
        [r.name,"/yaopin/#{r.name}/pihao"]
      }
    end
    hash = Hash[hash]
    patt = Regexp.new(hash.keys.join("|"))
    text.gsub(patt){|s| "<a href=\"#{hash[s]}\">#{s}</a>"}.html_safe
  end
end
