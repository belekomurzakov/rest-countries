@IsTest
public class CountryDaoMockImpl implements CountryDao {

    final List<Country__c> remoteCountries = new List<Country__c>{
            new TestUtility.CountryFactory().getCzechRepublic(),
            new TestUtility.CountryFactory().getVietnam()
    };

    final Set<Country__c> localCountries = new Set<Country__c>{
            new TestUtility.CountryFactory().getCzechRepublic()
    };

    public List<Country__c> getAllRemoteCountries() {
        return remoteCountries;
    }

    public List<Country__c> getAllCountries() {
        return new List<Country__c>(localCountries);
    }

    public Map<String, Country__c> getAllCountriesByName() {
        Map<String, Country__c> countryMap = new Map<String, Country__c>();

        for (Country__c country : localCountries) {
            countryMap.put(country.Country_Name__c, country);
        }

        return countryMap;
    }

    public Country__c getCountryBy(String numericCode) {
        for (Country__c country : localCountries) {
            if (country.Name == numericCode) {
                return country;
            }
        }
        return null;
    }

    public void upsertCountries(List<Country__c> countries, Boolean allOrNothing) {
        localCountries.addAll(countries);
    }
}