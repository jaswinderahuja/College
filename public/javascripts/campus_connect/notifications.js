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

    var getParamValue = function(inp_string,param){
        var value = "";
        if(inp_string === undefined || inp_string === ""){
            return "";
        }
        inp_string.split("&").forEach(function(item){
            var arr = item.split("=");
            if(arr[0] == param ){
                value = arr[1];
            }
        })
        return value;
    }

    var updateNotificationStatus = function(params){
       var op_id = getParamValue(params.split("?")[1],"op_id");
       if(op_id === undefined || op_id === ""){
            alert("OOPS, something went wrong");
            return;
       }
       console.log(op_id);

       var url = "/api/v0/college-seen-status?op_id="+op_id;
        $.ajax({
            url: url,
            type: 'PUT',
            success: function(response){
                response = response.data;
                console.log(response);
            },
            error: function(response){
                console.log("phat gya")
                console.log(response)
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
        init: init,
        updateNotificationStatus: updateNotificationStatus
    }
}();
