public with sharing class StarWarsController {
   
    @AuraEnabled
    public static StarWarsApiResponse setSwId(Integer swId){
        StarWarsApiResponse swRes = new StarWarsApiResponse();
        if(swId != null){
          HttpResponse response =  makeGetCallout(swId);
            // If the request is successful, parse the JSON response.
            if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into StarWarsApiResponse of reference data types.
                swRes = (StarWarsApiResponse) JSON.deserialize(response.getBody(), StarWarsApiResponse.class);
            }
        }
        return swRes;
    }
    @AuraEnabled
    public static Star_Wars_character__c saveRecord(StarWarsApiResponse swRes){
        try {
       Star_Wars_character__c swChar = new Star_Wars_character__c();
       swChar.Name = swRes.name;
       swchar.Height__c = swRes.height;
       swChar.Hair_color__c = swRes.hair_color;
       swChar.Homeworld__c = swRes.homeworld;
       swchar.Skin_color__c = swRes.skin_color;
       swChar.Films__c = swRes.films[0];
       swChar.Birth_year__c = swRes.birth_year;
       
       insert swChar;
            
       return swChar;    
        } catch (DmlException e) {
            System.debug(e.getMessage());
           return null;
        }
    }
    public static HttpResponse makeGetCallout(Integer swId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept','application/json');
        request.setEndpoint('https://swapi.dev/api/people/'+swId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        while (response.getStatusCode() == 301 || response.getStatusCode() == 302)
        {
            request.setEndpoint(response.getHeader('Location'));
            response = new Http().send(request);
        }
      

        return response;

    }
  




}