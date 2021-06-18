import { LightningElement, api } from 'lwc';

export default class QuoteLine extends LightningElement {
    @api quotenum;

    handleDeleteClick() {
        const deleteEvent = new CustomEvent('deletequote',
            {detail: this.quotenum}
        );
        this.dispatchEvent(deleteEvent);
    }
}