@IsTest(SeeAllData=false)
private class LeadServiceTest {

    @IsTest
    static void addCountryInfoDetailTest() {
        //given
        LeadService leadServiceImpl = new LeadService(new CountryDaoMockImpl());
        Lead leadToInsert = new Lead(
                LastName = 'Test',
                Country = 'Czech Republic',
                Company = 'Test',
                LeadSource = 'Web',
                NumberOfEmployees = 10
        );

        //when
        Test.startTest();
        leadServiceImpl.addCountryInfoDetail(null, new List<Lead>{ leadToInsert });
        Test.stopTest();
        //then
        System.assertEquals('Europe', leadToInsert.Region__c);
        System.assertEquals('Central Europe', leadToInsert.Subregion__c);
        System.assertEquals('CZE', leadToInsert.Alpha_3_Code__c);
        System.assertEquals('CZ', leadToInsert.Alpha_2_Code__c);
        System.assertEquals('EU', leadToInsert.Regional_Bloc__c);
    }

    @IsTest
    static void triggerIntegrationTest() {
        insert new TestUtility.CountryFactory().getCzechRepublic();

        Lead testLead = new Lead(
                LastName = 'Test',
                Country = 'Czech Republic',
                Company = 'Test',
                LeadSource = 'Web',
                NumberOfEmployees = 10
        );
        insert testLead;

        Test.startTest();
        update testLead;
        Test.stopTest();
    }
}