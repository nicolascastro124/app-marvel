#Uso de la API Hashify API
#https://documenter.getpostman.com/view/3362843/RWMCt9WU
require 'rest-client'
require 'json'
class Md5 
def md5 (publickey, privatekey, ts)
    url = "https://api.hashify.net/hash/md5/hex?value=#{ts}#{privatekey}#{publickey}"
    response = RestClient.get url
    result = JSON.parse response.to_str
    return result['Digest']
end
end