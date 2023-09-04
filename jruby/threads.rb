require "net/http"

start = Time.now
8000.times.map do
  Thread.new { Net::HTTP.get(URI("http://host.docker.internal:8080/echo")) }
end.map(&:value)
puts "Time: #{Time.now - start}"