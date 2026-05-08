Yes. In **TinyMCE 4**, you can use the editor’s dirty state:``` typescript
const editor = tinymce.get('my-editor-id');

if (editor && editor.isDirty()) {
// content has changed since the last clean state
}
```

Typical usage:``` typescript
const editor = tinymce.get('my-editor-id');

if (editor?.isDirty()) {
    console.log('Content has changed');
}
```

After you save the content, reset the dirty state with:``` typescript
editor.setDirty(false);
```

Example:``` typescript
const editor = tinymce.get('my-editor-id');

if (editor && editor.isDirty()) {
    const content = editor.getContent();

    // save content...

    editor.setDirty(false);
}
```

You can also listen for changes:``` typescript
tinymce.init({
selector: '#my-editor-id',
setup: function (editor) {
editor.on('change keyup undo redo', function () {
if (editor.isDirty()) {
console.log('Editor content changed');
}
});
}
});
```

So the short answer is:``` typescript
tinymce.get('my-editor-id').isDirty()
```

And after saving:``` typescript
tinymce.get('my-editor-id').setDirty(false)
```
