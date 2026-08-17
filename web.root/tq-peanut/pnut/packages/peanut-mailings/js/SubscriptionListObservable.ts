/// <reference path='../../../../typings/knockout/knockout.d.ts' />
/// <reference path='../../../../pnut/core/Peanut.d.ts' />
/// <reference path='mailings.d.ts'/>
namespace PeanutMailings {
    export class SubscriptionListObservable {
        public emailSubscriptionList : KnockoutObservableArray<PeanutMailings.ISubscriptionListItem> = ko.observableArray([]);
        public emailSubscriptionsView : KnockoutObservableArray<PeanutMailings.ISubscriptionListItem> = ko.observableArray([]);
        public postalSubscriptionList: KnockoutObservableArray<ISubscriptionListItem> = ko.observableArray([]);
        public postalSubscriptionsView: KnockoutObservableArray<ISubscriptionListItem> = ko.observableArray([]);


        public assign(response : IGetSubscriptionsResponse) {
            let me = this;
            me.createSubscriptionList(me.emailSubscriptionList, response.emailLists);
            me.assignSubscriptions(me.emailSubscriptionList,me.emailSubscriptionsView, response.emailSubscriptions);
            // todo: postal list support?
            /* me.createSubscriptionList(me.postalSubscriptionList,response.postalLists);
            if (response.addressId) {
                me.assignSubscriptions(me.postalSubscriptionList, me.postalSubscriptionsView, response.postalSubscriptions);
            }
            */
        }

        createSubscriptionList = (list: KnockoutObservableArray<PeanutMailings.ISubscriptionListItem>,items: Peanut.ILookupItem[]) => {
            items.sort((a: Peanut.ILookupItem, b: Peanut.ILookupItem) => {
                if (a.name === b.name) {
                    return 0;
                }
                else if (a.name > b.name) {
                    return 1;
                }
                else {
                    return -1;
                }
            });
            // _.each(items,
            items.forEach(
                (item) => {
                    list.push(
                        <PeanutMailings.ISubscriptionListItem>{
                            code : item.code,
                            id: item.id,
                            name: item.name,
                            description: item.description,
                            subscribed: false
                        });
                });
        };

        assignSubscriptions = (
            checkList: KnockoutObservableArray<PeanutMailings.ISubscriptionListItem>,
            viewList: KnockoutObservableArray<PeanutMailings.ISubscriptionListItem>,subscriptions) => {

            let me = this;
            let check = checkList();
            checkList([]);
            viewList([]);
            let view = [];
            let newList = [];
            // _.each(check,
            check.forEach(
                (item: PeanutMailings.ISubscriptionListItem) => {
                    item.subscribed = (subscriptions.indexOf(item.id) > -1);
                    if (item.subscribed) {
                        view.push(item);
                    }
                    newList.push(item);
                });
            checkList(newList);
            viewList(view);
        };

        public getSelectedEmailSubscriptions = () =>  {
            return this.getSelectedSubscriptions(this.emailSubscriptionList,this.emailSubscriptionsView);
        };

        public getSelectedPostalSubscriptions = () =>  {
            return this.getSelectedSubscriptions(this.postalSubscriptionList,this.postalSubscriptionsView);
        };

        public getSelectedSubscriptions = (checkList: KnockoutObservableArray<PeanutMailings.ISubscriptionListItem>,
                                           viewList: KnockoutObservableArray<PeanutMailings.ISubscriptionListItem>) => {
            let selected = [];
            let subscriptions = checkList();
            let temp =
                // _.filter(subscriptions,
                subscriptions.filter(
                    (item: PeanutMailings.ISubscriptionListItem) => {
                        if (item.subscribed) {
                            selected.push(item.id);
                            return true;
                        }
                    });
            viewList(temp);
            return selected;
        };
    }
}
