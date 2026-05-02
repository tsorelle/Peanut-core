/**
 * Created by Terry on 2026-05-01.
 *
 * @see documentation
 * Tag examples:
 * With required parameters only:
 *   <content-controller params="owner:self,saveObserver:saveContent,onFetchSuccess: onNewContent"</content-controller>
 *
 *  With all parameters including overrides:
 *      <content-controller params="owner:self,saveObserver:saveContent,onFetchSuccess: onNewContent,
 *      fetchId:'fetch-content-modal',saveId:'save-content-modal',translator:self"</content-controller>
 *
 */
/// <reference path='../../../../typings/knockout/index.d.ts' />
/// <reference path='../../../../pnut/core/KnockoutHelper.ts' />
///<reference path="../../../../pnut/core/Services.ts"/>
///<reference path="../../../../pnut/core/Peanut.d.ts"/>

namespace PeanutContent {
    import IPeanutClient = Peanut.IPeanutClient;
    import ServiceBroker = Peanut.ServiceBroker;
    import ViewModelBase = Peanut.ViewModelBase;
    import IServiceClient = Peanut.IServiceClient;

    export class contentControllerComponent implements IServiceClient {
        private application: IPeanutClient;
        private services: ServiceBroker;
        private owner : () => ViewModelBase;
        public onFetchSuccess : (content: string)=> void;
        public saveModalId : KnockoutObservable<string>;
        public fetchModalId : KnockoutObservable<string>;
        public saveObserver : KnockoutObservable<string>;

        constructor(params : any) {
            console.log('contentControllerComponent initializing.');
            let me = this;
            if (!params) {
                throw('Params not defined in modalConfirmComponent');
            }
            if (!params.owner) {
                console.error('contentControllerComponent: Owner parameter required');
                return;
            }
            if (params.onFetchSuccess) {
                // todo: check examples
                this.onFetchSuccess = params.onFetchSuccess;
            }
            else {
                console.error('contentControllerComponent: onFetchSuccess parameter required');
                return;
            }
            if (params.saveObserver) {
                // todo : check examples
                this.saveObserver = params.saveObserver;
            }
            else {
                console.error('contentControllerComponent: saveObserver parameter required');
                return;
            }
            if (params.translator) {
                console.log('contentControllerComponent: translations not supported yet');
            }
            let fetchId = params.fetchModalId || 'fetch-content-modal';
            me.fetchModalId = ko.observable(fetchId);

            let saveId  = params.saveModalId || "save-content-modal";
            me.saveModalId = ko.observable(saveId);

            me.owner = params.owner;
            let ownerVm = params.owner();
            me.application = ownerVm.getApplication();
            me.services = ownerVm.getServices();
            me.saveObserver.subscribe(me.onContentChanged);
        }

        showServiceMessages(messages: Peanut.IServiceMessage[]): void {
            // todo: implement
        }
        hideServiceMessages(): void {
            // todo: implement
        }
        showError(errorMessage?: string): void {
            // todo: implement
        }

        onContentChanged = () => {
            let me = this;
            me.owner().showModal(me.saveModalId())
            // alert('component says that content changed');

        }

        doSave = () => {
            let me = this;
            me.owner().hideModal(me.saveModalId());
            // test
            alert('component says: content saved');

            // todo: service calls to save content

        }
        doFetch = () => {
            let me = this;
            // todo: service calls to fetch content

            me.owner().hideModal(me.fetchModalId());

            // test
            me.onFetchSuccess('Fetch content from server test.')
        }
    }
}