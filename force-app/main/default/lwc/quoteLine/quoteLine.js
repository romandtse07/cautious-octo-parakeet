import { LightningElement, api } from 'lwc';

export default class QuoteLine extends LightningElement {
    @api quotenum;

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
            .forEach(element => { req[element.getAttribute('data-formfield')] = element.value});
        console.log(req);
    }
}