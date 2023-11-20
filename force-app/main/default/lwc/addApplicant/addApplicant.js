import { LightningElement ,wire ,api } from 'lwc';
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import JUNCTION_OBJECT from "@salesforce/schema/FD_Applicant_Junction__c";
import TYPE_FIELD from "@salesforce/schema/FD_Applicant_Junction__c.Type__c";

export default class AddApplicant extends LightningElement {
    @api recordId
    applTypeOptions
    selectedApplType
    showAddApplicant=false

    //Applicant  Type Combobox

@wire(getObjectInfo, {objectApiName:JUNCTION_OBJECT})
fdObjectInfo;

@wire(getPicklistValues, {recordTypeId:'$fdObjectInfo.data.defaultRecordTypeId', fieldApiName:TYPE_FIELD})
wiredTypeField({data, error}){
    if(data){
        let options = []
        data.values.forEach(element => {
            options.push({label: element.label, value:element.value});
                      
        });
        this.applTypeOptions = options;
    } else if(error) {
        console.log('Deposite Type bilgisi sorgulanırken hata alındı');
    }
}
applTypeChange(event){
    this.selectedApplType=event.detail.value

}
addApplicantClick(){
    //Validate inputs
    let isValid = true
    let inputFields = this.template.querySelectorAll('.validateCombobox');
    inputFields.forEach(inputFields => {
        if(!inputFields.checkValidity()){
            inputFields.reportValidity()
            isValid = false
        }

    })
    if(isValid){
        this.showAddApplicant=true
    }
    
}

}