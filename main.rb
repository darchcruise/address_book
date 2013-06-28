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

get '/new contact' do
  erb :input
end