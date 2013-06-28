require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/' do     # home page
  #create an array
  @contacts = []
  #open database
  db =PG.connect(:dbname => 'address_book', :host => 'localhost')

  db.exec("select * from contacts") do |result|
  #create loop
    result.each do |row|
      @contacts << row
    end
  end
#close database
  db.close
  erb :home_page
end

