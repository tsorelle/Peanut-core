# Content Versioning

Early versions of the htmlEditContainer observable do not suppor saving and versioning of the editor content.  
This has since been added. To implement on an older project do the following:

## Install or upate the peanut-content package

1. Create database tables:
- pnut_content_authors
- pnut_content
- pnut_content_versions
2. Upload new source files:
- If the peanut-content package is not already installed, upload all files from pnut\packages\peanut-content
- If already installed you may update the following files:
    - pnut\packages\peanut-content\templates\contentController.html
    - pnut\packages\peanut-content\src\services\*Command.php
    - pnut\packages\peanut-content\src\db\ContentManager.php
    - pnut\packages\peanut-content\src\db\model\**
2. Update the htmlEditContainer observable:
- pnut\js\htmlEditContainer.*

## Use the following steps to add versioning to an existing viewmodel
1. In the component registration statement (init method) include the 'content-controller' component and on load 
call the initialization methods as needed:
```typescript
 me.application.registerComponents([
    '@pkg/peanut-content/content-controller'], () => {

    me.htmlEditor = new Peanut.htmlEditContainer(me);
    me.htmlEditor.enableUnsavedWarning()
    me.htmlEditor.includeDesignTools();
    me.htmlEditor.includeFileControls();
```
2. In the HTML for the form that uses the editor add a tag for the 'content-controller' component, just before the
end of the '*-view-container' div.
```html
<content-controller params="owner:self,editor:htmlEditor,context:'newsletter'"></content-controller>
```
Parameters:
- owner: the viewmodel that contains the editor. Always use 'self'.
- editor: the htmlEditor object as declared in the viewmodel.
- context: an identifier used associate the content with a particular form or view model.
