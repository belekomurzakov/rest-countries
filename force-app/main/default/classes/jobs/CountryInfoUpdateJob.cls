public class CountryInfoUpdateJob implements Schedulable {

    public CountryDao countryDaoImpl {
        get {
            if (countryDaoImpl == null) {
                countryDaoImpl = new CountryDaoImpl();
            }
            return countryDaoImpl;
        }
        set;
    }

    /**
     * Job updates or insert new records, if there is any changes on service.
     */
    public void execute(SchedulableContext SC) {
        CountryService countryServiceImpl = new CountryService(countryDaoImpl);
        countryServiceImpl.updateCountryInfo();
    }
}
