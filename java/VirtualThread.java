import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

int NUM_THREADS = 8000;
String ENDPOINT_URL = "http://host.docker.internal:8080/echo";

void main() throws InterruptedException {
  System.out.println(NUM_THREADS + " threads will be created");
  System.out.println(ENDPOINT_URL + " will be called");
  HttpClient client = HttpClient.newHttpClient();

  Runnable runnable = () -> {
    HttpRequest request = HttpRequest.newBuilder()
      .uri(URI.create(ENDPOINT_URL))
      .GET()
      .build();

    try {
      client.send(request, HttpResponse.BodyHandlers.ofString());
    } catch (Exception e) {
      e.printStackTrace();
    }
  };

  long startTime = System.currentTimeMillis();
  List<Thread> virtualThreads = new ArrayList<>();
  for (int i = 0; i < NUM_THREADS; i++) {
    virtualThreads.add(Thread.ofVirtual().start(runnable));
  }

  for (Thread virtualThread : virtualThreads) {
    virtualThread.join();
  }

  long endTime = System.currentTimeMillis();
  long elapsedTime = endTime - startTime;

  System.out.println("All virtual threads completed.");
  System.out.println("Elapsed time: " + elapsedTime + " milliseconds.");
}