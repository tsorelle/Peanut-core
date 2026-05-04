/**
 * Created by Terry on 2026-05-01.
 *
 * @see documentation
 * Tag examples:
 * With required parameters only:
 *   <content-controller params="owner:self,contentObserver:saveContent,onFetchSuccess: onNewContent"</content-controller>
 *
 *  With all parameters including overrides:
 *      <content-controller params="owner:self,contentObserver:saveContent,onFetchSuccess: onNewContent,
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
    import IContentEditor = Peanut.IContentEditor;



    export class contentControllerComponent implements Peanut.IEditController {  // IServiceClient not needed?
        private application: IPeanutClient;
        private services: ServiceBroker;
        private owner : () => ViewModelBase;
        public saveModalId : KnockoutObservable<string>;
        public fetchModalId : KnockoutObservable<string>;
        private editor : Peanut.IContentEditor;

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

            if (params.editor) {
                this.editor = <IContentEditor>params.editor;
                this.editor.setEditController(this);
            }
            else {
                console.error('contentControllerComponent: editor parameter required');
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
                content : me.editor.getContent()
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
                if (trace) {
                    console.error("Service call failed. Debug for error details. ");
                }
            });



        }
        doFetch = () => {
            let me = this;
            // todo: service calls to fetch content

            me.owner().hideModal(me.fetchModalId());

            // test
            let content = 'Fetch content from server test.';
            me.editor.setContent(content);
        }

        newDocument(): void {
            let me = this;
            // todo: clear form fields?
            me.contentForm.contentId(0);
        }

        openDocument(): void {
            let me = this;
            me.owner().showModal(me.fetchModalId());
        }

        saveDocument(): void {
            let me = this;
            me.owner().showModal(me.saveModalId())
        }
    }
}