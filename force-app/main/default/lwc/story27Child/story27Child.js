import { LightningElement, wire, api} from 'lwc';
import getSADetails from '@salesforce/apex/Story27.getSADetails';

export default class Story27 extends LightningElement {
   @api saList;
    @wire(getSADetails,) saList;

    handleClick() {
        const myEvent = new CustomEvent('clicked', { detail: this.recordId });
        
        this.dispatchEvent(myEvent);
    }
   
}