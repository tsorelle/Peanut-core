[Return to docs home page](../index.md)
# Content Management Components and Implementation

## htmlEditContainer
This component provides a container for HTML editing functionality, allowing users to edit and manage HTML content within the application.

It can be used by itself or, of saving and loding content is required, it can be used in conjunction with the `contentController` component.

## contentController
This component provides a plugin functionality for the `htmlEditContainer` component, or any component 
that implements the ` Peanut.IContentEditor` interface.

A viewmodel that uses this component must load and initialize both components. After that no other changes are required 
except those specific to the viewmodel. See the initialization example below.

## The View
The main view file must include the `content-controller` tag and a textarea for the editor.

### Editor text area

The view must contain a textarea for the editor with an id matching the one passed in the htmlEditor.initialize() call
in the viewmodel init() method.

````html
<textarea rows="10"  class="form-control" id="messagehtml"></textarea>
````

### Component tag:
In the HTML for the form that uses the editor add a tag for the 'content-controller' component, just before the
end of the '*-view-container' div.
```html
<content-controller params="owner:self,editor:htmlEditor,context:'newsletter'"></content-controller>
```
Parameters:
- owner: the viewmodel that contains the editor. Always use 'self'.
- editor: the htmlEditor object as declared in the viewmodel.
- context: an identifier used associate the content with a particular form or view model.

````html
<content-controller params="owner:self,editor:htmlEditor,context:'editor-test'"></content-controller>
````
## The ViewModel
### Initialization
1. Add required reference paths:
```typescript
/// <reference path='../../pnut/core/Peanut.d.ts' />
/// <reference path='../../pnut/js/ViewModelHelpers.ts' />
/// <reference path='../../typings/tinymce/tinymce.d.ts' />
```
2. In the view model init() method.
- First use loadResources() to load the htmlEditContainer observeable. This script will load required libraries
  such as tinymce and viewModel helpers.
- In the following block use registerComponents() to register the 'content-controller' component.
- In the block that follows that, instantiate and initialize the editor.
- Call me.htmlEditor.initialize() method and in the block that follows execute other initialization code
  and finally bindDefaultSection() and success().

```typescript
// load dependencies
me.application.loadResources([
  '@pnut/htmlEditContainer'
], () => {
    // register components
    me.application.registerComponents([
    '@pkg/peanut-content/content-controller'], () => {
        // initialize editor
        me.htmlEditor = new Peanut.htmlEditContainer(me);
        me.htmlEditor.enableUnsavedWarning()
        me.htmlEditor.includeDesignTools();
        me.htmlEditor.includeFileControls();
        me.htmlEditor.initialize('messagehtml',() => {
            // finish the ViewModel initialization
        });
    });
});    
```

# Installation
If the package is not yet installed, deploy the following files to the pnut folder:
- packages\peanut-content\*
- pnut\js\htmlEditContainer.* (compare with existing file for differences)
- pnut\core\Peanut.d.ts

On the target view model *.ts file, modify the init() method to register the content-controller component,
per the example above.

On the target view file *.html, include the content-controller tag, per the example above.

