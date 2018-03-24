global class EinsteinChatbotsFindContact {
    @InvocableMethod(label='Einstein Chatbots - Find Contact By Email')
    global static List<Contact> findContactsfromEmail(List<string> requests) 
    {
        List<Contact> results = new List<Contact>();
        for (string request : requests) 
        {
            if (String.IsNotBlank(request))
            {
                Contact newContact = findContactfromEmail(request);
                if (newContact != null && string.isNotBlank(newContact.Id))
                {
                    results.add(findContactfromEmail(request));   
                }
            }      
        }
        if (results.size() == 0) 
        {
            return new List<Contact>{new Contact()};
        }
        return results;
    }
    
    public static Contact findContactfromEmail(string request) 
    {
        LIST<Contact> newContacts = [SELECT Id, FirstName, LastName, Email, Phone, Title, MailingAddress FROM Contact WHERE email =: request LIMIT 1];      
        
        if (newContacts != null && newContacts.size() > 0) {
            return newContacts[0];
        } else {
            return new Contact();
        }
    }
}