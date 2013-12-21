$(function(){
  var splash_header = {};
  $.extend(splash_header, {
    init: function() {
      this.initNavbar();
      this.initSearchBar();
      this.initToggleSearchBar();
      this.initToggleNavbar();
      this.initTooltips();
    },
    initTooltips: function() {
      $('[data-toggle="tooltip"]').tooltip();
    },
    initNavbar: function() {
      this.navbar_container = $('#tab-nav-container');
    },
    initSearchBar: function() {
      this.search_bar_container = $('#search-bar-container');
    },
    initToggleNavbar: function() {
      var _self = this;
      $('#toggle-navbar').click(function(e){
        e.preventDefault();
        _self.toggleNavbar();
      });
    },
    initToggleSearchBar: function() {
      var _self = this;
      $('#toggle-search-bar').click(function(e){
        e.preventDefault();
        _self.toggleSearchBar();
      });
    },
    toggleNavbar: function() {
      this.search_bar_container.slideUp(250);
      this.navbar_container.slideDown(250);
    },
    toggleSearchBar: function() {
      this.search_bar_container.slideDown(250);
      this.search_bar_container.find('input#query').focus();
      this.navbar_container.slideUp(250);    
    }
  });
  splash_header.init();
  
});
