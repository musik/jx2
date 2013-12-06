class SfdaJob
  @queue = "sfda"
  def self.perform
    Yaopin::Sfda.new.process
  end
end
