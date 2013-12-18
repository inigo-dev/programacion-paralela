$(function(){
  var tag_input = $('#tag-input');
  
  tag_input.tagsManager({
    hiddenTagListName: 'post[tag_values]',
    prefilled: gon.post.tag_values,
    tagsContainer: $('#tags-container')
  }); 
  
  tag_input.typeahead({
    name: 'tags',
    prefetch: '/tags.json',
    limit: 15
  }).on('typeahead:selected', function (e, d) { 
    tag_input.tagsManager("pushTag", d.value); 
  });
     
  var preview = $('#preview');
  var post_content = $('#post_content');
  
  post_content.keyup(function(e){
    preview.html(markdown.toHTML( $(this).val() ));
  }).keyup();
  
  post_content.keydown(function(e){
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
  
  var preview_post_title = $('#preview-post-title');
  $('#post_title').keyup(function(e){
    var input = $(this).val();
    if(input != "") {
      preview_post_title.text(input);
    }
    else {
      preview_post_title.text("Sin titulo");    
    }    
  }).keyup();
  
  $('.nested-fields textarea').each(function(index, element){
    CodeMirror.fromTextArea(element, {
      mode: "ruby",
      lineNumbers: true,
      theme: 'ambiance'
    });
  });
  
  $('#code-tabs').on("cocoon:after-insert", function(e, insertedItem){
    var textarea = $(insertedItem).find('textarea')[0];
    CodeMirror.fromTextArea(textarea, {
      mode: "ruby",
      lineNumbers: true,
      theme: 'ambiance'
    });
  });

});
