#подключаем гемы, так же записал в гемфайл
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
# создём БД
set :database, "sqlite3:mybloghq.db"
#Считываем модели перед тем как перейти к ним
before do
  @posts = Post.all
  @comments = Comment.all
  @feedbacks = Feedback.all
end
#Создаём модель Post -> далее create db:migration -> db:migrate
# При необходимости делаем Валидацию используем validates
class Post < ActiveRecord::Base
has_many :comments 
  validates :personname, presence: true, length: {minimum: 3}
  validates :content, presence: true

end
#Создаём модель Comment  -> далее create db:migration -> db:migrate
# При необходимости делаем Валидацию используем validates
class Comment < ActiveRecord::Base

  validates :personname, presence: true, length: {minimum: 3}
  validates :content, presence: true

end

#Создаём модель Feedback -> далее create db:migration -> db:migrate
# При необходимости делаем Валидацию используем validates
class Feedback < ActiveRecord::Base

  validates :username, presence: true, length: {minimum: 3}
  validates :textarea, presence: true 

end

#Первая страница сайта
get '/' do

  erb :index
end
#таблица создания поста
get '/createpost' do
  @p = Post.new params[:createpost]

  erb :createpost
end
#Отправляем инфу на сервер через пост-обработку
post '/createpost' do

  @p = Post.new params[:createpost]
  @p.save
#Проверка валидности данных (через validates в Моделях)
  if @p.save
  erb "<h2>Thank you!</h2>"
  else
    @error = @p.errors.full_messages.first
    erb :createpost
    end
end
#Список созданных постов
get '/posts' do

  @posts = Post.order('created_at DESC')

  erb :posts
end
#На пост пока заглушка он пока не нужен
post '/posts' do
  erb "Zaglushka"
end
#По :id подбирается соответсвующий пост какой имеено вывести пост указывает код в представлении postpage.erb
get '/details/:id' do
  @postinfo = Post.find(params[:id])
  erb :postpage

end


#Страница обратной связи. Пока не придумал как правильно сделать отправку мне на почту и плюс не сделал сохраняшку.(в работу)
get '/feedback' do

  @f = Feedback.new


  erb :feedback
end
#пост обработчик фидбека
post '/feedback' do
  @f = Feedback.new params[:feedback]
 if @f.save
   erb "Thanks for your feedback!"
 else
   @error = @f.errors.full_messages.first
   erb :feedback

 end
 end
