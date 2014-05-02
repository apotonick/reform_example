class AlbumsController < ApplicationController

  # TODO: coercion (length)

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    # end
    album = Album.new(songs: [Song.new(user: User.new), Song.new])
    @form = Forms::AlbumForm.new(album) # TODO: tell Reform to display 2 empty song forms?
  end

  def edit
    album = Album.find(params[:id])
    @form = Forms::AlbumForm.new(album)
  end

  def create
    # album = Album.new(songs: [Song.new, Song.new]) # this would be the clean way.
    album = Album.new # however, Reform can create the nested songs for you in #validate.
    @form = Forms::AlbumForm.new(album)

    if @form.validate(params["album"])
      @form.save
      redirect_to album_path(album)
    else
      render :new
    end
  end

  def update
    album = Album.find(params[:id])
    @form = Forms::AlbumForm.new(album)

    if @form.validate(params["album"])
      @form.save
      redirect_to album_path(album)
    else
      render :edit
    end
  end

end
