public class BaseRemoteRepository {

    private static final Integer TIMEOUT = 120000;

    private final Http http;
    private final HttpRequest request;
    private HttpResponse response;

    public Boolean isSuccessful;

    public BaseRemoteRepository(HttpMethod method, String endpoint) {
        http = new Http();
        request = new HttpRequest();
        request.setMethod(method.name());
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(endpoint);
        request.setTimeout(TIMEOUT);
    }

    public String getResponse() {
        return response?.getBody();
    }

    public void send() {
        try {
            response = http.send(request);
        } catch (Exception e) {
            isSuccessful = false;
            // TODO: Log error
            return;
        }

        switch on response.getStatusCode() {
            when 200 {
                isSuccessful = true;
            }
            when 400 {
                isSuccessful = false;
                // TODO: Log error
            }
            when 500 {
                isSuccessful = false;
                // TODO: Log error
            }
            when else {
                isSuccessful = false;
                // TODO: Log error
            }
        }
    }
}