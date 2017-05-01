var CampusConnect = CampusConnect || {};
CampusConnect.Locations = function () {
  var countryTemplate,stateTemplate,cityTemplate;

    var compileTemplates = function(){
      var source = $("#location-tempate").html();
      countryTemplate = Handlebars.compile(source);
      var source = $("#states-template").html();
      stateTemplate = Handlebars.compile(source);
      var source = $("#cities-template").html();
      cityTemplate = Handlebars.compile(source);

    }

    var getStates = function(country_id){
      $.ajax({url:"/locations/states?country_id="+country_id,
        success: function(response){

          var html = stateTemplate(response);
          $("#state_container").html(html);
        }
      });
    }

    var getCities = function(state_id){
      $.ajax({url:"/locations/cities?state_id="+state_id,
        success: function(response){
          var html = cityTemplate(response);
          $("#city_container").html(html);
        }
      })
    }

      var init = function(){
        compileTemplates();
        $.ajax({url: "/locations/countries",
          success: function(result){
            // console.log(result);
            var html = countryTemplate(result);
            $("#country_container").html(html);
            }
        });

        // empty state template
          var html = stateTemplate;
          $("#state_container").html(html);
        // empty city template
          var html = cityTemplate;
          $("#city_container").html(html);



      };
  return {
    getStates:getStates,
    getCities:getCities,
      init: init
  }
}();
