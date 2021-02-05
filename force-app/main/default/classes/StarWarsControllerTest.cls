@isTest
public class StarWarsControllerTest { 	
    //method arg
    static Integer swId = 1;
    @isTest
    public static void setSwIdTest(){
        // the expected returned value from callout
        StarWarsApiResponse expected = new StarWarsApiResponse();
        Test.startTest();
        // This causes a fake response to be sent
        HttpResponse response = calloutTest(swId);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into StarWarsApiResponse of reference data types.
            expected = (StarWarsApiResponse) JSON.deserialize(response.getBody(), StarWarsApiResponse.class);
        }
        //call the method to test it
        StarWarsApiResponse actual = StarWarsController.setSwId(swId);
        Test.stopTest();
        //Assert Results    
        System.assertEquals(expected.name, actual.name);
        
    }
    @isTest
    public static void saveRecordTest(){
        //Arg method takes
        StarWarsApiResponse swRes = new StarWarsApiResponse();
        swRes.name = 'swResTest';
        swRes.birth_year = '19BBY';
        swRes.hair_color='black';
        swRes.height = '150';
        swRes.skin_color='fair';
        swRes.homeworld='http://swapi.dev/api/planets/1/';
        swRes.films = new List<String>{'http://swapi.dev/api/films/1/', 'http://swapi.dev/api/films/2/'};
            //Returned value method returns
            Star_Wars_character__c expected = new Star_Wars_character__c();
        expected.Name = swRes.name;
        expected.birth_year__c = swRes.birth_year;
        expected.hair_color__c = swRes.hair_color;
        expected.height__c = swRes.height;
        expected.skin_color__c = swRes.skin_color;
        expected.homeworld__c = swRes.homeworld;
        expected.films__c = swRes.films[0];
        
        //to test duplicate values
        Integer count = 0;
        Star_Wars_character__c actual = new Star_Wars_character__c();
      Test.startTest();
        Do{ 
            try{
                count++;       
                    //Call method to test
                    actual = StarWarsController.saveRecord(swRes);              
                //Assert Results
                if(actual != null){
                    System.assertEquals(expected.Name, actual.name); 
                }
                
            }catch(DmlException e){
                System.assert(e.getMessage().contains('Duplicate'));
                System.assertEquals(null, actual);
            }
        }while(count <2);
        
       Test.stopTest();        
    }
    @isTest
    public static void makeGetCalloutTest(){
        Test.startTest();
        HttpResponse response =	calloutTest(swId) ;
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{\"name\": \"Luke Skywalker\", \"height\": \"172\", \"hair_color\": \"blond\", \"skin_color\": \"fair\", \"birth_year\": \"19BBY\", \"gender\": \"male\", \"homeworld\": \"http://swapi.dev/api/planets/1/\", \"films\": [ \"http://swapi.dev/api/films/1/\", \"http://swapi.dev/api/films/2/\", \"http://swapi.dev/api/films/3/\", \"http://swapi.dev/api/films/6/\" ]}'; 
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode()); 
        Test.stopTest();
    }
    
    private static HttpResponse calloutTest(Integer swId){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new StarWarsHttpCalloutMock());   
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse response = StarWarsController.makeGetCallout(swId);
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        
        return response;
    }
    
}