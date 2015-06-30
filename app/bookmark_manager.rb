require 'sinatra/base'
require './app/models/link'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

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

  post '/links' do
     Link.create(url: params[:url], title: params[:title], tags: params[:tags])
     redirect '/links'
  end

run! if app_file == $0

end