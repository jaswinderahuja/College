var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {
    
	var cardsTemplate,locationFilterTemplate;
    var companyDetailsTemplate;
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
        var source   = $("#company-details-template").html();
        companyDetailsTemplate = Handlebars.compile(source);
    }

    var cards = function(){
        $.ajax({url:"/dashboard/get_companies",
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            }
        });
    }

    var SendRequest = function(){
        $.ajax({
                    type: 'POST',
                    url: 'create_interest',
                    data: $("#InterestSendForm").serialize(),
                    success: function(response){
                        console.log(response);
                        $("#SendRequestbtn").removeClass("green").addClass("default disabled").html("Interest Sent");
                    },
                    error: function(xhr,status,error){
                            console.log("error");                          
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

    var showCompanyDetails =  function(opening_id){
           $.ajax({url:"/dashboard/company_info?op_id="+opening_id,
                success: function(response){
                    console.log(response);
                    var html = companyDetailsTemplate(response);
                    $("#company_detail_container").html(html);
                }
            });         
        
    }


    return {
        showCompanyDetails:showCompanyDetails,
    	init:init,
    	cards:cards,
        sorted_cards:sorted_cards,
        getFilterList:getFilterList,
        SendRequest:SendRequest
    }
}();

