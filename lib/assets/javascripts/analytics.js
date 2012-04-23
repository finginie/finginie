if (window.location.host.match('finginie.com') || window.location.hostname.match('finginie.com')) {
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-30283253-1']);
  _gaq.push(['_trackPageview']);

  (function() {
      var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
      ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

  //Track facebook like event in google analytics
  (function() {
  try {
    if (FB && FB.Event && FB.Event.subscribe) {
      FB.Event.subscribe('edge.create', function(targetUrl) {
        _gaq.push(['_trackSocial', 'facebook', 'like',
            opt_target, opt_pagePath]);
      });
    }
  } catch(e) {}
  })();

  //Track twitter follow event in google analytics
  function trackTwitter(intent_event) {
    if (intent_event) {
      var opt_pagePath;
      if (intent_event.target && intent_event.target.nodeName == 'IFRAME') {
            opt_target = extractParamFromUri(intent_event.target.src, 'url');
      }
      _gaq.push(['_trackSocial', 'twitter', 'follow', opt_pagePath]);
    }
  }

  //Wrap event bindings - Wait for async js to load
  twttr.ready(function (twttr) {
    //event bindings
    twttr.events.bind('follow', trackTwitter);
  });

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
