@IsTest
private class BaseRemoteRepositoryTest {

    @IsTest
    static void sendSuccessfulTest() {
        //given
        List<Country> input = new List<Country>{ new TestUtility.CountryFactory().getRemoteCountry() };
        BaseRemoteRepository call = setTestBase(input, 200);

        //when
        Test.startTest();
        call.send();
        Test.stopTest();

        //then
        System.assert(call.isSuccessful);
        System.assertNotEquals(null, call.getResponse());
    }

    @IsTest
    static void sendInvalidInformationByClientTest() {
        //given
        BaseRemoteRepository call = setTestBase(null, 400);

        //when
        Test.startTest();
        call.send();
        Test.stopTest();

        //then
        System.assert(!call.isSuccessful);
    }

    @IsTest
    static void sendInternalServerErrorTest() {
        //given
        BaseRemoteRepository call = setTestBase(null, 500);

        //when
        Test.startTest();
        call.send();
        Test.stopTest();

        //then
        System.assert(!call.isSuccessful);
    }

    @IsTest
    static void sendOtherTest() {
        //given
        BaseRemoteRepository call = setTestBase(null, 404);

        //when
        Test.startTest();
        call.send();
        Test.stopTest();

        //then
        System.assert(!call.isSuccessful);
    }

    @IsTest
    static void handleException() {
        //given
        Test.setMock(HttpCalloutMock.class, new TestUtility.MockRestCountry(true));
        BaseRemoteRepository call = new BaseRemoteRepository(
                HttpMethod.GET,
                Constant.COUNTRY_BASE_URL + Constant.COUNTRY_API_VERSION + Constant.COUNTRY_PATH_ALL);
        //when
        Test.startTest();
        call.send();
        Test.stopTest();

        //then
        System.assert(!call.isSuccessful);
    }

    private static BaseRemoteRepository setTestBase(List<Country> input, Integer statusCode) {
        Test.setMock(HttpCalloutMock.class, new TestUtility.MockRestCountry(input, statusCode));
        return new BaseRemoteRepository(
                HttpMethod.GET,
                Constant.COUNTRY_BASE_URL + Constant.COUNTRY_API_VERSION + Constant.COUNTRY_PATH_ALL);
    }
}