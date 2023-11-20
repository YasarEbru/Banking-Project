import { LightningElement,api } from 'lwc';

export default class SaTile extends LightningElement {
    @api sadetail;

    handleOpenRecordClick(){
        const selectEvent=new CustomEvent("saview",{
            detail: this.sadetail.Id
        });
        this.dispatchEvent(selectEvent);
    }
    get avatarUrl(){
        if(this.sadetail.Gender__c==='Male'){
            return 'https://www.lightningdesignsystem.com/assets/images/avatar1.jpg';
        }else if(this.sadetail.Gender__c==='Female'){
            return 'https://www.lightningdesignsystem.com/assets/images/avatar2.jpg';
        }
        else{
            return '';
        }
    }
}