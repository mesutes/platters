# frozen_string_literal: true

class MiscPagesController < ApplicationController
  def about
    @contact_email = ENV["CONTACT_EMAIL"]
  end

  def home
  end

  def details
  end
end