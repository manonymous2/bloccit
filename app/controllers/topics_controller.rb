class TopicsController < ApplicationController
   def index
    # @topics = Topic.all (remove this line)
    @topics = Topic.paginate(page: params[:page], per_page: 10) # add this line
  end


  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

   def show
    @topic = Topic.find(params[:id])
    # @posts = @topic.posts (remove this line)
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10) # add this line
  end  

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin to do that."
  end

    def create
    @topic = Topic.new(params[:topic])
    authorize! :create, @topic, message: "You need to be an admin to do that."
    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."
    if @topic.update_attributes(params[:topic])
      redirect_to @topic
    else
      flash[:error] = "Error saving topic. Please try again"
      render :edit
    end
   end


   def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end
end
