require 'rubygems'
require 'sinatra'
require 'httparty'
require 'ruby-debug'
require 'base64'
require 'openssl'
require 'crack/json'

enable :sessions

APP_CONFIG = YAML.load_file("config.yml")

class Signed
  def initialize(encoded_request, json_request, signed_request)
    @encoded_request = encoded_request
    @json_request = json_request
    @signed_request = signed_request
  end
end

helpers do
  def base64_url_decode str
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end
  
  def decode_data(signed_request)
    encoded_sig, payload = signed_request.split('.')
    data = base64_url_decode(payload)
  end
end

post '/' do
  @encoded_request = params[:signed_request]
  @json_request = decode_data(@encoded_request)
  @signed_request = Crack::JSON.parse(@json_request)
  erb :index
end

# Detect Fan status and redirect
post '/pathfinder' do
  @encoded_request = params[:signed_request]
  @json_request = decode_data(@encoded_request)
  @signed_request = Crack::JSON.parse(@json_request)
  if @signed_request['page']['liked']
    erb :unlocked
  else
    erb :locked
  end
end