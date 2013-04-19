#coding: utf-8
@pihao = @drug.yaopins.newest.all
prawn_document(:filename=>"#{@drug.name}.pdf") do |pdf|
#prawn_document() do |pdf|
  pdf.font "#{Rails.root}/vendor/fonts/simfang.ttf"
  pdf.font_size(24) {
    pdf.text @drug.name
  }
  pdf.move_down 5
  pdf.text "来源: <color rgb='0066cc'><link href='http://www.jxjw.net'>国药准字查询网</link></color>",:inline_format=>true
  pdf.text "网址: <color rgb='0066cc'><link href='http://www.jxjw.net/yaopin/#{CGI.escape @drug.name}/pihao'>http://www.jxjw.net/yaopin/#{@drug.name}/pihao</link></color>",:inline_format=>true
  pdf.move_down 5
  pdf.table [
    ['剂型',@pihao.first.jixing],
    ['类别',@pihao.first.leibie],
    ['规格',@pihao.first.guige],
  
  ]
  pdf.move_down 10
  pdf.text "批准文号 #{@pihao.size}个"
  pdf.move_down 10
  arr = [['ID','批准文号','厂家','批准日期']]
  i = 0
  @pihao.each do |yaopin|
    i+=1
    arr << [i,yaopin.wenhao,yaopin.changjia_name,yaopin.pizhunri]
  end
  pdf.table arr
end
