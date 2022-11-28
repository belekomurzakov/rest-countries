trigger LeadTrigger on Lead (before insert, before update) {
    new LeadTriggerHandler(new CountryDaoImpl()).run();
}