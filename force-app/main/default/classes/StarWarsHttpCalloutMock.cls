@isTest
global class StarWarsHttpCalloutMock implements HttpCalloutMock {
	// Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{\"name\": \"Luke Skywalker\", \"height\": \"172\", \"hair_color\": \"blond\", \"skin_color\": \"fair\", \"birth_year\": \"19BBY\", \"gender\": \"male\", \"homeworld\": \"http://swapi.dev/api/planets/1/\", \"films\": [ \"http://swapi.dev/api/films/1/\", \"http://swapi.dev/api/films/2/\", \"http://swapi.dev/api/films/3/\", \"http://swapi.dev/api/films/6/\" ]}');
        response.setStatusCode(200);
        return response; 
    }
}