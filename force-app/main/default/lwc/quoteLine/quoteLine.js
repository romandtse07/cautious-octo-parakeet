import { LightningElement, api } from 'lwc';

export default class QuoteLine extends LightningElement {
    @api key;

    handleDeleteClick() {
        const deleteEvent = new CustomEvent('deletequote',
            {quoteNum: this.key}
        );
        this.dispatchEvent(deleteEvent);
    }
}