@IsTest(SeeAllData=false)
private class CountryDaoImplTest {

    @IsTest
    static void getAllRemoteCountriesPositiveTest() {
        //given
        List<Country> input = new List<Country>{ new TestUtility.CountryFactory().getRemoteCountry() };
        Test.setMock(HttpCalloutMock.class, new TestUtility.MockRestCountry(input, 200));
        CountryDao countryDaoImpl = new CountryDaoImpl();

        //when
        Test.startTest();
        List<Country__c> output = countryDaoImpl.getAllRemoteCountries();
        Test.stopTest();

        //then
        System.assertEquals(output[0].Country_Name__c, input[0].name);
        System.assertEquals(output[0].Capital_City__c, input[0].capital);
        System.assertEquals(output[0].Region__c, input[0].region);
        System.assertEquals(output[0].Subregion__c, input[0].subregion);
    }

    @IsTest
    static void getCountryByTest() {
        //given
        CountryDaoImpl countryDaoImpl = new CountryDaoImpl();
        Country__c cz = new TestUtility.CountryFactory().getCzechRepublic();

        //when
        Test.startTest();
        countryDaoImpl.upsertCountries(new List<Country__c>{ cz }, false);
        Country__c country = countryDaoImpl.getCountryBy('203');
        Test.stopTest();

        //then
        System.assertEquals(cz.Country_Name__c, country.Country_Name__c);
        System.assertEquals(cz.Region__c, country.Region__c);
        System.assertEquals(cz.Subregion__c, country.Subregion__c);
        System.assertEquals(cz.Capital_City__c, country.Capital_City__c);
    }
}