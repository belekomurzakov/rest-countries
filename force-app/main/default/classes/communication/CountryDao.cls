public interface CountryDao {

    List<Country__c> getAllRemoteCountries();
    List<Country__c> getAllCountries();
    Map<String, Country__c> getAllCountriesByName();
    Country__c getCountryBy(String numericCode);
    void upsertCountries(List<Country__c> countries, Boolean allOrNothing);
}