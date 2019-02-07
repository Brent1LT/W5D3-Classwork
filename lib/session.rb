require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
   cookie = req.cookies["_rails_lite_app"]
   
    if cookie
      @cookies = JSON.parse(cookie)
    else
      @cookies = {}
    end
  end

  def [](key)
  end

  def []=(key, val)
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
  end
end
