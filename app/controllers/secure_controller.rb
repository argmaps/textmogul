class SecureController < ApplicationController
  force_ssl if: :ssl_configured?

private
  def ssl_configured?
    !Rails.env.development?
  end
end
