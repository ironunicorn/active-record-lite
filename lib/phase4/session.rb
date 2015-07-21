require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
        session = req.cookies.find {|cookie| cookie.name == '_rails_lite_app'}
        @session = session ? JSON.parse(session.value) : {}
    end

    def [](key)
        @session[key]
    end

    def []=(key, val)
        @session[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses session
    def store_session(res)
        new_cookie = WEBrick::Cookie.new('_rails_lite_app', @session.to_json)
        res.cookies << new_cookie
    end
  end
end
