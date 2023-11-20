import { LightningElement , wire} from 'lwc';
import  elma  from '@salesforce/apex/SADetailsClass.getAgents';
export default class SearchSA28Child extends LightningElement { 
      filterWord='';
        details;
        error;
    @wire(elma, {filter:'$filterWord'}) details;
    
    handleInput(event){
        this.filterWord=event.target.value;
    }
    handleSearchSA(){
      elma({filter:this.filterWord})
      .then(result=>{
        this.details=result;
        
      })  
      .catch(error=>{
        this.error=error;
        
      })
    }
    }