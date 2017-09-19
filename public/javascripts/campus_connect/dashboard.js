var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {
    
	var cardsTemplate,locationFilterTemplate;

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
        // var source = $("#location-filter-template").html();
        // locationFilterTemplate = Handlebars.compile(source);

    }

    var cards = function(){
        $.ajax({url:"/dashboard/get_companies",
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            }
        });
    }

    var getFilterList = function(options){
        console.log(options);
        alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
        cities = ["BBangalore", "BBangalore", "BBangalore", "BBangalore", "BBangalore", "CBangalore", "CBangalore", "CBangalore", "DBangalore", "DBangalore", "DBangalore", "EBangalore", "EBangalore", "EBangalore", "EBangalore", "EBangalore", "GBangalore", "GBangalore", "GBangalore", "HBangalore", "HBangalore", "HBangalore", "IBangalore", "IBangalore", "IBangalore", "JBangalore", "JBangalore"];
        city_hash = {};
        temp = [];
        prev = cities[0][0];
        for(var index in cities){
            city = cities[index];
            if(city[0]==prev){
                temp.push(city);
            }else{
                city_hash[prev] = temp;
                temp = [];
                temp.push(city);
                prev = city[0];
            }
        }
        console.log(city_hash);
        // var html = locationFilterTemplate({"alphabets":alphabets,"cities":city_hash});
        // var elementPresent  = $("#location-filter-container")
        // $("#location-filter-container").html(html);        
        
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

    var showCompanyDetails =  function(element_clicked){
        // var  opening_id = $(element_clicked).find('input[class="openings"]').val();
        // window.location.href="dashboard/company_details"    
    }


    return {
        showCompanyDetails:showCompanyDetails,
    	init:init,
    	cards:cards,
        sorted_cards:sorted_cards,
        getFilterList:getFilterList
    }
}();

