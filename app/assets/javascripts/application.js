// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery.raty
//= require jquery.jpostal
//= require turbolinks
//= require jquery_ujs
//= require_tree .
//= require_self

//top_page
$(function() {
    $(document).on("ajax:success", ".fav", function(e) {
      if ($('#' + e.detail[0]).hasClass('far fa-thumbs-up')) {
        $('#' + e.detail[0]).removeClass('far fa-thumbs-up').addClass('fa-thumbs-up');
      } else {
    $('#' + e.detail[0]).removeClass('fa-thumbs-up').addClass('far fa-thumbs-up');
      }
    })
  })



//sidebar
$(document).on('turbolinks:load', function(){
  $('#MenuIcon').click(function(){
    $('#MainMenu').css("left","0px");
    function showMenu(){
      $('#MainMenu').css("-webkit-clip-path","polygon(0 0,100% 0,100% 100%,0% 100%)");
      $("#MenuIcon").animate({right:'-100'},300);
    }
    setTimeout(showMenu,100);
  });

  $("#close").click(function(){
    $("#MainMenu").css("-webkit-clip-path","polygon(0 0,0% 0,100% 100%,0% 100%)");
    function hideMenu(){
      $('#MainMenu').css("left","-300px");
      $("#MenuIcon").animate({right:'50'},300);
    }
    setTimeout(hideMenu,300);

    function originalLayout(){
      $("#MainMenu").css("-webkit-clip-path","polygon(0 0,100% 0,0% 100%,0% 100%)");
    }
    setTimeout(originalLayout,600);
  });
});

//shop_destroy
(function() {
  $(function() {
    $(document).on('ajax:complete', '.shop_delete', function(event, ajax, status) {
      $('#shop_'+ shop.id).fadeOut();
    });
  });
}).call(this);

// calendar
$(document).on('turbolinks:load', function(){
  $('.open').on('click', function() {
    var id= $(this).attr("id");
    $('#overlay').fadeIn();
    $('#modalWindow' + id ).fadeIn();
  });
  
  $('.close').on('click', function() {
    var se= $(this).attr("id");
    $('#overlay').fadeOut();
    $('#modalWindow' + se ).fadeOut();
  });
  
});

$(document).on('turbolinks:load', function(){
  $('.open_new').on('click', function() {
    var id= $(this).attr("id");
    $('#overlay').fadeIn();
    $('#new' + id ).fadeIn();
  });
  
  $('.close_new').on('click', function() {
    var se= $(this).attr("id");
    $('#overlay').fadeOut();
    $('#new' + se ).fadeOut();
  });
  
});

$(document).on('turbolinks:load', function(){
  $('.open_fill').on('click', function() {
    var id= $(this).attr("id");
    $('#overlay').fadeIn();
    $('#fill' + id ).fadeIn();
  });
  
  $('.close_fill').on('click', function() {
    var se= $(this).attr("id");
    $('#overlay').fadeOut();
    $('#fill' + se ).fadeOut();
  });
  
});


// review
$(document).on('turbolinks:load', function(){
  $('.openreview').on('click', function() {
    $('#overlay').fadeIn();
    $('#modalWindowreview').fadeIn();
  });
  
  $('.closereview').on('click', function() {
    $('#overlay').fadeOut();
    $('#modalWindowreview').fadeOut();
  });
  
});

$(document).on('turbolinks:load', function(){
  $('.open_newreview').on('click', function() {
    $('#overlay').fadeIn();
    $('#modalWindow_newreview').fadeIn();
  });
  
  $('.close_newreview').on('click', function() {
    $('#overlay').fadeOut();
    $('#modalWindow_newreview').fadeOut();
  });
  
});
