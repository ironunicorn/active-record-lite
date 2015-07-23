require_relative '../phase6/controller_base'

require_relative './auth_token'

module Phase9
  class ControllerBase < Phase6::ControllerBase

    def redirect_to(url)
        super
    	flash.store_flash(res)
    end

    def render_content(content, content_type)
        super
        flash.store_flash(res)
    end

    def flash
    	@flash ||= Flash.new(req)
    end

    def auth_token
        @auth_token = AuthToken.new(flash)
    end

    def form_authenticity_token
        auth_token.security
    end

    def protect_from_forgery
        raise "Error!" unless params[:security] && flash["security"] == params[:security] 
    end

    def invoke_action(name)
        protect_from_forgery if name == :post
        self.send(name)
    end
  end
end