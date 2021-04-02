trigger accTrigger on Account (before update) {
    if(Trigger.isUpdate && Trigger.isbefore){
        String lgdinUsr = UserInfo.getUserId();
        String lgdinUsrName = UserInfo.getUserName();
        List<string> usrNms = new List<string>();
        for (RevShareEditRestrict__c item : RevShareEditRestrict__c.getAll().values()) {
            usrNms.add(item.Username__c);
        }
        for(Account acc: trigger.new){
            if((acc.SLASerialNumber__c != trigger.oldmap.get(acc.id).SLASerialNumber__c) && (lgdinUsr != acc.CreatedById) && (usrNms.contains(lgdinUsrName))){
                acc.addError('You are not authorized to change Rev_Share field.');
            }
        }
    }
}