public class CountryService {

    final CountryDao countryDaoImpl;

    public CountryService(CountryDao countryDaoImpl) {
        this.countryDaoImpl = countryDaoImpl;
    }

    public void updateCountryInfo() {
        List<Country__c> countriesToUpsert = new List<Country__c>();

        for (Country__c remoteCountry : countryDaoImpl.getAllRemoteCountries()) {
            Country__c sCountry = countryDaoImpl.getCountryBy(remoteCountry.Name);

            if (sCountry == null || !equals(sCountry, remoteCountry)) {
                remoteCountry.Id = sCountry?.Id;
                countriesToUpsert.add(remoteCountry);
            }
        }

        countryDaoImpl.upsertCountries(countriesToUpsert, false);
    }

    @TestVisible
    private static Boolean equals(Country__c countryOne, Country__c countryTwo) {
        return countryOne.Name == countryTwo.Name &&
                countryOne.Country_Name__c == countryTwo.Country_Name__c &&
                countryOne.Capital_City__c == countryTwo.Capital_City__c &&
                countryOne.Alpha_2_Code__c == countryTwo.Alpha_2_Code__c &&
                countryOne.Alpha_3_Code__c == countryTwo.Alpha_3_Code__c &&
                countryOne.Subregion__c == countryTwo.Subregion__c &&
                countryOne.Region__c == countryTwo.Region__c &&
                countryOne.Regional_Bloc__c == countryTwo.Regional_Bloc__c;
    }
}