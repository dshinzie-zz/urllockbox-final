class LinksController < ApplicationController
  before_filter :current_links

  def index
    check_for_updates
    @link = Link.new if(logged_in?)
  end

  def create
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

    def current_links
      @links = current_user.links.existing
    end

    def check_for_updates
      Link.get_top_links
    end
end
