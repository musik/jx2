# -*- encoding : utf-8 -*-
class PostSweeper < ActionController::Caching::Sweeper
  observe Post # This sweeper is going to keep an eye on the r model

  def after_create(r)
    expire_cache_for(r)
  end

  def after_update(r)
    expire_cache_for(r)
  end

  def after_destroy(r)
    expire_cache_for(r)
  end

  private
  def expire_cache_for(r)
    expire_fragment 'recent-posts-15'
  end
end
