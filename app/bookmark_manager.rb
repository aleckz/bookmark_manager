require 'sinatra/base'
require './app/models/link'
require './app/models/tag'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

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
    tags.each do |tag| #['ruby', 'education']
      link.tags << Tag.create(name: tag) #['ruby', 'education']
    end
    link.save 
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    @message = 'Sorry, your passwords do not match.'
    user = User.create(email: params[:email], 
                       password: params[:password], 
                       password_confirmation: params[:password_confirmation]) 
    session[:user_id] = user.id # 3
    if user.save 
      session[:user_id] = user.id
      redirect to('/')
    else
      erb :'users/new'
    end
  end

  helpers do

    def current_user
     @user ||= User.get(session[:user_id])
     # User(id:, session[:user_id]) is returning an array with the user that has the corresponding ID, .first is being called to extract that user.  
    end

  end


run! if app_file == $0

end