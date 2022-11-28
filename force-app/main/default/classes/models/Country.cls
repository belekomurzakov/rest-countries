public class Country {

    public String name;
    public String alpha2Code;
    public String alpha3Code;
    public String capital;
    public String subregion;
    public String region;
    public String numericCode;
    public List<RegionalBlocs> regionalBlocs;

    public class RegionalBlocs {
        public String acronym;
    }

    /**
     * Method parse json to List<Country>
     *
     * @param json - response
     * @return List<Country>
     */
    public static List<Country> parseList(String json) {
        return (List<Country>) System.JSON.deserialize(json, List<Country>.class);
    }

    /**
     * Method casts List of Country to List of SObject records
     *
     * @param countries - List<Country>
     * @return List<Country__c>
     */
    public static List<Country__c> castToListSObject(List<Country> countries) {
        List<Country__c> sCountries = new List<Country__c>();

        for (Country country : countries) {
            sCountries.add(castToSObject(country));
        }

        return sCountries;
    }

    /**
     * Method casts single Country object to single Country SObject record
     *
     * @param country Country
     * @return Country__c
     */
    private static Country__c castToSObject(Country country) {
        return new Country__c(
                Name = country.numericCode,
                Country_Name__c = country.name,
                Capital_City__c = country.capital,
                Alpha_2_Code__c = country.alpha2Code,
                Alpha_3_Code__c = country.alpha3Code,
                Subregion__c = country.subregion,
                Region__c = country.region,
                Regional_Bloc__c = country.regionalBlocs?.get(0).acronym
        );
    }
}