require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'


set :database, "sqlite3:mybloghq.db"

before do
  @posts = Post.all
  @comments = Comment.all
  @feedbacks = Feedback.all
end

class Post < ActiveRecord::Base
has_many :comments 
  validates :personname, presence: true, length: {minimum: 3}
  validates :content, presence: true

end

class Comment < ActiveRecord::Base

  validates :personname, presence: true, length: {minimum: 3}
  validates :content, presence: true

end

class Feedback < ActiveRecord::Base

  validates :username, presence: true, length: {minimum: 3}
  validates :textarea, presence: true 

end

get '/' do

  erb :index
end

get '/createpost' do
  @p = Post.new params[:createpost]

  erb :createpost
end

post '/createpost' do

  @p = Post.new params[:createpost]
  @p.save

  if @p.save
  erb "<h2>Thank you!</h2>"
  else
    @error = @p.errors.full_messages.first
    erb :createpost
    end
end

get '/posts' do

  @posts = Post.order('created_at DESC')

  erb :posts
end

post '/posts' do
  erb "Zaglushka"
end

get '/details/:post_id' do
  post_id = params[:post_id]

end

get '/feedback' do

  @f = Feedback.new


  erb :feedback
end

post '/feedback' do
  @f = Feedback.new params[:feedback]
 if @f.save
   erb "Thanks for your feedback!"
 else
   @error = @f.errors.full_messages.first
   erb :feedback

 end
 end
