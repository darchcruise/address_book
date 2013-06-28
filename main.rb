require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/' do     # home page

  @ab_contacts = [] #create an array
  # open database
  db =PG.connect(:dbname => 'address_book', :host => 'localhost')
  db.exec("select * from contacts") do |result|
    result.each do |row| #create loop
      @ab_contacts << row
    end
  end
  db.close #close database
  erb :home_page
end

get '/address/:first' do # single contact
  @first = params[:first] #user name is the value
  # open database
  db =PG.connect(:dbname => 'address_book', :host => 'localhost')
  # Grab SQL table and store it in a variable
  @contact =db.excu("SELECT * FROM contacts WHERE first= '#{@first}'").first
  # close database
  db.close
  erb :single_contact
end

get '/new_contact' do
  erb :input
end

post '/new_contact' do
  @first = params[:first]
  @last = params[:last]
  @age = params[:age].to_i
  @gender = params[:gender]
  @dtgd = params[:dtgd]
  @phone = params[:phone]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  db.exec("INSERT INTO contacts (first, last, age, gender, dtgd, phone) values ('#{@first}', '#{@last}', #{@age}, '#{@gender}', #{@dtgd}, '#{@phone}')")
  db.close
  redirect to('/')
end




