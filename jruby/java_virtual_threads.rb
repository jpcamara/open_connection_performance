require "java"

java_import "java.net.URI"
java_import "java.net.http.HttpClient"
java_import "java.net.http.HttpRequest"
java_import "java.net.http.HttpResponse"
java_import "java.util.ArrayList"

NUM_THREADS = 8000
ENDPOINT_URL = "http://host.docker.internal:8080/echo"

class HttpTask
  include java.lang.Runnable

  def run
    client = HttpClient.new_http_client
    request = HttpRequest.new_builder
                         .uri(URI.new(ENDPOINT_URL))
                         .GET
                         .build

    begin
      client.send(request, HttpResponse::BodyHandlers.of_string)
    rescue => e
      e.print_stack_trace
    end

    return nil
  end
end

start_time = java.lang.System.current_time_millis

# Create and start virtual threads
virtual_threads = ArrayList.new
NUM_THREADS.times do
  task = HttpTask.new
  virtual_threads.add(java.lang.Thread.of_virtual().start(task))
end

# Wait for all virtual threads to complete
virtual_threads.each do |virtual_thread|
  virtual_thread.join
end

end_time = java.lang.System.current_time_millis
elapsed_time = end_time - start_time

puts "All virtual threads completed."
puts "Elapsed time: #{elapsed_time} milliseconds."