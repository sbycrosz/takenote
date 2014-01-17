class Api::V1::NotesController < Api::V1::ApplicationController
  before_filter :fetch_notes

  def index 
    render json: @notes
  end

  def create
    note = @notes.create!(notes_params)
    render json: note
  end

  def update
    @note.update!(notes_params)
    render json: @note
  end

  def destroy
    @note.destroy
    head(:ok)
  end

  private 

  def fetch_notes
    @notes ||= current_user.notes
    @note ||= @notes.find(params[:id]) if params[:id]
  end

  def notes_params
    params.permit(:title, :content)
  end
end
