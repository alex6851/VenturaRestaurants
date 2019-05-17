

module VenturaRestaurants
  class Error < StandardError; end
  # Your code goes here...
end

require "pry"
require "httparty"
require "json"
require "dotenv/load"


require_relative "./cli.rb"
require_relative "./Restaurant"
require_relative "./api"
require_relative "./VenturaRestaurants/version"

