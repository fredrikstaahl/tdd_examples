/**
 * Opportunity trigger using helper class
 */
trigger OpportunityTrigger on Opportunity(before insert, before update, after insert, after update) {
    if (Trigger.isUpdate && Trigger.isInsert) {
    }

}
