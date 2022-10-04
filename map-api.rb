require "uri"
require "net/http"
require "json"
require "./index.js"


# url = URI("https://maps.googleapis.com/maps/api/js?key=AIzaSyBpGH4cWpYz5cAYIyN01D9b0bBbszawKRw&callback=initMap")

# https = Net::HTTP.new(url.host, url.port)
# https.use_ssl = true

# request = Net::HTTP::Get.new(url)

# response = https.request(request)
# puts response.read_body