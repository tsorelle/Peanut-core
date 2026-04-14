# updates for bootstrap 5

This version of Peanut/Qnut depends on BootStrap ver 5.  Here are some notes about converting from 
Bootstrap 3, which is used in some older versions. 

## Modals

1. update modal-header

    Replace title and close buttons using this pattern:
 
            <button data-bind="visible:bootstrapVersion() < 4" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <!-- TITLE GOES HERE! -->
            <button data-bind="visible:bootstrapVersion() > 3" type="button" class="close btn-close"
                    data-dismiss="modal",
                    data-bs-dismiss="modal"
                    aria-label="Close">
                <span data-bind="visible:bootstrapVersion() < 5" aria-hidden="true">&times;</span>
            </button>

    If only supporting BS-5 or BS-4:

            <TITLE GOES HERE!>
            <button type="button" class="close btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Close">
                <span data-bind="visible:bootstrapVersion() < 5" aria-hidden="true">&times;</span>
            </button>

2. UPDATE close button in footer, add this attribute to link: data-bs-dismiss="modal"

       <a href="#" data-bs-dismiss="modal" data-dismiss="modal">Close</a>

3. For wide modal use modal-lg class:

       <div class="modal-dialog modal-lg" >

See [jQuery Conversions](jqueryconversions.md) for modal display routines replacing jQuery.

## Forms
### Form Classes
Add 'form-select' class to select element:

     <select class="form-select">

Replace 'form-group' with 'form-group mb-3'>

    <div class='form-group mb-3'>

Class form-group is not defined in Bootstrap-5, mb-3 is defined in v.5 but not in previous versions. It added .5 rem to bottom margin.
For list of new generic spacing classes see:
https://getbootstrap.com/docs/5.0/utilities/spacing/
### Checkbox
Version 3:
````html
<div class="checkbox">
   <label >
      <input type="checkbox" > Checkbox label
   </label>
</div>
````
Version 5
````html
<div class="form-check">
  <input class="form-check-input" type="checkbox" value="" id="checkboxfield">
  <label class="form-check-label" for="checkboxfield">
     Checkbox label
  </label>
</div>
````
### Radio Buttons
Same as checkbox except type="radio" on input.
Note seperate div for each button.
```html
<div class="form-check">
  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
  <label class="form-check-label" for="flexRadioDefault1">
    Default radio
  </label>
</div>
<div class="form-check">
  <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
  <label class="form-check-label" for="flexRadioDefault2">
    Default checked radio
  </label>
</div>
````
### Date Picker Popup
#### Initialization
In ViewModel.init()
```typescript
jQuery('.datepopup').datepicker().datepicker("option", "dateFormat",'mm/dd/yy');
```
Markup example:
```html
<label for="endDate" class="form-label">End Date</label>
      <input id="endDate" class="form-control datepopup"
              data-bind="value:sessionForm.endDate, css: {'is-invalid': sessionForm.endDateInvalid}"/>
```
### Popovers

#### Initialization
In ViewModel.Init()
```typescript
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })
```
#### Markup Example
```html
  <a tabindex="0" role="button" data-bs-toggle="popover" data-bs-trigger="focus" title="Contacts Fields"
     data-bs-content="firstname, lastname, fullname, phone1, phone2, homephone, email, dateofbirth, 
        addressname, address1, address2, city, state, postalcode, 
        country, affiliation code, role, primary affiliation">Fields...</a>

```
