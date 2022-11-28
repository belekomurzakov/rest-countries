public with sharing class LeadTriggerHandler extends TriggerHandler {

    private final LeadService leadServiceImpl;
    private final List<Lead> newLeadList;
    private final List<Lead> oldLeadList;
    private final Map<Id, Lead> newLeadMap;
    private final Map<Id, Lead> oldLeadMap;

    public LeadTriggerHandler(CountryDao countryDao) {
        this.leadServiceImpl = new LeadService(countryDao);
        this.newLeadList = (List<Lead>) Trigger.new;
        this.oldLeadList = (List<Lead>) Trigger.old;
        this.newLeadMap = (Map<Id, Lead>) Trigger.newMap;
        this.oldLeadMap = (Map<Id, Lead>) Trigger.oldMap;
    }

    public override void beforeInsert() {
        leadServiceImpl.addCountryInfoDetail(null, newLeadList);
    }

    public override void beforeUpdate() {
        leadServiceImpl.addCountryInfoDetail(oldLeadMap, newLeadList);
    }
}