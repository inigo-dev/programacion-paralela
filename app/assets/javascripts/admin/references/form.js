$(function(){
  var tag_input = $('#tag-input');
  
  tag_input.tagsManager({
    hiddenTagListName: 'reference[tag_values]',
    prefilled: gon.reference.tag_values,
    tagsContainer: $('#tags-container')
  }); 
  
  tag_input.typeahead({
    name: 'tags',
    prefetch: '/tags.json',
    limit: 15
  }).on('typeahead:selected', function (e, d) { 
    tag_input.tagsManager("pushTag", d.value); 
  });
});
