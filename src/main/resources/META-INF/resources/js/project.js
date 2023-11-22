
$(document).ready(function() {

  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

  // activate empty search on start page
  $("#project-searchMainPage").submit(function (evt) {
    $(this).find(":input").filter(function () {
          return !this.value;
      }).attr("disabled", true);
    return true;
  });

  // open search bar
  $( ".js-search-toggler" ).click(function() {
    $( ".searchfield_box" ).addClass('open');
    $( this ).addClass('closed');
    $( "#searchbar" ).focus();
  });
  // close searchbar
  // listen to all clicks
  $(document).click(function(event) {
    var $click = $(event.target);
    // search bar is visible AND
    // clicked element is not inside of the search bar AND
    // clicked element is not the toggle itself
    if( $('.searchfield_box').hasClass("open") &&
        !$click.closest('.js-searchbar').length &&
        !$click.closest('.js-search-toggler').length ||
        $click.closest('.js-search-close').length) {
      $( ".searchfield_box" ).removeClass('open');
      $( ".search-button" ).removeClass('closed');
    }
  });

  // replace placeholder USERNAME with username
  var userID = $("#currentUser strong").html();
  var newHref = 'https://reposis-test.gbv.de/PROJECT/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://reposis-test.gbv.de/PROJECT/servlets/solr/select?q=createdby:USERNAME']").attr('href', newHref);

});

$( document ).ajaxComplete(function() {
  // remove series and journal as option from publish/index.xml
  $("select#genre option[value='series']").remove();
  $("select#genre option[value='journal']").remove();
});

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  var breakPoint = 163;
  if (document.body.scrollTop > breakPoint || document.documentElement.scrollTop > breakPoint) {
    //small
    $("body > header").addClass("small-header");
    console.log("klein");
  } else {
    //big
    $("body > header").removeClass("small-header");
    console.log("gross");
  }
}