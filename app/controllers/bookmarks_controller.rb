class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark was successfully saved."
      redirect_to @topic
    else
      flash[:alert] = "Error creating the bookmark. Please try again."
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark was successfully updated."
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash[:alert] = "Error saving bookmark updates. Please try again."
      render :show
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark was successfully deleted."
      redirect_to @bookmark.topic
    else
      flash[:alert] = "There was an error deleting the bookmark. Please try again."
      redirect_to [@bookmark.topic, @bookmark]
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end