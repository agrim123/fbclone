// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require private_pub
//= require jquery-ui
//= require materialize
//= require select2
//= require chat
// require jquery.remotipart
//= require turbolinks
//= require faye
//= require_tree .
$(document).on('turbolinks:load', function(){
  $('.dropdown-button').dropdown({
    inDuration: 300,
    outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: false, // Activate on hover
      gutter: 0, // Spacing from edge
      belowOrigin: true, // Displays dropdown below the button
      alignment: 'left' // Displays dropdown with edge aligned to the left of button
    }
    );
  $('.modal-trigger').leanModal();
  

  // Show sideNav
  $('.button-collapse').click(function(){
    $(".side-nav").show();
  });
  // Hide sideNav
  $(".load-more").click(function(){
    //$('#infinite-scrolling').html('Loading');
$.getScript($('.pagination .next_page').attr('href'));
  });
/*  if($('#infinite-scrolling').size() > 0){
    $(window).on('scroll',function(){
      console.log($('#infinite-scrolling').size());
      m = $('.pagination .next_page').attr('href');
      if(m && $(window).scrollTop() > $(document).height() - $(window).height() - 60){
        $.getScript($('.pagination .next_page').attr('href'));
      }
    });
  }*/
  /*****
   PROFILE JS
   ******/

   $(".profile_photos,.profile_followers,.profile_following,.profile_about").hide();
   $(".profile_sub_menu button").hover(function(){
    $(this).toggleClass('active');
  });
   $(".profile_sub_menu button").click(function(){
    
    var str = $(this).attr('class');
    if(str.indexOf("posts") != -1){
      $(this).addClass('active');
      $(".profile_posts").show();
      $(".profile_photos").hide();
      $(".profile_followers").hide();
      $(".profile_following").hide();
      $(".profile_about").hide();
    }else if(str.indexOf("photos") != -1){
      $(this).addClass('active');
      $(".profile_posts").hide();
      $(".profile_photos").show();
      $(".profile_followers").hide();
      $(".profile_following").hide();
      $(".profile_about").hide();
    }else if(str.indexOf("followers") != -1){
      $(".profile_posts").hide();
      $(".profile_photos").hide();
      $(".profile_followers").show();
      $(".profile_following").hide();
      $(".profile_about").hide();
    }else if(str.indexOf("following") != -1){
      $(".profile_posts").hide();
      $(".profile_photos").hide();
      $(".profile_followers").hide();
      $(".profile_following").show();
      $(".profile_about").hide();
    }else if(str.indexOf("about") != -1){
      $(".profile_posts").hide();
      $(".profile_photos").hide();
      $(".profile_followers").hide();
      $(".profile_following").hide();
      $(".profile_about").show();
    }else{
      alert();
    }
  });

 });
