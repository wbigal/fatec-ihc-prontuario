
//Function for Style Selection Dropdown
$(document).ready(function(){

	function style() {
		if ($("#style").is(":hidden"))
		{	
			$("#selection").css({"background":"url(images/off.png) top right no-repeat"});	
			$("#style").slideDown("slow");
			
		}
		else{
			$("#selection").css({"background":"url(images/on.png) top right no-repeat", "top": "0px"});
			$("#style").slideUp("slow");
		}
	}
	 
	//run contact form when any contact link is clicked
	$(".style").click(function(){style()});
	
	});