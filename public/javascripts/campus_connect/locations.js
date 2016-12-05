var CampusConnect = CampusConnect || {};
CampusConnect.Locations = function () {
  var countryTemplate,stateTemplate,cityTemplate;

    var compileTemplates = function(){
      var source = $("#location-tempate").html();
      countryTemplate = Handlebars.compile(source);

    }

      var init = function(){
        compileTemplates();
        $.ajax({url: "/locations/countries",success: function(result){
            console.log(result);
            var html = countryTemplate(result);
            console.log(html);
            $("#location").html(html);
            }
        });

      };
  return {
      init: init
  }
}();
