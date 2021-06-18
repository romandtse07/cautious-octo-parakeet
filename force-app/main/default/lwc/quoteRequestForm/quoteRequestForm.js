import { LightningElement, track } from 'lwc';


export default class QuoteRequestForm extends LightningElement {
    numQuotes = 1;
    @track quotes = [
        {num: 1}
    ];

    addQuote() {
        this.numQuotes += 1;
        let newQuote = {num: this.numQuotes};
        this.quotes = this.quotes.concat(newQuote);
    }

    deleteQuote(event) {
        if (this.quotes.length > 1) {
            this.quotes = this.quotes.filter(
                quote => quote.num != event.detail
            );
        }
    }
}