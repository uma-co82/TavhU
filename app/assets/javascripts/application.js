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
//= require turbolinks
//= require_tree .
//= require_self

//top_page
$(function() {
    $(document).on("ajax:success", ".fav", function(e) {
      if ($('#' + e.detail[0]).hasClass('fa-heart')) {
        $('#' + e.detail[0]).removeClass('fa-heart').addClass('fa-heart-o');
      } else {
    $('#' + e.detail[0]).removeClass('fa-heart-o').addClass('fa-heart');
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
      $('#shop_'+shop.id).fadeOut();
    });
  });
}).call(this);

//reservation
$(document).on('turbolinks:load', function(){
  $('#open').on('click', function() {
    $('#overlay, #modalWindow').fadeIn();
  });
  
  $('#clo').on('click', function() {
    $('#overlay, #modalWindow').fadeOut();
  });
  
  locateCenter();
  $(window).resize(locateCenter);

  function locateCenter() {
    let w = $(window).width();
    let h = $(window).height();
    
    let cw = $('#modalWindow').outerWidth();
    let ch = $('#modalWindow').outerHeight();
   
    $('#modalWindow').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h - ch) / 2) + 'px'
    });
  }
});

// chat
$(document).on('turbolinks:load', function(){
  $('#chat_open').on('click', function() {
    $('#overlay, #chat').fadeIn();
  });
  
  $('#chat_close').on('click', function() {
    $('#overlay, #chat').fadeOut();
  });
  
  locateCenter();
  $(window).resize(locateCenter);

  function locateCenter() {
    let w = $(window).width();
    let h = $(window).height();
    
    let cw = $('#chat').outerWidth();
    let ch = $('#chat').outerHeight();
   
    $('#chat').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h - ch) / 2) + 'px'
    });
  }
});