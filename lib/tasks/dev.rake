#encoding: utf-8
namespace :dev do
end
namespace :jobs do
  desc "取回药品数据前10页"
  task :update_yaopins => :environment do
    page = ARGV[1] || 10
    #Yaopin::Sfda.new.get_table_lists 25,10,1
  end
  desc "生成xml"
  task :xml => :environment do
    hosts =  Rails.env.production? ? "http://www.jxjw.net" : "http://vcap.me:4005"
    size = Yaopin.count
    per = 10000
    total_pages = (size.to_f / per).ceil
    i = 1
    while i <= total_pages
      url = "#{hosts}/pihao.xml"
      file = "#{Rails.root}/public/xml/pihao-page-#{i}.xml"
      puts "curl -o #{file} -d \"per=#{per}&page=#{i}\" -G #{url}"

#      res = Typhoeus::Request.get(url)
#      File.open(file,'w') do |f|
#        f.write res.body
#      end
      i += 1
    end
  end
end
