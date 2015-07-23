require 'json'
require 'webrick'
require 'securerandom'
require_relative './flash'

module Phase9
  class AuthToken
    attr_reader :security

    def initialize(flash)
      @security = SecureRandom.urlsafe_base64
      flash[:security] = @security
    end
  end
end