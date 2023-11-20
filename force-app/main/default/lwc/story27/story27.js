import { LightningElement, wire } from 'lwc'; 
import getNames from '@salesforce/apex/Story27.getNames';
import{NavigationMixin} from "lightning/navigation";
        
export default class Story27 extends NavigationMixin (LightningElement) {
  filterWord = '';
  nameList;
 
    @wire(getNames, { filter: '$filterWord' }) nameList; 
    handleInput(event) {
    this.filterWord = event.target.value;
    }
    navigateToViewRecordPage(){
        /*var recId=event.target.recordId*/
        this[NavigationMixin.Navigate]({
            type:"standard__recordPage",
            attributes:{
                recordId:"a067R00003ECiDWQA1",
                objectApiName:"SA_Details__c",
                actionName:"view",
            },
        });
    }
    
}