require 'sinatra/base'
require './app/models/link'

class BookmarkManager < Sinatra::Base

  set :views, proc {File.join(root,'.', 'views')}


  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

end