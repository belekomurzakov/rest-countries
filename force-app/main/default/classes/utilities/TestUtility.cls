@IsTest
public class TestUtility {

    public class MockRestCountry implements HttpCalloutMock {

        final List<Country> countriesResponse;
        final Integer statusCode;
        Boolean throwException = false;

        public MockRestCountry(List<Country> countriesResponse, Integer statusCode) {
            this.countriesResponse = countriesResponse;
            this.statusCode = statusCode;
        }

        public MockRestCountry(Boolean throwException) {
            this.throwException = throwException;
        }

        public HttpResponse respond(HttpRequest req) {
            if (throwException) {
                throw new CalloutException();
            }

            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');

            String json = JSON.serialize(countriesResponse);

            res.setBody(json);
            res.setStatusCode(statusCode);
            return res;
        }
    }

    public class CountryFactory {

        public Country__c getCzechRepublic() {
            return new Country__c(
                    Name = '203',
                    Country_Name__c = 'Czech Republic',
                    Regional_Bloc__c = 'EU',
                    Capital_City__c = 'Prague',
                    Alpha_2_Code__c = 'CZ',
                    Alpha_3_Code__c = 'CZE',
                    Subregion__c = 'Central Europe',
                    Region__c = 'Europe'
            );
        }

        public Country__c getVietnam() {
            return new Country__c(
                    Name = '704',
                    Country_Name__c = 'Vietnam',
                    Regional_Bloc__c = 'ASEAN',
                    Capital_City__c = 'Prague',
                    Alpha_2_Code__c = 'VN',
                    Alpha_3_Code__c = 'VNM',
                    Subregion__c = 'South-Eastern Asia',
                    Region__c = 'Asia'
            );
        }

        public Country getRemoteCountry() {
            Country testCountry = new Country();
            testCountry.name = 'Kyrgyzstan';
            testCountry.alpha2Code = 'KG';
            testCountry.alpha3Code = 'KGZ';
            testCountry.capital = 'Bishkek';
            testCountry.subregion = 'Central Asia';
            testCountry.region = 'Asia';
            testCountry.numericCode = '001';
            return testCountry;
        }
    }
}