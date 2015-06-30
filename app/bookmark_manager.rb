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
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
     # OLD VERSION: Link.create(url: params[:url], title: params[:title], tag: params[:tag])
    link = Link.new(url: params[:url],
                    title: params[:title])
    tag  = Tag.create(name: params[:tag])
    link.tags << tag
    link.save 
    redirect '/links'
<<<<<<< HEAD
=======
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
>>>>>>> b931b81f1b57a60fe28cd464292de3876e3aa35d
  end



run! if app_file == $0

end