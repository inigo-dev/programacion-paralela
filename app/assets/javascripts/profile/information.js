$(function(){
  var profile_information = {};
  $.extend(profile_information, {
    toggle_form_btn: null,
    toggle_vcard_btn: null,
    init: function() {
      this.initVcard();
      this.initFormContainer();
      this.initToggleForm();
      this.initToggleVcard();
    },
    initVcard: function() {
      this.vcard_container = $('#vcard');
    },
    initFormContainer: function() {
      this.form_container = $('#information-form-container');
    },
    initToggleForm: function() {
      var _self = this;
      this.toggle_form_btn = $('#toggle-form').click(function(e){
        e.preventDefault();
        _self.toggleForm();
      });
    },
    initToggleVcard: function() {
      var _self = this;
      this.toggle_vcard_btn = $('#toggle-vcard').click(function(e){
        e.preventDefault();
        _self.toggleVcard();
      });
    },
    toggleForm: function() {
      this.form_container.removeClass('hidden');
      this.vcard_container.addClass('hidden');
    },
    toggleVcard: function() {
      this.form_container.addClass('hidden');
      this.vcard_container.removeClass('hidden');
    }
  });
  profile_information.init();
  

});
