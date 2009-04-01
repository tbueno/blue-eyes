require 'sinatra'
require 'feedzirra'

get '/style.css' do
   content_type 'text/css', :charset => 'utf-8'
   #Generate CSS file from SASS
   sass :style
end

get '/hi' do
	"Hello world"
end

get '/' do
	 @feed = Feedzirra::Feed.fetch_and_parse("http://feeds2.feedburner.com/RubyInsideBrasil")
   haml :index
end

