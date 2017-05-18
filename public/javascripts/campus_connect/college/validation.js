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
    return {
        campusDrive :campusDrive
    };
}();