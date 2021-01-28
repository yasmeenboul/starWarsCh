public class StarWarsApiResponse {
    @AuraEnabled public String name{set;get;}
    @AuraEnabled public String height{set;get;}
    @AuraEnabled public String hair_color{set;get;}
    @AuraEnabled public String skin_color{set;get;}
    @AuraEnabled public String birth_year{set;get;}
    @AuraEnabled public String homeworld{set;get;}
    @AuraEnabled public List<String> films{set;get;}
        
    public static StarWarsApiResponse parse(String json) {
        return (StarWarsApiResponse) System.JSON.deserialize(json, StarWarsApiResponse.class);
    }
    
    
}