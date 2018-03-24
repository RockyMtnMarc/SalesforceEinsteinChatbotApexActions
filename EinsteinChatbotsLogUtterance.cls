public class EinsteinChatbotsLogUtterance 
{
    public class EinsteinChatbotsLogUtteranceRequest
    {
        @InvocableVariable
        public String CurrentUtterance;
        @InvocableVariable
        public Decimal ConfidenceForUtterance;
        @InvocableVariable
        public String DialogId;
        @InvocableVariable
        public String DialogName;
        @InvocableVariable
        public Decimal ModelThresholdHigh;
        @InvocableVariable
        public Id LiveChatTranscriptId;
        //@InvocableVariable
        //public Boolean wasCorrect;
    }
    
    
    @InvocableMethod(label='Einstein Chatbots - Log an Utterance' description='Logs an Utterance for Einsten Chatbots')
    public static List<Boolean> LogEinstienChatbotsUtterance(List<EinsteinChatbotsLogUtteranceRequest> requests) 
    {
                
        //Create Utterances
        List<Utterance__c> newUtterances = new List<Utterance__c>();
        for(EinsteinChatbotsLogUtteranceRequest r : requests){
            Utterance__c u = new Utterance__c();
            u.Utterance_Text__c = r.CurrentUtterance;
            u.Confidence_For_Utterance__c = r.ConfidenceForUtterance;
            u.Dialog_Id__c = r.DialogId;
            u.Dialog_Name__c = r.DialogName;
            u.Model_Threshold_High__c = r.ModelThresholdHigh;
            u.Live_Chat_Transcript__c = r.LiveChatTranscriptId;
            //if (r.wasCorrect != null && r.wasCorrect){u.CorrectMapping__c = 'Yes';}  
            //if (r.wasCorrect != null && !r.wasCorrect){u.CorrectMapping__c = 'No';}  
            newUtterances.add(u);        
        }
        System.debug(newUtterances.size());
        
        try{
            insert newUtterances;
        }catch(Exception e){
             System.debug(e.getMessage());
            return new List<Boolean>{false};
                
        }
        
        
        return new List<Boolean>{true};
    }

}