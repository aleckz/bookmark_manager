require 'sinatra/base'
require 'sinatra/flash'
require './app/models/link'
require './app/models/tag'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  use Rack::MethodOverride
  
  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

  set :views, proc {File.join(root,'.', 'views')}

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

# '/links/:id'
# params[:id]

  post '/links' do
     # OLD VERSION: Link.create(url: params[:url], title: params[:title], tag: params[:tag])
    link = Link.new(url: params[:url],
                    title: params[:title])
    tags = params[:tags].split
    tags.each { |tag| link.tags << Tag.create(name: tag) } #['ruby', 'education']
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(  email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    # @user.save
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
     # notice = @user.errors.full_messages.join('<br/>')
     # flash.now[:notice] = notice
     flash.now[:errors] = @user.errors.full_messages
     erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end


  helpers do

    def current_user
     @user ||= User.get(session[:user_id])
    end

  end


run! if app_file == $0

end