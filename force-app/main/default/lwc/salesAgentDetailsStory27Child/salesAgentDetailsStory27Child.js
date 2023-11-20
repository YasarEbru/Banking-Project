import { LightningElement ,wire ,api} from 'lwc';
import  getNames  from '@salesforce/apex/SADetailsClass.SADetailsMethod';

export default class SalesAgentDetailsStory27Child extends LightningElement {
    filterWord='';
    nameList;
    
    @wire(getNames,{filter:'$filterWord'}) nameList;
    handleInput(event){
      this.filterWord=event.target.value;
    }

}