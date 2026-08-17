/* example references:
    From this package:
    <reference path='mailings.d.ts'/>

    From external package:
    <reference path='../../peanut-mailings/js/mailings.d.ts'>
 */
namespace PeanutMailings {
    interface IGetSubscriptionsResponse {
        personId: any;
        pageHeading: string;
        emailLists: Peanut.ILookupItem[];
        emailSubscriptions: ISubscriptionListItem[];
        translations: string[];
        redirect: string;
    }

    interface IUpdateSubscriptionsRequest {
        emailSubscriptions: any[];
        personId: any;
    }

    export interface ISubscriptionListItem extends Peanut.ILookupItem  {
        subscribed: boolean;
    }

}
