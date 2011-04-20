require 'rubygems'
require 'sinatra'
require 'net/http'
require "net/https"

@@http = Net::HTTP.new('gist.github.com', 443)
@@http.use_ssl = true
@@http.verify_mode = OpenSSL::SSL::VERIFY_NONE

get '/*' do
  expires 300, :public
  @@http.start do |http|
    req = Net::HTTP::Get.new("/raw/#{params[:splat].first}")
    response = http.request(req)
    response.body
  end
end