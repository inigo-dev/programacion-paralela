$(function(){
  var posts_index = {};
  $.extend(posts_index, {
    submit_buttons: null,
    checked_count: 0,
    init: function() {
      this.initForm();
      this.initSubmitButtons();
      this.initCheckBoxes();
    },
    initForm: function() {
      this.form = $('#posts-form');
    },  
    initCheckBoxes: function() {
      var _self = this;
      $('input.post-check-box').change(function(){
        if($(this).is(':checked')) {
          ++_self.checked_count;
          _self.enableSubmit();
        }
        else {
          --_self.checked_count;
          _self.disableSubmit();
        }
      });
    },
    enableSubmit: function() {
      this.submit_buttons.removeClass('disabled');
    },
    disableSubmit: function() {
      if(this.checked_count <= 0) {
        this.submit_buttons.addClass('disabled');
      }
    },
    initSubmitButtons: function() {
      var _self = this;
      this.submit_buttons = $('input.mass-action').click(function(e){
        e.preventDefault();
        _self.form.attr('action', $(this).data('url'));
        _self.form.submit();
      });
    }
  });
  posts_index.init();
});
