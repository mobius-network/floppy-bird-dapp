class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:authenticate]

  # GET /auth
  # Generates and returns challenge transaction XDR signed by application to user
  def challenge
    render plain: Mobius::Client::Auth::Challenge.call(
      Rails.application.secrets.app[:secret_key], # SA2VTRSZPZ5FIC.....I4QD7LBWUUIK
      12.hours                                    # Session duration
    )
  end

  # POST /auth
  # Validates challenge transaction. It must be:
  #   - Signed by application and requesting user.
  #   - Not older than 10 seconds from now (see Mobius::Client.strict_interval`)
  def authenticate
    token = Mobius::Client::Auth::Token.new(
      Rails.application.secrets.app[:secret_key], # SA2VTRSZPZ5FIC.....I4QD7LBWUUIK
      params[:xdr],                               # Challenge transaction
      params[:public_key]                         # User's public key
    )

    # Important! Otherwise, token will be considered valid.
    token.validate!

    # Converts issued token into JWT and sends it to user.
    #
    # Note: this is not the requirement. Instead of JWT, application might save token.hash along
    # with time frame and public key to local database and validate over it.
    render plain: Mobius::Client::Auth::Jwt.new(
      Rails.application.secrets.app[:jwt_secret]
    ).encode(token)
  rescue Mobius::Client::Error::Unauthorized
    # Signatures are invalid
    render plain: "Access denied!"
  rescue Mobius::Client::Error::TokenExpired
    # Current time is outside session time bounds
    render plain: "Session expired!"
  rescue Mobius::Client::Error::TokenTooOld
    # Challenge transaction was issued more than 10 seconds ago
    render plain: "Challenge tx expired!"
  end
end
