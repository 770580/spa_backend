class ApplicationController < ActionController::API
  include Knock::Authenticable
  include ActionController::Serialization
end
