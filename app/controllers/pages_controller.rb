class PagesController < ApplicationController
  layout false, only: :robots

  def robots
    robots = File.read(Rails.root + "config/robots/#{Rails.env}.txt")
    render text: robots, layout: false, content_type: 'text/plain'
  end

  def about
  end

  def legal
  end
end
