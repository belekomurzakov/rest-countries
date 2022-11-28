public with sharing class LeadService {

    private final CountryDao countryDaoImpl;

    public LeadService(CountryDao countryDao) {
        countryDaoImpl = countryDao;
    }

    /**
     * Method adds Country Details to Lead record on insert and update
     *
     * @param oldMap - old Lead values
     * @param newList - new Lead values
     */
    public void addCountryInfoDetail(Map<Id, Lead> oldMap, List<Lead> newList) {
        Map<String, Country__c> countriesByName = countryDaoImpl.getAllCountriesByName();

        for (Lead lead : newList) {
            if ((oldMap == null || oldMap.get(lead.Id).Country != lead.Country) &&
                    countriesByName.get(lead.Country) != null) {

                lead.Alpha_2_Code__c = countriesByName.get(lead.Country).Alpha_2_Code__c;
                lead.Alpha_3_Code__c = countriesByName.get(lead.Country).Alpha_3_Code__c;
                lead.Capital_City__c = countriesByName.get(lead.Country).Capital_City__c;
                lead.Regional_Bloc__c = countriesByName.get(lead.Country).Regional_Bloc__c;
                lead.Region__c = countriesByName.get(lead.Country).Region__c;
                lead.Subregion__c = countriesByName.get(lead.Country).Subregion__c;
            }
        }
    }
}