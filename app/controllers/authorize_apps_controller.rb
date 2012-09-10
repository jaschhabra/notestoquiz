class AuthorizeAppsController < ApplicationController
  before_filter :authenticate_user!

  def authorize_dropbox
    if current_user.dropbox_token.nil?
      consumer = Dropbox::API::OAuth.consumer(:authorize)
      request_token = consumer.get_request_token
      session[:dropbox_request_token] = request_token
      redirect_to request_token.authorize_url(:oauth_callback => MY_SITE_NAME + 'authorize_dropbox_done')
    else
      redirect_to root_path
    end
  end

  def authorize_dropbox_done

    if current_user.dropbox_token.nil?
      # The oauth_token will be available in the params
      request_token = session[:dropbox_request_token]
      request_token.get_access_token(:oauth_verifier => params[:oauth_token])
      current_user.dropbox_token = request_token.params[:oauth_token]
      current_user.dropbox_secret = request_token.params[:oauth_token_secret]
      current_user.save
    end
    redirect_to root_path
  end

  def delete_dropbox_token

  end

  def authorize_quizlet
    if current_user.quizlet_token.nil?
      session[:state] = SecureRandom.hex(13)
      redirect_to quizlet_client.auth_code.authorize_url(
        :redirect_uri => quizlet_redirect_uri,
      :state => session[:state],
      :response_type => 'code',
      :scope => 'read write_set write_group')
    else
      redirect_to root_path
    end


  end

  def authorize_quizlet_done

    if current_user.quizlet_token.nil?
      raise "State doesn't match. Possible CSRF" unless session[:state] == params[:state]
      access_token = quizlet_client.auth_code.get_token(params[:code], 
                                                :redirect_uri => quizlet_redirect_uri)
      current_user.quizlet_token = access_token.token
      current_user.save
    end
      redirect_to root_path


  end

  def delete_dropbox_token

  end

  private

  def quizlet_client
    @quizlet_client ||= OAuth2::Client.new(QUIZLET_CLIENT_ID, QUIZLET_CLIENT_SECRET, 
                       :authorize_url => 'https://quizlet.com/authorize/',
                       :token_url => 'https://api.quizlet.com/oauth/token')
  end

  def quizlet_redirect_uri
    'http://localhost:3000/authorize_quizlet_done'
  end


end
