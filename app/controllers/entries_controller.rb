class EntriesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index, locals: { items: Entry.order(updated_at: :desc) }, layout: false }
      format.json { render json: { items: Entry.order(updated_at: :desc) } }
    end
  end

  def create
    if params[:token] == ENV['FIREWORKS_TOKEN']
      entry = Entry.find_or_initialize_by(name: params[:name])
      entry.branch = params[:branch]
      entry.state = params[:state]
      entry.username = params[:username]
      entry.commit = params[:commit]
      entry.commit_url = params[:commit_url]
      entry.subject = params[:subject]
      entry.author = params[:author]
      entry.save
      entry.touch
      head 200
    else
      head 403
    end
  end
end
