import { LightningElement, api } from 'lwc';
import createQuoteLine from '@salesforce/apex/QuoteLogic.createQuoteLine';

export default class QuoteLine extends LightningElement {
    @api quotenum;
    @api parentQuoteId;

    handleDeleteClick() {
        const deleteEvent = new CustomEvent('deletequote',
            {detail: this.quotenum}
        );
        this.dispatchEvent(deleteEvent);
    }

    @api
    handleSubmit() {
        let req = {};
        this.template
            .querySelectorAll('lightning-input')
            .forEach(element => { req[element.getAttribute('data-formfield')] = element.value;});
        console.log(req);
        return createQuoteLine({parentQuoteId: this.parentQuoteId,
            service: req['services'],
            margin: req['margin']});
    }
}