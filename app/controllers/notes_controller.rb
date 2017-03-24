class NotesController < ApplicationController

  before_action :require_user, only: [:update]

  def index
    @notes = case
    when params[:tag]
      Tag.find_by(name: params[:tag])
    when current_user
      current_user.notes
    else Note.all
    end
    render json: @notes
  end

  def create
    @note = Note.new(note_params)

    if @note.save
      params[:tags].split(',').each{ |t| @note.tags << Tag.find_or_create_by(name: t.strip) }
      render json: @note
    else
      request_error(@note.errors.full_messages)
    end
  end

  def update
    @note = Note.find(params[:id]) if params(:id)
    @note.user == current_user ? @note.update(note_params) : request_error(["not your note!"])
  end

  private

  def note_params
    params.permit(:title, :body)
  end

end
