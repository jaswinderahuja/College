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
                $("#cards-container").html(html);
            }
        });
    }

    var sorted_cards =function(sort_option){
        console.log(sort_option);
        $.ajax({url:"/dashboard/get_companies?sort_option="+sort_option,
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            }
        });
    }

    var init =function(){
        copmileTemplate();        
    }


    return {
    	init:init,
    	cards:cards,
        sorted_cards:sorted_cards    
    }
}();

