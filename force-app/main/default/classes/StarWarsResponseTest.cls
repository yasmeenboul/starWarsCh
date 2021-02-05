@IsTest
public class StarWarsResponseTest {
	
	static testMethod void testParse() {
		String json = '{'+
            '\"name\": \"Luke Skywalker\", \"height\": \"172\", \"hair_color\": \"blond\", \"skin_color\": \"fair\", \"eye_color\": \"blue\", \"birth_year\": \"19BBY\", \"gender\": \"male\", \"homeworld\": \"http://swapi.dev/api/planets/1/\", \"films\": [ \"http://swapi.dev/api/films/1/\", \"http://swapi.dev/api/films/2/\", \"http://swapi.dev/api/films/3/\", \"http://swapi.dev/api/films/6/\" ]}';
		StarWarsApiResponse obj = StarWarsApiResponse.parse(json);
		System.assert(obj != null);
	}
}