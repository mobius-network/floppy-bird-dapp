class AppController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:pay]

  ROUND_PRICE = 5

  # GET /
  # User opens the application passing in the token variable.
  def index
    # User has opened application page without a token
    return render plain: "Visit https://store.mobius.network to register in the DApp Store" unless app

    # User has not granted access to his MOBI account so we can't use it for payments
    return render plain: "Visit https://store.mobius.network and open our app" unless app.authorized?

    redirect_to "/flappy_bird/?token=#{token_s}"
  end

  # GET /balance
  def balance
    render plain: app.balance
  end

  # POST /pay
  def pay
    app.pay(ROUND_PRICE)
    render plain: app.balance
  rescue Mobius::Client::Error::InsufficientFunds
    render :gone
  end

  private

  def token_s
    session[:token] = params[:token] || session[:token]
  end

  def token
    @token ||= Mobius::Client::Auth::Jwt.new(Rails.application.secrets.app[:jwt_secret]).decode!(token_s)
  rescue Mobius::Client::Error
    nil # We treat all invalid tokens as missing
  end

  def app
    @app ||= token && Mobius::Client::App.new(
      Rails.application.secrets.app[:secret_key], # SA2VTRSZPZ5FIC.....I4QD7LBWUUIK
      token.public_key                            # Current user
    )
  end
end