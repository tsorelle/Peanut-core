# Content Management Components and Implementation

## htmlEditContainer
This component provides a container for HTML editing functionality, allowing users to edit and manage HTML content within the application.

It can be used by itself or, of saving and loding content is required, it can be used in conjunction with the `contentController` component.

## contentController
This component provides a plugin functionality for the `htmlEditContainer` component, or any component 
that implements the ` Peanut.IContentEditor` interface.

A viewmodel that uses this component must load and initialize both components. After that no other changes are required 
except those specific to the viewmodel. Here is a mimimal example:
````typescript
        init(successFunction?: () => void) {
            let me = this;
            me.application.loadResources([
                '@pnut/htmlEditContainer'
            ], () => {
                me.application.registerComponents(['@pkg/peanut-content/content-controller'], () => {
                    me.htmlEditor =  new Peanut.htmlEditContainer(me);
                    me.htmlEditor.includeFileControls();
                    me.htmlEditor.initialize('test-editor', () => {
                        me.bindDefaultSection();
                        successFunction();
                    })
                })
            });
        }		
````

## Views
The main view file must include the `content-controller` tag and a textarea for the editor.

# Example component tag:
The owner paramater is used to pass the viewmodel reference to the `content-controller` component.  In this case 
it supplies service methods and modal dialogs.

The editor paramater is used to pass the `htmlEditContainer` instance to the `content-controller` component.

The context parameter is used by the content management system to categorize the content.

````html
<content-controller params="owner:self,editor:htmlEditor,context:'editor-test'"></content-controller>
````
# Example markup for editor

The view must contain a textarea for the editor with an id matching the one passed in the htmlEditor.initialize() call 
in the viewmodel init() method.

````html
<textarea id="test-editor"></textarea>
````

# Installation
If the package is not yet installed, deploy the following files to the pnut folder:
- packages\peanut-content\*
- pnut\js\htmlEditContainer.* (compare with existing file for differences)
- pnut\core\Peanut.d.ts

On the target view model *.ts file, modify the init() method to register the content-controller component,
per the example above.

On the target view file *.html, include the content-controller tag, per the example above.

