import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createNewQuote from '@salesforce/apex/QuoteLogic.createNewQuote';

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

    handleSubmitAll() {
        let quoteId = createNewQuote('testing page');
        this.template.querySelectorAll('c-quote-line')
            .forEach(element => {element.parentQuoteId = quoteId;
                element.handleSubmit();});
        console.log('wut the main');
        
    }
}