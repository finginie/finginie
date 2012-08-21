(function($){
  $.fn.outerHtml = function() {
    return this.clone().wrap('div').parent().html();
  }
})( jQuery );

