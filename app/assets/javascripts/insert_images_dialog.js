$(function(){
  select_image = (function() {
    window.parent.opener.CKEDITOR.tools.callFunction( window.CKEditorFuncNum, 'http://localhost:3000/uploads/upload/upload/96/thumb_6a1bd8ad7ee7fd44f63849371cc07862.jpg', '' );
    //window.parent.opener.CKEDITOR.dialog.getCurrent().hide();
    self.close();
  })
})
