// Register the plugin within the editor.
CKEDITOR.plugins.add( 'upload', {

	// Register the icons.
	icons: 'upload',

	// The plugin initialization logic goes inside this method.
	init: function( editor ) {

    // ACF
    editor.addFeature({allowedContent:"img[alt,height,!src,title,width]",requiredContent:"img"})

		// Create a toolbar button that executes the above command.
		editor.ui.addButton( 'Upload', {

			// The text part of the button (if available) and tooptip.
			label: 'Закачка файлов',

      click: function (editor) { window.open('/uploads?CKEditor=' + editor.name,'Закачка файлов','width=500,height=400'); },

			// The button placement in the toolbar (toolbar group name).
			toolbar: 'insert'
		});

	}
});

