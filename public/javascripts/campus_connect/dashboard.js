var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {

	var cardsTemplate,locationFilterTemplate,companyDetailsTemplate,citiesAndDepartmentTemplate;
    var cities ;//,{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},,{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false},{name: "Bangalore",seleted:true},{name: "Mumbai", seleted:false}];
    var departments ; //= [{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false}];//,{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false},{name: "Software Engineer",seleted:true},{name:"Support Engineer", seleted:false}];
    var limit,offset;
    var compileHandlebarTemplate = function(templateId) {
        var source   = $('#' + templateId).html();
        return Handlebars.compile(source);
    };

	var copmileTemplate = function(){
        cardsTemplate = compileHandlebarTemplate("cards-template");
        // companyDetailsTemplate = compileHandlebarTemplate("company-details-template");
        citiesAndDepartmentTemplate = compileHandlebarTemplate('cities-department-filter-template');
    };
    var compileCompanyDetailTemplate = function () {
        $().ready(function() {
            companyDetailsTemplate = compileHandlebarTemplate("company-details-template");
        });
    }

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
        var params = "";
        var q = getUrlParameter("q");
        if(q !== undefined && q.length>0){
            params = params+"?q="+q;
        }
        return params;
    };

    var paramsExists = function() {
        var params = window.location.search.substring(1);
        if(params === "" ){
            return false;
        }
        return true;
    };

    var setSortingDropdown = function(){
        var sort_option = getUrlParameter("sort_option");
        $(".ui.dropdown").dropdown("set selected",sort_option);
    };
    var setSearchBar = function(){
        var search_query = getUrlParameter("q");
        $(".prompt.search-bar").val(search_query);
    };


    var setfilterOnRefresh = function(){
        var params = decodeURI(location.search.substring(1));
        params = params.split("&");
        for(var i=0;i<params.length;i++){
            var key_value = params[i].split("=");
            if( key_value[0] == "l[]"){
                $('#filter_cities .ui.checkbox input[name="'+key_value[1]+'"]').parent().checkbox('set checked');
            }
            if(key_value[0] == "d[]"){
                $('#filter_department .ui.checkbox input[name="'+key_value[1]+'"]').parent().checkbox('set checked');
            }
        }

    };
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
        var params = window.location.search.substring(0);
        var uri = "/dashboard/search_openings"+params;
        $.ajax({url:uri,
            success: function(response){
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
                setSortingDropdown();
                setSearchBar();
                setfilterOnRefresh();
                registerCardsScrollBottom();

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
                        $("#SendRequestbtn").removeClass("green").addClass("default disabled").html("Interest Sent");
                    },
                    error: function(xhr,status,error){
                            console.log(error);
                    }

                });
    };

    var removeSortOption = function(params,item){
        params = decodeURI(params);
        var p = params.split("&");
        for(i = 0; i< p.length;i++){
            if(p[i].includes(item)){
                p.splice(i,1);
            }
        }

        return encodeURI(p.join("&"));
    };

    var sorted_cards =function(sort_option){
        var loc_filter = getUrlParameter("l[]");
        var params = "";
        if(loc_filter === undefined || loc_filter ===""){
            params = constructParams();
        }else{
            params = window.location.search.substring(0);
            params = removeSortOption(params,"sort_option");
        }

        if(sort_option !==undefined && sort_option !== ""){
            if(params === undefined || params === "" ){
                params = params + "?sort_option="+sort_option;
            }else{
                params = params + "&sort_option="+sort_option;
            }
        }
        window.history.pushState("object or string", "Title", params);
        cards(sort_option);
    };


    var filterList = function(domId){
        var selected = [];
        $("#"+domId+' .ui.checkbox input:checked').each(function() {
            selected.push($(this).attr('name'));
        });
        return jQuery.unique(selected);
    };

    var addFilter = function(){
        $(".sort.ui.dropdown").dropdown("restore defaults");
        var params = addCityFilter();
        var filter_values ="";
        var department_filter_list = filterList("filter_department");
        if(department_filter_list !== undefined && department_filter_list!== "" && department_filter_list.length > 0){
            for(i =0;i< department_filter_list.length;i++){
                if((params === undefined || params === "") && filter_values === "" ){
                    filter_values = filter_values + "?d[]="+department_filter_list[i];
                }else{
                    filter_values = filter_values + "&d[]="+department_filter_list[i];
                }
            }
        }
        params = params + encodeURI(filter_values);
        if(params === undefined || params ===""){
            window.history.pushState("object or string", "Title", "user_root");
        }else{
            window.history.pushState("object or string", "Title", params);
        }
        cards();
    };

    var addCityFilter = function(){
        var params = constructParams();
        var filter_values = "";
        var cities_filter_list = filterList("filter_cities");
        if(cities_filter_list === undefined || cities_filter_list === "" || cities_filter_list.length === 0){
            return params;
        }
        for(i =0;i< cities_filter_list.length;i++){
            if((params === undefined || params === "") && filter_values === "" ){
                filter_values = filter_values + "?l[]="+cities_filter_list[i];
            }else{
                filter_values = filter_values + "&l[]="+cities_filter_list[i];
            }
        }
        params = params + encodeURI(filter_values);
        return params;
        // window.history.pushState("object or string", "Title", params);
        // CampusConnect.Dashboard.cards();
    };

    var search_openings = function(query){
        window.history.pushState("object or string", "Title", "?q="+query);
        $("#dashboard-cards-loader").addClass("active");
        $.ajax({
            url:"/dashboard/search_openings?q="+query,
            type: "GET",
            async: false,
            success: function (response) {
                $(".sort.ui.dropdown").dropdown("restore defaults");
                $('.ui.checkbox').checkbox('uncheck');
                var html = cardsTemplate(response);
                $("#cards-container").html(html);
                $("#dashboard-cards-loader").removeClass("active");
            },
            error: function(xhr,status,error){
                console.log(error);
                $("#dashboard-cards-loader").removeClass("active");
            }
        });
    };

    var loadCities = function(){
        $.ajax({
            url: "/dashboard/cities",
            type: "GET",
            async: false,
            success: function(response){
                cities = response.data;
            },
            error: function(xhr,status,error){
                cities = [];
                console.log("cities api exception!.");
            }
        })
    }

    var loadPositions = function(){
        $.ajax({
            url: "/dashboard/positions",
            type: "GET",
            async: false,
            success: function(response){
                departments = response.data;
            },
            error: function(xhr,status,error){
                cities = [];
                console.log("cities api exception!.");
            }
        })
    }

    var init =function(){
        $().ready(function() {
            console.log("CampusConnect.Dashboard.init");
            loadCities();
            loadPositions();
            copmileTemplate();
            filterCities();
            filterDepartment();
            $(".ui.checkbox").change(function(){
              addFilter();
            });
            $('.sort.ui.dropdown').dropdown({
              onChange: function(value, text, $selectedItem) {
                sorted_cards(value);
              }
            });
            $(".prompt.search-bar").keydown(function(event){
              if (event.keyCode == 13) {
                  var query = $(this).val();
                  search_openings(query);
              }
            });
            cards();
        });
    };
    var showCompanyDetails =  function(opening_id){
           $.ajax({url:"/dashboard/company_info?op_id="+opening_id,
                success: function(response){
                    var html = companyDetailsTemplate(response.data);
                    $("#company_detail_container").html(html);
                },
                error: function(xhr,status,error){
                    console.log(error);
                }
            });

    };

    var loadCardsOnScroll = function(e){
        var elem = $(e.currentTarget);
        if (elem[0].scrollHeight - elem.scrollTop() <= elem.outerHeight() + 100) {
            paginate();
        }
    };

    var registerCardsScrollBottom = function() {
        limit = 4;offset=0;
        document.getElementById("scrollItem").removeEventListener("scroll", loadCardsOnScroll);
        document.getElementById("scrollItem").addEventListener("scroll", loadCardsOnScroll);

    };

    var paginate = function() {
        $("#dashboard-cards-loader").addClass("active");
        offset += limit;
        var limitQuery = "f=" + offset;
        var currentPageParams = window.location.href.split('?')[1];
        if(currentPageParams !== undefined){
            currentPageParams = "?" + currentPageParams + "&" + limitQuery;
        }else{
            currentPageParams = "?" + limitQuery;
        }
        url = "dashboard/search_openings" + currentPageParams;
        $.ajax({
            url: url,
            type: "GET",
            async: false,
            success: function (response) {
                var html = cardsTemplate(response);
                $("#cards-container").append(html);
                 $("#dashboard-cards-loader").removeClass("active");
                if(response.openings.length === 0){
                    document.getElementById("scrollItem").removeEventListener("scroll", loadCardsOnScroll);
                }
            },
            error: function(xhr,status,error){
                console.log(error);
            }
        });

    };

    return {
        showCompanyDetails:showCompanyDetails,
    	init:init,
        SendRequest:SendRequest,
        compileCompanyDetailTemplate:compileCompanyDetailTemplate
    };
}();

