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
    import IEditorHost = Peanut.IEditorHost;



    export class contentControllerComponent implements IServiceClient {
        private application: IPeanutClient;
        private services: ServiceBroker;
        private owner : () => ViewModelBase;
        private editForm: IEditorHost;
        public onFetchSuccess : (content: string)=> void;
        public saveModalId : KnockoutObservable<string>;
        public fetchModalId : KnockoutObservable<string>;
        public saveObserver : KnockoutObservable<string>;
        public saveWatcher : any;

        private contentForm = {
            contentId : ko.observable(0),
            title : ko.observable(''),
            shared : ko.observable(false),
            context : ko.observable(''),
            titleError : ko.observable(false),
            prevId: 0,
            prevTitle: ''
        }

        constructor(params : any) {
            console.log('contentControllerComponent initializing.');
            let me = this;
            if (!params) {
                throw('Params not defined in modalConfirmComponent');
            }
            if (params.context) {
                this.contentForm.context(params.context);
            }
            else {
                console.error('contentControllerComponent: context parameter required');
                return;
            }
            if (!params.owner) {
                console.error('contentControllerComponent: Owner parameter required');
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
            me.editForm = (<IEditorHost>ownerVm);
            me.application = ownerVm.getApplication();
            me.services = ownerVm.getServices();
            me.saveWatcher = me.saveObserver.subscribe(me.onContentChanged);
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

            // test
             me.contentForm.contentId(1);
            // let content = me.editForm.getContent().trim();
            if (me.saveObserver() == 'new document') {
                me.contentForm.contentId(0);
                return;
            }
            /* not needed?
            me.saveWatcher.dispose();
            me.saveObserver('reset')
            me.saveWatcher = me.saveObserver.subscribe(me.onContentChanged);
             */
            me.owner().showModal(me.saveModalId())
            // alert('component says that content changed');

        }

        clearDocument = () => {
            let me = this
            me.contentForm.prevId = me.contentForm.contentId();
            me.contentForm.prevTitle = me.contentForm.title();
            me.contentForm.contentId(0);
            me.contentForm.title('');
        }

        cancelSave = () => {
            let me = this
            me.contentForm.contentId(me.contentForm.prevId);
            me.contentForm.title(me.contentForm.prevTitle);
            me.owner().hideModal(me.saveModalId());
        }

        doSave = () => {
            let me = this;
            let request = {
                contentId : me.contentForm.contentId(),
                title : me.contentForm.title().trim(),
                shared : me.contentForm.shared(),
                context : me.contentForm.context(),
                content : me.editForm.getContent()
            }
            if (request.title.length === 0) {
                me.contentForm.titleError(true);
                return;
            }
            me.contentForm.titleError(false);
            me.owner().hideModal(me.saveModalId());
            let serviceMethod = request.contentId ? 'SaveContent' : 'CreateTitle';
            me.services.executeService('peanut.content::'+serviceMethod,request,
                function(serviceResponse: Peanut.IServiceResponse) {
                    if (serviceResponse.Result == Peanut.serviceResultSuccess) {
                        let result = serviceResponse.Value;
                        me.contentForm.contentId(result.contentId);
                    }
                    else {
                        // alert('content not saved');
                    }
                }
            ).fail(function () {
                let trace = me.services.getErrorInformation();
            });



        }
        doFetch = () => {
            let me = this;
            // todo: service calls to fetch content

            me.owner().hideModal(me.fetchModalId());

            // test
            let content = 'Fetch content from server test.';
            me.editForm.setContent(content);
        }
    }
}