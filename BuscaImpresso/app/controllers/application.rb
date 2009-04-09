# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => '06908d5bdb9f3e78f4fcbe981f5459ed'

  def set_charset
    @headers["Content-Type"] = "text/html; charset=UTF-8"
  end
end
