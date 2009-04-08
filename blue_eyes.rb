require 'sinatra'
require 'feedzirra'
require 'sequel'


configure do
  Sequel.sqlite('blue_eyes.db')
end


$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'feed'



get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   #Generate CSS file from SASS
   sass :style
end

get '/hi' do
	"Hello world"
end

get '/' do
   @feeds = Feed.all
	 @feed = Feedzirra::Feed.fetch_and_parse("http://www.tbueno.com/blog/feed/")
   haml :index   
end

get '/:id' do
	@feeds = Feed.all
	@model = Feed.find(:id => params[:id])
	@feed = Feedzirra::Feed.fetch_and_parse(@model.url)	
	haml :index
end

post '/add_feed' do
  f = Feedzirra::Feed.fetch_and_parse(params[:feed_url])
  feed = Feed.new(:url => f.feed_url, :name => f.title)
  feed.save
  redirect '/'
end


