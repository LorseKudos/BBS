class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_topic, only: [:edit, :update, :destroy]

  # GET /posts/1/edit
  def edit
    redirect_if_deleted
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @topic = Topic.find(post_params[:topic_id])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @topic, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @topic}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    redirect_if_deleted
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @topic, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    redirect_if_deleted
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @topic, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.with_deleted.find(params[:id])
    end

    def set_topic
      @topic = Topic.with_deleted.find(@post.topic_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      post_params = params.require(:post).permit(:name, :body, :topic_id, :post_id)
      parent_post_id = post_params[:post_id].to_i
      if parent_post_id > 0
        post_params[:post_id] = Post.where(topic_id: post_params[:topic_id])
                                    .limit(1)
                                    .offset(parent_post_id - 1)
                                    .pluck(:id)[0]
      end
      return post_params
    end

    def redirect_if_deleted
      if @post.deleted_at or @topic.deleted_at
        redirect_to :root
      end
    end
end
