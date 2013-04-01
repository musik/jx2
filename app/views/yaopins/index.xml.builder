xml.instruct!
xml.DOCUMENT do
  @yaopins.each do |item|
    xml.item do
      xml.key item.wenhao
      xml.display do
        xml.url yaopin_url(item.wenhao)
        xml.title item.wenhao
        xml.showurl "www.jxjw.net"
        xml.form(:col0=>"名称",:col1=>item.name,:col0link=>"",:col1link=>show_yao_url(item.name))
        i=0
        %w(shangpin_name pizhunri guige jixing leibie changjia_name en yuanwenhao benweima benweima_beizhu  changjia_guojia changjia_dizhi daoqiri wenhao).each do |key|
          if item.send(key).present? and item.send(key) != '－－－－'
            i+=1
            if i > 5
              xml.link(:linkurl=>yaopin_url(item.wenhao),:linkcontent=>"详情")
              break
            end
            xml.form(:col0=>t("yaopin.attrs.#{key}"),:col1=>item.send(key),:col0link=>"",:col1link=>"")
          end
        end
      end
    end
  end
end
