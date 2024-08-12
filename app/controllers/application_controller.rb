# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(1)
  end

  def logged_in?
    current_user != nil
  end
end
