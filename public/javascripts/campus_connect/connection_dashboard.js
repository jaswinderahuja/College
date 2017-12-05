var CampusConnect = CampusConnect || {};
CampusConnect.ConnectionDashboard = function () {

	var cardsTemplate;
    
    var compileHandlebarTemplate = function(templateId) {
        var source   = $('#' + templateId).html();
        return Handlebars.compile(source);
    };

	var copmileTemplate = function(){
        console.log("compile......");
        cardsTemplate = compileHandlebarTemplate("invitation-cards-template");        
    };

    var handlebarUpdateDom = function(domId,template,json) {
        var html = template(json);
        $('#' + domId).html(html);
    };

    var cards = function(sort_option){               
        var uri = "/connections_dashboard/invitations_sent";
        $.ajax({url:uri,
            success: function(response){
                handlebarUpdateDom("invitation-sent",cardsTemplate,response);                
            },
            error: function(xhr,status,error){
                console.log(error);
            }
        });
    };

    var init =function(){        
        copmileTemplate();
    };

    return {
    	init:init,
    	cards:cards
    };
}();

