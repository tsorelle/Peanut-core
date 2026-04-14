# jQuery Coversions and Fixes
## Examples:
### Show an Element
Example from: web.root/nutshell/pnut/core/ViewModelBase.ts
````typescript
// replaces jQuery('#id').show()
public showElement(id: string, style = 'block') {
    // style could be 'flex', need to know in advance/
    let element = document.getElementById(id);
    if (element) {
        element.style.display = style;
    }
}
````

### Create DIV element and assign content
Example from: web.root/nutshell/pnut/core/WaitMessage.ts
````typescript
    // WaitMessage.waitDialog = jQuery(WaitMessage.templates[waiterType]);
    WaitMessage.waitDialog = document.createElement('div');
    WaitMessage.waitDialog.innerHTML = WaitMessage.templates[waiterType];
````

### Assign text to span by id
Example from: web.root/nutshell/pnut/extensions/BootstrapFive/classes/BootstrapFiveUiHelper.ts<br>
Container is an HTMLDivElement created as demonstrated in the previous example.
````typescript
    // let span = container.find('#' + id);
    // span.text(message);
    let span = container.querySelector('#' + id);
    span.textContent = message;
````
### Data conversion
checkNumeric method in Peanut.Helper replace jQuery checkNumeric.<br>
See: web.root/nutshell/pnut/js/ViewModelHelpers.ts

````typescript
    // if (!jQuery.isNumeric(parts[0])) {
    if (!Helper.checkNumeric(parts[0])) {
````
In Peanut.Helper:
````typescript
    public static checkNumeric(value: any) : boolean {
        return (!isNaN(parseFloat(value)) && isFinite(value));
    }
````
### Modals
Calls to jQuery('id').modal('show|hide') may be replaced with Peanut.ui.helper.showModal and  
Peanut.ui.helper.hideModal. The uiHelper is always available to viewmodels, But components may
need to include the following in the  constructor. 

````typescript
PeanutLoader.loadUiHelper(() => {
    /...
});
````
See: web.root/nutshell/pnut/components/lookupEditComponent.ts and<br>
or web.root/nutshell/pnut/components/cleanHtmlComponent.ts

````typescript
    // jQuery("#html-cleanup-modal").modal('show');
    Peanut.ui.helper.showModal("#html-cleanup-modal")

    // jQuery("#html-cleanup-modal").modal('hide');
    Peanut.ui.helper.hideModal("#html-cleanup-modal")

    // modal routines in ui helper strip '#' from identifier so this is equivalent
    Peanut.ui.helper.showModal("html-cleanup-modal")
    Peanut.ui.helper.hideModal("html-cleanup-modal")
````

See more example modal handling in web.root/application/peanut/tests/vm/ModalTestViewModel.ts
