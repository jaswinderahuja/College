var CampusConnect = CampusConnect || {};
CampusConnect.Utilities = function () {
    var departmentTemplate;
    var signOut = function (token) {
        console.log('signout');
        $.ajax({url: "/users/sign_out",
                success: function (result) {
                    window.location.replace('/');
                    },
                type: 'delete',
                data: {authenticity_token: token}
                });
    };

    var copmileTemplate = function(){
        var source   = $("#departments-template").html();
        departmentTemplate = Handlebars.compile(source);
    };

    var departments = function(){
        $.ajax({url:"/campus_drives/get_departments",
            success: function(response){
                var html = departmentTemplate(response);
                console.log(html);
                $("#search-select").html(html);
            }
        });
    };


    var init =function(){
        $(document).ready(function() {
            copmileTemplate();
        });
    };
    return {
        init: init,
        departments: departments,
        signOut: signOut
    };
}();
CampusConnect.Utilities.init();
