var CampusConnect = CampusConnect || {};
CampusConnect.Utilities = function () {
    var departmentTemplate, cityTemplate;
    var signOut = function (token) {
        console.log('signout');
        $.ajax({url: "/users/sign_out",
                success: function (result) {
                    console.log("in");
                    window.location.href = '/';
                    },
                type: 'delete',
                data: {authenticity_token: token}
                });
    };

    var copmileTemplate = function(){
        if($("#departments-template").html() != undefined){
            var source = $("#departments-template").html();
            departmentTemplate = Handlebars.compile(source);    
        }
        if($("#cities-template").html() != undefined){
            var source = $("#cities-template").html();
            cityTemplate = Handlebars.compile(source);    
        }
    };

    var departments = function(){
        $.ajax({url:"/campus_drives/get_departments",
            success: function(response){
                var html = departmentTemplate(response);
                $("#search-select-dept").html(html);
            }
        });
    };

    var cities = function(){
      $.ajax({url:"/campus_drives/cities",
            success: function(response){
                var html = cityTemplate(response);
                $("#search-select-city").html(html);
            }
        });  
    }


    var init =function(){
        $(document).ready(function() {
            copmileTemplate();
        });
    }();
    return {
        init: init,
        departments: departments,
        cities: cities,
        signOut: signOut
    };
}();
// CampusConnect.Utilities.init();
