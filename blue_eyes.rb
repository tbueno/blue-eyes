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
	 @feed = Feedzirra::Feed.fetch_and_parse("http://feedproxy.google.com/RubyInside/")
   haml :index
   
end

post '/add_feed' do
  puts params[:feed_url]
  feed = Feed.new :url => :feed_url
  feed.save
  redirect '/'
end


