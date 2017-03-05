var CampusConnect = CampusConnect || {};
CampusConnect.Dashboard = function () {
    

	var init = function(){
		/* off-canvas sidebar toggle */
		$('[data-toggle=offcanvas]').click(function() {
		    $('.row-offcanvas').toggleClass('active');
		    $('.collapse').toggleClass('in').toggleClass('hidden-xs').toggleClass('visible-xs');
		});
	}



    return {
        
    }
}();

