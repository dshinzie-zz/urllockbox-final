class LinksController < ApplicationController
  def index
    @hot_links = Link.hot
    if(logged_in?)
      @link = Link.new
      @links = current_user.links.order(updated_at: :desc)
    end
  end

  def create
    @links = current_user.links.existing
    @link = current_user.links.new(link_params)

    if(@link.invalid_link?)
      flash[:warning] = "Invalid Link"
      render :index
    elsif(@link.save)
      flash[:notice] = "Link successfully created"
      redirect_to root_path
    else
      flash[:warning] = @link.errors.full_messages.to_sentence
      render :index
    end
  end

  private
    def link_params
      params.require(:link).permit(:url, :title, :read)
    end
end
