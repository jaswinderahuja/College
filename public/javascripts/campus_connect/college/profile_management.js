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
	
	var inplace_edit_init = function(id){
		$('#edit_'+id).click(function(){
		    $(this).hide();
		    $('#'+id+'_table label').each(function(){
		        $(this).hide();     
		    });  
		    $('#'+id+'_table .ui.input').each(function(){
		        $(this).show();     
		    });  
		      $("#"+id+"_table tfoot").show() // enabling save button
		  });

		  $('#cancel_edit_'+id).click(function(){    
		      $("#"+id+"_table tfoot").hide() // disabling save button
		      $(".ui.error.message."+id).html('');
		    $('#'+id+'_table label').each(function(){
		        $(this).show();     
		    });  
		      $('#'+id+'_table .ui.input').each(function(){
		        $(this).hide();
		      });  
		    $('#edit_'+id).show();
		  });
	}

	
	var ready = function(){
		$(document).ready(function(){
			campus_info_table_init();
			campus_contact_info_table_init();				
			inplace_edit_init("user_info");
			inplace_edit_init("social_connect");
		  	CampusConnect.College.Validation.campusInfo();
		  	CampusConnect.College.Validation.campusContactInfo();
		  	CampusConnect.College.Validation.UserInfo();
		  	CampusConnect.College.Validation.UserSocialConnect();
		})
	}();

    return {
        
    };
}();