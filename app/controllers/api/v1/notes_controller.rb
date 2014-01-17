class Api::V1::NotesController < Api::V1::ApplicationController
  before_filter :fetch_notes

  def index 
    render json: @notes.include_tags
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
    # this is a hack for Rails converting empty arrays into nils in params
    params[:tags] ||= [] if params.has_key?(:tags) 
    # end hack
    params.permit(:title, :content, tags: [])
  end
end
