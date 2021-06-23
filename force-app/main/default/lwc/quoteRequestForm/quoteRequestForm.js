import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createNewQuote from '@salesforce/apex/QuoteLogic.createNewQuote';

export default class QuoteRequestForm extends NavigationMixin(LightningElement) {
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

    async handleSubmitAll() {
        console.log('submission started');
        let quoteId = await createNewQuote({quoteName:'testing page'});
        console.log(quoteId);
        let submissions = [];
        this.template.querySelectorAll('c-quote-line')
            .forEach(element => {
                element.parentQuoteId = quoteId;
                submissions.push(element.handleSubmit());
            });
        await Promise.all(submissions);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: quoteId,
                objectApiName: 'Proto_A_Quote__c',
                actionName: 'view'
            }
        });
    }
}