$(function(){
  var preview_container = $('#comment-preview-container');
  var comment_input = $('#comment_text');
  comment_input.keyup(function(e){
    var input = $(this).val();
    if(input != "") {
      preview_container.html(markdown.toHTML(input));    
    }
    else {
      preview_container.html("<p>No hay nada que ver aqu&iacute;, escribe algo</p>");    
    }
    
  }).keyup();
  
  comment_input.keydown(function(e){
    var keyCode = e.keyCode || e.which;

    if (keyCode == 9) {
      e.preventDefault();
      var start = $(this).get(0).selectionStart;
      var end = $(this).get(0).selectionEnd;
      
      $(this).val($(this).val().substring(0, start)
                  + " " + " " 
                  + $(this).val().substring(end));
      
      $(this).get(0).selectionStart = $(this).get(0).selectionEnd = start + 2;
    }  
  });
  
  $('textarea.code-mirror').each(function(index, textarea){
    CodeMirror.fromTextArea(textarea, {
      mode: "ruby",
      readOnly: true,
      lineNumbers: true,
      theme: 'ambiance'
    });
  });
  var tabs =  $('.code-tab.active');
  tabs.removeClass('active');
  tabs.eq(0).addClass('active');
  $('ul.nav-tabs li:first-child').addClass('active');
});
