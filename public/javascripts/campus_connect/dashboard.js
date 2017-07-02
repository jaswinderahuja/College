var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {
    
	var cardsTemplate;

	// var init = function(){
	// 	/* off-canvas sidebar toggle */
	// 	$('[data-toggle=offcanvas]').click(function() {
	// 	    $('.row-offcanvas').toggleClass('active');
	// 	    $('.collapse').toggleClass('in').toggleClass('hidden-xs').toggleClass('visible-xs');
	// 	});
	// }


	 var copmileTemplate = function(){
        var source   = $("#cards-template").html();
        cardsTemplate = Handlebars.compile(source);
    }

    var cards = function(){
        $.ajax({url:"/dashboard/get_companies",
            success: function(response){
                var html = cardsTemplate(response);
                console.log(html);
                $("#cards-container").html(html);
            }
        });
    }


    var init =function(){
        copmileTemplate();        
    }


    return {
    	init:init,
    	cards:cards    
    }
}();

