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
        console.log(templateId);
        var source   = $('#' + templateId).html();
        return Handlebars.compile(source);
    };

	var copmileTemplate = function(){
        cardsTemplate = compileHandlebarTemplate("cards-template");
        companyDetailsTemplate = compileHandlebarTemplate("company-details-template");
        locationFilterTemplate = compileHandlebarTemplate("location-filter-template");
        citiesAndDepartmentTemplate = compileHandlebarTemplate('cities-department-filter-template');
    };

    var handlebarUpdateDom = function(domId,template,json) {
        var html = template(json);
        console.log(html);
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

    var cards = function(){
        $.ajax({url:"/dashboard/get_companies",
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            }
        });
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
        console.log(sort_option);
        $.ajax({url:"/dashboard/get_companies?sort_option="+sort_option,
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
            }
        });
    };

    var search_openings = function(query){
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

