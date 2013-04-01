# -*- encoding : utf-8 -*-
#TOPDRUGS=File.readlines("#{Rails.root}/config/topdrugs.txt").collect{|l| l.strip}
def mz_load_topdrugs(min=51)
    rs = File.read("#{Rails.root}/config/merge.csv").split("\r\n").collect{|l| l.split(",")}
    rs.delete_if{|r| r[0] == "#" || r[6] != "易" || r[2].to_i < min}
    rs.sort!{|a,b| b[2].to_i <=> a[2].to_i}
    ns = {}
    rs.each{|r|  ns[r[1]] = r[2].to_i}
    ns
end
TOPDRUGS= mz_load_topdrugs

