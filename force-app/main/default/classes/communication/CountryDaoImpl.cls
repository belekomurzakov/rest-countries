public class CountryDaoImpl implements CountryDao {

    public List<Country__c> getAllRemoteCountries() {
        BaseRemoteRepository call = new BaseRemoteRepository(
                HttpMethod.GET,
                Constant.COUNTRY_BASE_URL + Constant.COUNTRY_API_VERSION + Constant.COUNTRY_PATH_ALL);

        call.send();

        if (!call.isSuccessful) {
            // TODO: Log error
        }

        return Country.castToListSObject(Country.parseList(call.getResponse()));
    }

    public List<Country__c> getAllCountries() {
        return Country__c.getAll().values();
    }

    public Map<String, Country__c> getAllCountriesByName() {
        Map<String, Country__c> countriesByName = new Map<String, Country__c>();

        for (Country__c country : getAllCountries()) {
            countriesByName.put(country.Country_Name__c, country);
        }

        return countriesByName;
    }

    public Country__c getCountryBy(String numericCode) {
        return Country__c.getValues(numericCode);
    }

    public void upsertCountries(List<Country__c> countries, Boolean allOrNothing) {
        Database.upsert(countries, false);
        // TODO: Log error
    }
}