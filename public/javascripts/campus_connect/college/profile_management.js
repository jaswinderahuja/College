var CampusConnect = CampusConnect || {};
CampusConnect.College = CampusConnect.College || {};
CampusConnect.College.ProfileManagement = function() {


	var campus_info_table_init = function(){
		$('#edit_campus_info').click(function(){
		    $('#edit_campus_info').hide();
		    $('#campus_info_table label').each(function(){
		        $(this).hide();     
		    });  
		    $('#campus_info_table .ui.input').each(function(){
		        $(this).show();     
		    });  
		      $("#campus_info_table tfoot").show() // enabling save button
		});

		  $('#cancel_edit_campus_info').click(function(){    
		      $("#campus_info_table tfoot").hide() // disabling save button
		      $(".ui.error.message.campus_info").html('');
		    $('#campus_info_table label').each(function(){
		        $(this).show();     
		    });  
		      $('#campus_info_table .ui.input').each(function(){
		        $(this).hide();
		      });  
		    $('#edit_campus_info').show();
		  });
	}

	var campus_contact_info_table_init = function(){
		$('#edit_campus_contact_info').click(function(){
		    $('#edit_campus_contact_info').hide();
		    $('#campus_contact_info_table label').each(function(){
		        $(this).hide();     
		    });  
		    $('#campus_contact_info_table .ui.input').each(function(){
		        $(this).show();     
		    });  
		      $("#campus_contact_info_table tfoot").show() // enabling save button
		  });

		  $('#cancel_edit_campus_contact_info').click(function(){    
		      $("#campus_contact_info_table tfoot").hide() // disabling save button
		      $(".ui.error.message.campus_contact_info").html('');
		    $('#campus_contact_info_table label').each(function(){
		        $(this).show();     
		    });  
		      $('#campus_contact_info_table .ui.input').each(function(){
		        $(this).hide();
		      });  
		    $('#edit_campus_contact_info').show();
		  });
	}

	var user_info_table_init = function(){
		$('#edit_user_info').click(function(){
		    $('#edit_user_info').hide();
		    $('#user_info_table label').each(function(){
		        $(this).hide();     
		    });  
		    $('#user_info_table .ui.input').each(function(){
		        $(this).show();     
		    });  
		      $("#user_info_table tfoot").show() // enabling save button
		  });

		  $('#cancel_edit_user_info').click(function(){    
		      $("#user_info_table tfoot").hide() // disabling save button
		      $(".ui.error.message.user_info").html('');
		    $('#user_info_table label').each(function(){
		        $(this).show();     
		    });  
		      $('#user_info_table .ui.input').each(function(){
		        $(this).hide();
		      });  
		    $('#edit_user_info').show();
		  });
	}

	
	var ready = function(){
		$(document).ready(function(){
			campus_info_table_init();
			campus_contact_info_table_init();	
			user_info_table_init();
		  	CampusConnect.College.Validation.campusInfo();
		  	CampusConnect.College.Validation.campusContactInfo();
		})
	}();

    return {
        
    };
}();