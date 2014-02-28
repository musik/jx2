# -*- encoding : utf-8 -*-
class CoSubdomain
  def self.matches?(request)
    request.subdomain.match(/\d+\.c/).present?
  end
end
