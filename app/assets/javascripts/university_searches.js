
$(document).ready(function() {

/*  $("#search-university-btn").live("click", function(){  	
  	alert("here");
  	return false;
  });
*/
	$(function() {
		<% @universities.each do |u| %>

		<% end %>
		var availableTags = [
			"ActionScript",
			"AppleScript",
			"Asp",
			"BASIC",
			"C",
			"C++",
			"Clojure",
			"COBOL",
			"ColdFusion",
			"Erlang",
			"Fortran",
			"Groovy",
			"Haskell",
			"Java",
			"JavaScript",
			"Lisp",
			"Perl",
			"PHP",
			"Python",
			"Ruby",
			"Scala",
			"Scheme"
		];
		$( "#ui-autocomplete-input" ).autocomplete({
			source: availableTags
		});
	});

/*	$(".ui-autocomplete-input").autocomplete({
		alert("hhh");
		minLength: 3,
		source: "/new.html.erb"
	});
*/
});
