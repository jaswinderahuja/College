var CampusConnect = CampusConnect || {};
CampusConnect.Login = CampusConnect.Login || {};
CampusConnect.Login.Validation = function() {
    var initial = function() {
        $('.ui.large.form').form({
            fields: {
                'user[firstname]': {
                    identifier: 'user_firstname',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter your first name'
                    }]
                },
                'user[lastname]': {
                    identifier: 'user_lastname',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter your last name'
                    }]
                },
                'user[email]': {
                    identifier: 'user_email',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a valid e-mail'
                    }]
                },
                'user[password]': {
                    identifier: 'user_password',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter a password'
                    }, {
                        type: 'minLength[6]',
                        prompt: 'Your password must be at least {ruleValue} characters'
                    }]
                },
                'user[password_confirmation]': {
                    identifier: 'user_password_confirmation',
                    rules: [{
                        type: 'match[user_password]',
                        prompt: 'Passwords do not match'
                    }]
                }
            }
        });
    };
    var login = function() {
        $('.ui.large.form').form({
            fields: {
                'user[email]': {
                    identifier: 'user_email',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a valid email address'
                    }]
                },
                'user[password]': {
                    identifier: 'user_password',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter your password'
                    },
                    {
                        type: 'minLength[6]',
                        prompt: 'Your password must be at least {ruleValue} characters'
                    }]
                }
            }
        });
    };

    var collegeRegistration = function () {
        $('.ui.large.form').form({
            fields: {
                'university': {
                    identifier: 'university',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the University name'
                    }]
                },
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
                'town_city': {
                    identifier: 'town_city',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the town / city'
                    }]
                },
                'pincode': {
                    identifier: 'pincode',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter the numbers only for pincode'
                    },{
                        type: 'exactLength[6]',
                        prompt: 'Please enter a correct pincode'
                    }]
                },
                'state': {
                    identifier: 'state',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the state'
                    }]
                },
                'country': {
                    identifier: 'country',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the country'
                    }]
                },
                'email_id_1': {
                    identifier: 'email_id_1',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a correct email address'
                    }]
                },
                'email_id_2': {
                    identifier: 'email_id_2',
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
                },
                'landline_no': {
                    identifier: 'landline_no',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter numbers only for landline no'
                    },{
                        type: 'exactLength[11]',
                        prompt: 'Please enter a correct landline no'
                    }]
                }
            }
        });
    };
    return {
        initial: initial,
        login: login,
        collegeRegistration :collegeRegistration
    };
}();