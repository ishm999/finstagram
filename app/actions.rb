helpers do
  # returns an Object (User) or nil
  def current_user
    User.find_by(id: session[:user_id])
  end

  # return a boolean (true or false)
  def logged_in?
    !!current_user
  end
end

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/signup' do     # if a user navigates to the path "/signup",
  @user = User.new   # setup empty @user object
  erb(:signup)       # render "app/views/signup.erb"
end

get '/login' do # when a GET request comes into /login
  erb(:login)  # render app/views/login.erb
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    redirect to('/login')
  else
    erb(:signup)
  end
end

post '/login' do
  username = params[:username]
  password = params[:password]

  # 1. find user by username
  user = User.find_by(username: username)

  # 2. if that user exists
  if user && user.password == password
    session[:user_id] = user.id
    redirect to('/')
  else
    @error_message = "Login failed."
    erb(:login)
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

# Before handler for '/finstagram_posts/new'
before '/finstagram_posts/new' do
  redirect to('/login') unless logged_in?
end

get '/finstagram_posts/new' do
  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")
end

post '/finstagram_posts' do
  photo_url = params[:photo_url]

  # instantiate new FinstagramPost
  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

  # if @post validates, save
  if @finstagram_post.save
    redirect(to('/'))
  else

    # if it doesn't validate, print error messages
    erb(:"finstagram_posts/new")
  end
end

# Handle a GET request for the '/finstagram_posts/:id' path
get '/finstagram_posts/:id' do
  @finstagram_post = FinstagramPost.find_by(id: params[:id])

  if @finstagram_post
    erb(:'finstagram_posts/show')
  else
    halt(404, erb(:'errors/404'))
  end
end

post '/comments' do
  # point values from params to variables
  text = params[:text]
  finstagram_post_id = params[:finstagram_post_id]

  # instantiate a comment with those values & assign the comment to the `current_user`
  comment = Comment.new({ text: text, finstagram_post_id: finstagram_post_id, user_id: current_user.id })

  # save the comment
  comment.save

  # `redirect` back to wherever we came from
  redirect(back)
end

post '/likes' do
  # point values from params to variables
  finstagram_post_id = params[:finstagram_post_id]

  # instantiate a like with those values & assign the like to the `current_user`
  like = Like.new({finstagram_post_id: finstagram_post_id, user_id: current_user.id })

  # save the like
  like.save

  # `redirect` back to wherever we came from
  redirect(back)
end

delete '/likes/:id' do
  like = Like.find(params[:id])
  like.destroy
  redirect(back)
end