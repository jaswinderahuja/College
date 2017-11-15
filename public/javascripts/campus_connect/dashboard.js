var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {

	var cardsTemplate,locationFilterTemplate,companyDetailsTemplate,citiesAndDepartmentTemplate;
    var cities = [{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},,{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false}];
    var departments = [{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false}];
	// var init = function(){
	// 	/* off-canvas sidebar toggle */
	// 	$('[data-toggle=offcanvas]').click(function() {
	// 	    $('.row-offcanvas').toggleClass('active');
	// 	    $('.collapse').toggleClass('in').toggleClass('hidden-xs').toggleClass('visible-xs');
	// 	});
	// }
    //
    var compileHandlebarTemplate = function(templateId) {
        var source   = $('#' + templateId).html();
        return Handlebars.compile(source);
    };

	var copmileTemplate = function(){
        cardsTemplate = compileHandlebarTemplate("cards-template");
        companyDetailsTemplate = compileHandlebarTemplate("company-details-template");
        citiesAndDepartmentTemplate = compileHandlebarTemplate('cities-department-filter-template');
    };

    var handlebarUpdateDom = function(domId,template,json) {
        var html = template(json);
        $('#' + domId).html(html);
    };

    var filterCities = function() {
        handlebarUpdateDom("filter_cities",citiesAndDepartmentTemplate,cities);
    };

    var filterDepartment = function () {
        handlebarUpdateDom("filter_department",citiesAndDepartmentTemplate,departments);
    };

    var generateFilterHandlebar = function (id,data) {
        handlebarUpdateDom(id,citiesAndDepartmentTemplate,data);
    };

    var constructParams = function(){
        var params = ""
        var q = getUrlParameter("q");
        var filter = getUrlParameter("filter");        
        if(q != undefined && q.length>0){
            params = params+"?q="+q;
        }
        if(filter != undefined && filter.length > 0){
            if(params ===""){
                params = params +"?filter="+filter
            }else{
                params = params + "&filter="+filter;
            }
        }        
        return params
    }

    var paramsExists = function() {
        var params = window.location.search.substring(1);
        if(params === "" ){
            return false;
        }
        return true;
    }

    var cards = function(sort_option){
        // var uri = "/dashboard/get_companies"
        // if we want to reset the sorting during refresh then this code is needed but if we want to keep the sorting on search the below code has to remove and read params from url
        // var params = constructParams();
        // if(sort_option !=undefined && sort_option != ""){
        //     if(params === undefined || params === "" ){            
        //         params = params + "?sort_option="+sort_option
        //     }else{
        //         params = params + "&sort_option="+sort_option
        //     }            
        // }
        //  or
        var params = window.location.search.substring(0)
        console.log(params);
        var uri = "/dashboard/search_openings"+params;
        $.ajax({url:uri,
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            },
            error: function(xhr,status,error){
                console.log(error);
            }
        });
    };

    var getUrlParameter = function(sParam) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),
            sURLVariables = sPageURL.split('&'), sParameterName, i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : sParameterName[1];
            }
        }
    };

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
    };

    var sorted_cards =function(sort_option){        
        var params = constructParams();
        if(sort_option !=undefined && sort_option != ""){
            if(params === undefined || params === "" ){            
                params = params + "?sort_option="+sort_option
            }else{
                params = params + "&sort_option="+sort_option
            }            
        }
        window.history.pushState("object or string", "Title", params);
        CampusConnect.Dashboard.cards(sort_option);
    };

    var search_openings = function(query){        
        window.history.pushState("object or string", "Title", "?q="+query);                    
        $.ajax({
            url:"/dashboard/search_openings?q="+query,
            type: "GET",
            async: false,
            success: function (response) {
                console.log(response);
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            },
            error: function(xhr,status,error){
                console.log(error);
            }
        });
    };

    var init =function(){
        copmileTemplate();
        filterCities();
        filterDepartment();
    };

    var showCompanyDetails =  function(opening_id){
           $.ajax({url:"/dashboard/company_info?op_id="+opening_id,
                success: function(response){
                    console.log(response);
                    var html = companyDetailsTemplate(response);
                    $("#company_detail_container").html(html);
                }
            });

    };

    return {
        showCompanyDetails:showCompanyDetails,
    	init:init,
    	cards:cards,
        sorted_cards:sorted_cards,
        SendRequest:SendRequest,
        search_openings:search_openings
    };
}();

