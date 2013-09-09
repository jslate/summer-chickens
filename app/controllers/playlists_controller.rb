class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def create
    @playlist = Playlist.new(playlist_params)
    if @playlist.save
      redirect_to playlists_path, notice: 'Playlist was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @playlist.update(playlist_params)
      redirect_to playlists_path, notice: 'Playlist was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @playlist.destroy
    redirect_to playlists_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.require(:playlist).permit(:name)
    end

end
