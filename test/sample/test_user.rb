module Sample
  class TestUser
    def self.find_or_initialize_by_fb_uid(fb_uid)
      new(fb_uid)
    end

    attr_accessor :fb_uid
    def initialize(fb_uid = 42)
      @fb_uid = fb_uid
    end
  end
end