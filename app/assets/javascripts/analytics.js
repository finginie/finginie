if (window.location.host.match('finginie.com') || window.location.hostname.match('finginie.com')) {
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-30283253-1']);
  _gaq.push(['_trackPageview']);

  (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

  $(document).ready(function() {
    var _we = document.createElement('script');
    _we.type = 'text/javascript';
    _we.async = true;
    var _weWidgetJs = "/js/widget/webengage-min-v-2.0.js";
    if(document.location.protocol == 'https:') {
      _we.src="//ssl.widgets.webengage.com" +_weWidgetJs;
    } else {
      _we.src="//cdn.widgets.webengage.com" +_weWidgetJs;
    };
    $('webengage').append(_we);
  });
};
