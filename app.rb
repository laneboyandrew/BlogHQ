require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:mybloghq.db"

class Post < ActiveRecord::Base

end

class Comment < ActiveRecord::Base

end


get '/' do

  erb :index
end