require 'sinatra'
require 'sequel'

DB = Sequel.connect('sqlite://./news.db')

get '/' do
	@news = DB[:news].all
	erb :index
end

get '/admin' do
	@news = DB[:news].all
	erb :admin
end

get '/news' do
 @categories = DB[:categories].all
 erb :news
end

post '/create' do

	@categs = params[:categs]
	@title = params[:title]
	@description = params[:description]
	@ndate = params[:ndate]
	
	 DB[:news] << {
	 cat_id: params[:categs],
	 title: params[:title],
	 description: params[:description],
	 ndate: params[:ndate]
	}

  redirect '/news'

end

get '/tech_news' do
	@news = DB[:news].where(:cat_id => "1")
	erb :tech_news
end
get '/tech_admin' do
	@news = DB[:news].where(:cat_id => "1")
	erb :tech_admin
end


get '/ops_news' do
	@news = DB[:news].where(:cat_id => "2")
	erb :ops_news
end

get '/ops_admin' do
	@news = DB[:news].where(:cat_id => "2")
	erb :ops_admin
end


get '/delete/:news_id' do
	DB[:news].where(:news_id => params[:news_id]).delete
	redirect '/admin'
end

get '/edit/:news_id' do
	@news = DB[:news].where(:news_id  => params[:news_id]).first
	erb :edit
end

post '/update/:news_id' do
	title = params[:title]
	description = params[:description]
	ndate = params[:ndate]
	
	DB[:news].where(:news_id => params[:news_id]).update(:title => title, 
												:description => description,
												:ndate => ndate)
												
	redirect '/admin'

end