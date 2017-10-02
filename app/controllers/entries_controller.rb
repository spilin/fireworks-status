class EntriesController < ApplicationController
  def index
    render :index, locals: { items: Entry.all }, layout: false
  end

  def create
    if params[:token] == ENV['FIREWORKS_TOKEN']
      entry = Entry.find_or_initialize_by(name: params[:name])
      entry.branch = params[:branch]
      entry.state = params[:state]
      entry.save
      entry.touch
      head 200
    else
      head 403
    end
  end
end
