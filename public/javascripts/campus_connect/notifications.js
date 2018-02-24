var CampusConnect = CampusConnect || {};
CampusConnect.Notifications = function () {
    var notificationTemplate;

    var compileTemplates = function(){
        var source = $("#notification-template").html();
        notificationTemplate = Handlebars.compile(source);
    }

    var showNotificationCount = function(){
        var url = "/connections_dashboard/notifications";
        $.ajax({url:url,
            success: function(response){
                response = response.data;
                $("#notification-count").html(response.length);
                var html = notificationTemplate({"notifications":response});
                $("#notification-container").html(html);

            }
        });
    }

    var init = function(){
        $().ready(function() {
            compileTemplates();
            showNotificationCount();
        });
    };
    return {
        init: init
    }
}();
