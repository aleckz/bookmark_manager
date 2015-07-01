require 'sinatra/base'
require './app/models/link'
require './app/models/tag'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  set :views, proc {File.join(root,'.', 'views')}

  get '/' do
    redirect '/links'
  end

  get '/links' do
    # require 'byebug'
    # byebug
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
    @user = User.create(email: params[:email], password: params[:password])
    redirect to('/links')
  end



run! if app_file == $0

end