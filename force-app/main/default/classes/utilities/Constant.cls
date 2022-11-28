public class Constant {

    public final static String COUNTRY_BASE_URL {
        get {
            return get('COUNTRY_BASE_URL');
        }
    }

    public final static String COUNTRY_API_VERSION {
        get {
            return get('COUNTRY_API_VERSION');
        }
    }

    public final static String COUNTRY_PATH_ALL {
        get {
            return get('COUNTRY_PATH_ALL');
        }
    }

    static String get(String key) {
        return Constant__mdt.getInstance(key)?.Value__c;
    }
}