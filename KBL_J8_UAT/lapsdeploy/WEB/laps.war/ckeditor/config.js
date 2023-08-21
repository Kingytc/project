/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	
	config.removeButtons = 'Save,Source,NewPage,Preview,Print,Form,Checkbox,Radio,TextField,Textarea,Flash,Iframe,Templates,Select,Button,ImageButton,HiddenField,Undo,Redo,Blockquote,CreateDiv,Language,Link,Unlink,Anchor,Image,HorizontalRule,SpecialChar,PageBreak,ShowBlocks,About';
	config.removePlugins='elementspath';
	config.pasteFromWordRemoveFontStyles=false;
	config.pasteFromWordRemoveStyles=false;
	config.forcePasteAsPlainText = false;
	config.allowedContent = true;
	config.extraAllowedContent = 'p(mso*,Normal)';
	config.pasteFilter = null;
	config.fontSize_defaultLabel = '16px';
	config.font_defaultLabel = 'Antiqua';
	config.font_names = 'Antiqua';
	config.wordcount={showParagraphs:false,
			showWordCount:false,
			showCharCount:false,
			maxWordCount:14,
			maxCharCount:15};
};


