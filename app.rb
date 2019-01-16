#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index
end

get '/visit' do
	erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
  # user_name, phone, date_time
  @user_name = params[:user_name]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @barber = params[:barber]
  @color = params[:color]

  # hh = {:user_name => 'Введите имя', 
  #   :phone => 'Введите телефон', 
  #   :date_time => 'Введите дату и время'}

	Client.create(name: "#{@user_name}", phone: "#{@phone}", datastamp: "#{@date_time}", barber: "#{@barber}", color: "#{@color}")

  erb "<h1>Спасибо, Вы записались!</h2>"

end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	Contact.create(email: "#{@email}", message: "#{@message}")

  erb "<h2>Your message was sent</h2>"
end