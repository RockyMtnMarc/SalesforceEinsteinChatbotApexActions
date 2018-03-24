global class EinsteinChatbotsSearchArticles {
     global class KnowledgeArticleTitleRequest {
         @InvocableVariable
        global string category;
         
         @InvocableVariable
         global String queryString;
    }      
    
    global class KnowledgeArticleTitleResult {
        @InvocableVariable
        global String KnowledgeTitle;
        
        @InvocableVariable
        global String ChatAnswer;
    }
    
    @InvocableMethod(label='KnowledgeArticlesSearchAndFilter')
    global static List<List<Knowledge__kav>> fetchKnowledgeArticleSearchAndFilter(List<KnowledgeArticleTitleRequest> queryParams) {
        List<List<Knowledge__kav>> results = new List<List<Knowledge__kav>>();
        for(KnowledgeArticleTitleRequest param : queryParams) {
            results.add(fetchKnowledgeArticle(param.category, param.queryString));                         
        }
        return results;

    }    
    
    public static List<SObject> fetchKnowledgeArticle(string category, string searchQuery) {
        KnowledgeArticleTitleResult result = new KnowledgeArticleTitleResult();    
        
        category = String.join(category.split(' '), '_') + '__c';
        category = category == 'All__c' ? 'below ' + category :  'above ' + category;
        string searchString = 'FIND \'' + searchQuery + '*\' IN ALL FIELDS RETURNING Knowledge__kav (ID, Title,Chat_Answer__c, UrlName, KnowledgeArticleId) WITH DATA CATEGORY Product__c '+ category +' limit 3';
        system.debug(searchString);
        List<List<SObject>> catdata = Search.query(searchString);
  
        return catdata[0];
    }
   
}