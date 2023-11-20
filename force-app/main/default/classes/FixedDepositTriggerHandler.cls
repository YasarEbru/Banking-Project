public class FixedDepositTriggerHandler {
    
    public static void populateRelOfficer(List<FD_Details__c> fdList){
        //Brach-Relation Officer objectinden sorgulanacak Branclar colection haline getirildi.
        Set<String> branchNames = new Set<String>();
        for(FD_Details__c fd : fdList){
            if(String.isNotBlank(fd.Branch__c)){
                branchNames.add(fd.Branch__c);
            }
            
        }
        //İlgili branchlarda gögrevli Relationship Officer bilgileri sorgu ile çekilir
        List<Branch_Relationship_Officer__c> broList = [SELECT Id, Branch_Name__c, Relationship_Officer__c
                                                       FROM Branch_Relationship_Officer__c
                                                       WHERE Branch_Name__c IN :branchNames];
        
      //Branch-RO eşleştirilmesini Map formata çevirelim. Bu sayede MAp in kullanaışlı methodlarından faydalanabiliriz Ör:get()
      
        Map<String, String> branchRelMap = new Map<String, String>();
        for(Branch_Relationship_Officer__c bro : broList){
            branchRelMap.put(bro.Branch_Name__c, bro.Relationship_Officer__c);
        }
        
        //FD Details objectindeki Relationship Officer fieldına, Master objecten çekilen Relationship Officer bilgisini atayalım.
        for(FD_Details__c fd : fdList){
            if(String.isNotBlank(fd.Branch__c)){
                fd.Relationship_Officer__c = branchRelMap.get(fd.Branch__c);
                
            }
        }
    }
    
    public static void shareWithRelOfficerAfterInsert(List<FD_Details__c> fdList){
        
        List<FD_Details__Share> fdsList = new List<FD_Details__Share>();
        for(FD_Details__c fd : fdList){
            if(String.isNotBlank(fd.Relationship_Officer__c)){
                
              fdsList.add(createShareInstance(fd.Id,fd.Relationship_Officer__c));
               
            }
            if(String.isNotBlank(fd.Sales_Representative__c)){
                
              fdsList.add(createShareInstance(fd.Id,fd.Sales_Representative__c));
               
            }
        }
        Database.insert(fdsList, false);
    }
    
    
    public static void shareWithRelOfficerAfterUpdate(List<FD_Details__c> fdList ,Map<Id,FD_Details__c>fdOldMap){
        
         List<FD_Details__Share> fdsList = new List<FD_Details__Share>();
           List<FD_Details__Share> fdsOldToDelete = new List<FD_Details__Share>();
        for(FD_Details__c fd : fdList){
            //Relationship Officer bilgisinin degistigini kontrol ediyoruz .
            if(String.isNotBlank(fd.Relationship_Officer__c) && fd.Relationship_Officer__c!=fdOldMap.get(fd.Id).Relationship_Officer__c){
                //Share Object ine eklenecek yeni instance olusturuyoruz.
                fdsList.add(createShareInstance(fd.Id,fd.Relationship_Officer__c));
                
                List<FD_Details__Share>fdsOld =[SELECT Id, RowCause
                                                FROM FD_Details__Share 
                                                WHERE ParentId=:fd.Id 
                                                AND UserOrGroupId =:fdOldMap.get(fd.Id).Relationship_Officer__c 
                                                AND RowCause='Manual'];
                                                           
                if(fdsOld!=null){
                    fdsOldToDelete.addAll(fdsOld);
                }
               
            }
             if(String.isNotBlank(fd.Sales_Representative__c) && fd.Sales_Representative__c!=fdOldMap.get(fd.Id).Relationship_Officer__c){
                //Share Object ine eklenecek yeni instance olusturuyoruz.
                fdsList.add(createShareInstance(fd.Id,fd.Sales_Representative__c));
                
                List<FD_Details__Share>fdsOld2 =[SELECT Id, RowCause
                                                FROM FD_Details__Share 
                                                WHERE ParentId=:fd.Id 
                                                AND UserOrGroupId =:fdOldMap.get(fd.Id).Sales_Representative__c
                                                AND RowCause='Manual'];
                                                           
                if(fdsOld2!=null){
                    fdsOldToDelete.addAll(fdsOld2);
                }
               
            }
        }
       
        Database.insert(fdsList,false);
        Database.delete(fdsOldToDelete,false);
    }
    
    private static  FD_Details__Share createShareInstance(String parentId , String userOrGroupId){
        FD_Details__Share fds = new FD_Details__Share();
                fds.ParentId = parentId;
                fds.UserOrGroupId = UserOrGroupId;
                fds.AccessLevel = 'Read'; //Read veya Edit yazılabilir
                fds.RowCause = 'Manual'; //her zaman Manual girilir
        return fds;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}