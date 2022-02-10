require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

#  get '/' do
#    "Hello world"
#  end
 get '/' do
   'Bookmark Manager'
 end

 get '/bookmarks' do
  # Print the ENV variable
  #p ENV
   @bookmarks = Bookmark.all
   erb :'bookmarks/index'
 end

 get '/bookmarks/new' do
   erb :'bookmarks/new'
 end

  post '/bookmarks' do
    Bookmark.create(url: params[:url])
    # url = params['url']
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
    redirect '/bookmarks'
 end


 run! if app_file == $0
end