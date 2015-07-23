require 'json'
require 'webrick'



module Phase9
  class Flash
  	def initialize(req)
      flash = req.cookies.find {|cookie| cookie.name == 'flash'}
      @flash_show = flash ? JSON.parse(flash.value) : {}
      @flash_save = {}
    end

    def [](key)
      @flash_show[key]
    end

    def []=(key, val)
      @flash_save[key] = val
    end

    def now
  		@flash_show
    end

    def store_flash(res)
      new_cookie = WEBrick::Cookie.new('flash', @flash_save.to_json)
      new_cookie.path = "/"
      res.cookies << new_cookie
    end
  end
end