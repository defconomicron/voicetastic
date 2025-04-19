class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # before_action :set_cache_headers

  private

    # def set_cache_headers
    #   response.headers['Cache-Control'] = 'no-cache, no-store'
    #   response.headers['Pragma'] = 'no-cache'
    #   response.headers['Expires'] = 'Mon, 01 Jan 1990 00:00:00 GMT'
    # end
end
