class LinksController < ApplicationController
  def index
    if(logged_in?)
      @link = Link.new
      @links = current_user.links.existing
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

    def check_for_updates
      connection = Bunny.new({:host => "experiments.turing.io", :port => "5672", :user => "student", :pass => "PLDa{g7t4Fy@47H"})
      # connection = Bunny.new(ENV["publisher"])
      pubsub = PubSub.new(connection)
      
      Link.get_top_lnks(pubsub)
    end
end
