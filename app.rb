require 'rubygems'
require 'sinatra'
require 'net/http'
require "net/https"

get '/:gist/:file' do
  @http = Net::HTTP.new('gist.github.com', 443)
  @http.use_ssl = true
  @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  @http.start do |http|
    req = Net::HTTP::Get.new("/raw/#{params[:gist]}/#{params[:file]}")
    response = http.request(req)
    response.body
  end
end