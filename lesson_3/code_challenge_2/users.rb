require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @user_data = YAML.load_file('users.yaml')
  @number_of_users = @user_data.size
end

helpers do
  def count_interests(data)
    total_interests = 0

    data.values.each do |value|
      total_interests += value[:interests].size
    end

    total_interests
  end
end

get "/" do
  @title = "Users"
  @user_names = @user_data.keys

  erb :user_names
end

get "/:name" do
  user_name = params[:name].to_sym
  @title = user_name.capitalize

  @email = @user_data[user_name][:email]
  @interests = @user_data[user_name][:interests]

  @other_users = @user_data.keys
  @other_users.delete(user_name)

  erb :user_page
end

# {:jamy=>{:email=>"jamy.rustenburg@gmail.com", :interests=>["woodworking", "cooking", "reading"]},
#  :nora=>{:email=>"nora.alnes@yahoo.com", :interests=>["cycling", "basketball", "economics"]},
#  :hiroko=>{:email=>"hiroko.ohara@hotmail.com", :interests=>["politics", "history", "birding"]}} 