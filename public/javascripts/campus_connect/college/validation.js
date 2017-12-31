var CampusConnect = CampusConnect || {};
CampusConnect.College = CampusConnect.College || {};
CampusConnect.College.Validation = function() {
    var campusDrive = function () {
        $('.ui.large.form').form({
            fields: {
                    'college': {
                    identifier: 'college',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the college name'
                    }]
                },
                'address_line_1': {
                    identifier: 'address_line_1',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the address'
                    }]
                },
                'date_of_drive': {
                    identifier: 'date_of_drive',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the Date of Drive'
                    }]
                },
                'no_of_students': {
                    identifier: 'no_of_students',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter the correct no of students for drive'
                    }]
                },
                'department': {
                    identifier: 'dept',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the department'
                    }]
                },
                'hod_email': {
                    identifier: 'hod_email',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a correct email for HOD'
                    }]
                },
                'coordinator_email_1': {
                    identifier: 'coordinator_email_1',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a correct email address'
                    }]
                },
                'coordinator_email_2': {
                    identifier: 'coordinator_email_2',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a correct email address'
                    }]
                },
                'phone_1': {
                    identifier: 'phone_1',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter numbers only for phone #'
                    },{
                        type: 'exactLength[10]',
                        prompt: 'Contact number length should be 10 digits'
                    }]
                },
                'phone_2': {
                    identifier: 'phone_2',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter numbers only'
                    },{
                        type: 'exactLength[10]',
                        prompt: 'Contact number length should be 10 digits'
                    }]
                }
            }
        });
    };
    var userHelp = function () {
        $('.ui.large.form').form({                            
            fields: {
                'email': {
                    identifier: 'email',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a valid email address'
                    }]
                },
                'phone_number': {
                    identifier: 'phone_number',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter numbers only for phone #'
                    },{
                        type: 'exactLength[10]',
                        prompt: 'Contact number length should be 10 digits'
                    }]
                }
            },
            inline : true,
            on     : 'blur'            
        });
    };

    var campusInfo = function () {
        $('.ui.large.form.campus_info').form({                            
            fields: {
                'college_name': {
                    identifier: 'college_name',
                    rules: [{
                        type: 'empty',
                        prompt: 'College name can not be blank'
                    }]
                },
                'university_name': {
                    identifier: 'university_name',
                    rules: [{
                        type: 'empty',
                        prompt: 'University name can not be blank'
                    }]
                },                
                'address_line_1': {
                    identifier: 'address_line_1',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the address'
                    }]
                },
                'pincode': {
                    identifier: 'pincode',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter a pincode'
                    },{
                        type: 'exactLength[6]',
                        prompt: 'Pincode number length should be 6 digits'
                    }]
                },
                'town_city': {
                    identifier: 'town_city',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the city'
                    }]
                },
                'state': {
                    identifier: 'state',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter a state'
                    }]
                }
            }
        });
    };
    return {
        campusDrive :campusDrive,
        userHelp:userHelp,
        campusInfo:campusInfo
    };
}();