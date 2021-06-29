public with sharing class AccountController {
    @AuraEnabled(Cacheable=true)
    public static Account[] getDefaultSearch() {
        return [
            SELECT Name
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static Account[] searchAccounts(String search) {
        search = search.toLowerCase().trim();
        if (search == '') {
            return getDefaultSearch();
        }
        search = '%' + search + '%';
        return [
            SELECT Name
            FROM Account
            WHERE Name LIKE :search
            ORDER BY Name
            LIMIT 10
        ];
    }
}
