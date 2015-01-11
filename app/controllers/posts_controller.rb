class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.select('posts.id, posts.user_id, posts.title, posts.body, posts.cached_votes_up, posts.cached_votes_down, posts.created_at')
              .order(cached_votes_up: :desc)
              .to_json(include: {
                user: { only: :username }
              })

    render json: @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    render json: @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    user = User.find_by_sim_serial_number(post_params[:sim_serial_number])
    @post.user = user

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    head :no_content
  end

  # POST /posts/like
  def like
    @post = Post.find(params[:id])
    user = User.where(sim_serial_number: params[:sim_serial_number]).first
    user && user.like(@post)

    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :sub_category_id, :address, :sim_serial_number)
  end
end

