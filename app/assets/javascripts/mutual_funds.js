$(document).ready(function() {
  $(function() {
    return $('#scheme_scheme_name').autocomplete({
      source: $('#scheme_scheme_name').data('autocomplete-source'),
      select: function (event, ui) {
				$(event.target).val(ui.item.label);
				window.location = "/mutual_funds/" + ui.item.value +"/scheme_summary";
				return false;
			}
    });
  });

  var change = parseFloat($(".day_change").text().trim())
  var percentage_change = parseFloat($(".percentage_change").text().trim().slice(1,-2))

  if(change < 0){
    $("body.mutual_funds .day_change").removeClass('green').addClass('red')
  }
  else{
    $("body.mutual_funds .day_change").removeClass('red').addClass('green')
  }

  if(percentage_change < 0){
    $("body.mutual_funds .percentage_change").removeClass('green').addClass('red')
  }
  else{
    $("body.mutual_funds .percentage_change").removeClass('red').addClass('green')
  }

});
