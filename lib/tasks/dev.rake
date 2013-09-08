#encoding: utf-8
namespace :dev do
  desc "dump drug descriptions"
  task :dump_desc => :environment do
    File.open("#{Rails.root}/tmp/desc.txt",'w') do |f|
      str = Drug.pluck(:description).compact.join("")
      f.write str
    end
    exec("/usr/local/mmseg3/bin/mmseg -d config/etc tmp/desc.txt > tmp/desc2.txt")
  end
  desc "mmseg"
  task :mmseg => :environment do
    exec("/usr/local/mmseg3/bin/mmseg -d config/etc tmp/desc.txt > tmp/desc2.txt")
  end
end
namespace :jobs do
  desc "取回药品数据前10页"
  task :update_yaopins => :environment do
    page = (ENV["YPAGE"] || 10)
    Yaopin::Sfda.new.get_table_lists 25,page.to_i,1
  end
  desc "生成sitemap"
  task :sitemap => :environment do
    hosts =  Rails.env.production? ? "http://www.jxjw.net" : "http://vcap.me:4005"
    size = Yaopin.count
    per = 5000
    total_pages = (size.to_f / per).ceil
    i = 1
    cmd = ""
    while i <= total_pages
      url = "#{hosts}/pihao/map.xml"
      file = "#{Rails.root}/public/sitemap/pihao-page-#{i}.xml"
      cmd += "curl -o #{file} -d \"per=#{per}&page=#{i}\" -G #{url};\n"
      i += 1
    end
    exec cmd
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
