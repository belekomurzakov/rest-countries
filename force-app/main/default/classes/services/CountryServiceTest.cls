@IsTest(SeeAllData=false)
private class CountryServiceTest {

    @IsTest
    static void updateCountryInfoPositiveTest() {
        //given
        CountryDao countryDaoImpl = new CountryDaoMockImpl();
        CountryService countryServiceImpl = new CountryService(countryDaoImpl);
        //when
        Test.startTest();
        countryServiceImpl.updateCountryInfo();
        Test.stopTest();
        //then
        System.assertEquals(
                countryDaoImpl.getAllRemoteCountries(),
                countryDaoImpl.getAllCountries()
        );

    }

    @IsTest
    static void equalsPositiveTest() {
        //given
        Country__c firCountry = new TestUtility.CountryFactory().getCzechRepublic();
        Country__c secCountry = new TestUtility.CountryFactory().getCzechRepublic();
        //when + then
        Test.startTest();
        System.assert(CountryService.equals(firCountry, secCountry));
        Test.stopTest();
    }

    @IsTest
    static void equalsNegativeTest() {
        //given
        Country__c firCountry = new TestUtility.CountryFactory().getCzechRepublic();
        Country__c secCountry = new TestUtility.CountryFactory().getVietnam();
        //when + then
        Test.startTest();
        System.assert(!CountryService.equals(firCountry, secCountry));
        Test.stopTest();
    }

    @IsTest
    static void parseListTest() {
        //given
        Country testCountry = new TestUtility.CountryFactory().getRemoteCountry();
        List<Country> input = new List<Country>{ testCountry };
        String json = JSON.serialize(input);

        //when
        Test.startTest();
        List<Country> output = Country.parseList(json);
        Test.stopTest();
        //then
        System.assertEquals(output[0].name, input[0].name);
        System.assertEquals(output[0].region, input[0].region);
        System.assertEquals(output[0].capital, input[0].capital);
        System.assertEquals(output[0].subregion, input[0].subregion);
        System.assertEquals(output[0].alpha2Code, input[0].alpha2Code);
        System.assertEquals(output[0].alpha3Code, input[0].alpha3Code);
        System.assertEquals(output[0].numericCode, input[0].numericCode);
    }

    @IsTest
    static void castToListSObjectTest() {
        //given
        Country testCountry = new TestUtility.CountryFactory().getRemoteCountry();
        List<Country> input = new List<Country>{ testCountry };
        //when
        Test.startTest();
        List<Country__c> output = Country.castToListSObject(input);
        Test.stopTest();
        //then
        System.assertEquals(output[0].Name, input[0].numericCode);
        System.assertEquals(output[0].Region__c, input[0].region);
        System.assertEquals(output[0].Capital_City__c, input[0].capital);
        System.assertEquals(output[0].Subregion__c, input[0].subregion);
        System.assertEquals(output[0].Alpha_2_Code__c, input[0].alpha2Code);
        System.assertEquals(output[0].Alpha_3_Code__c, input[0].alpha3Code);
        System.assertEquals(output[0].Country_Name__c, input[0].name);
    }

    @IsTest
    static void testSchedulableJob() {
        String chronForEverydayRun = '0 1 * * * ?';
        CountryInfoUpdateJob job = new CountryInfoUpdateJob();
        job.countryDaoImpl = new CountryDaoMockImpl();

        Test.startTest();
        System.schedule('Test Schedulable', chronForEverydayRun, job);
        Test.stopTest();
    }
}