# -*- encoding : utf-8 -*-
module BdappHelper
  def bdapp_drug_link drug
    "/bdapp/drug/#{drug.id}"
  end
  def bdapp_pihao_link yaopin
    "/bdapp/pihao/#{yaopin.id}"
  end
end
