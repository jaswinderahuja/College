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
                'user[confir_pass]': {
                    'identifier': 'user_confirm_pass',
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

    var completeRegistration = function () {
        $('.ui.large.form').form({
            fields: {
                'company_name': {
                    identifier: 'company_name',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the company name'
                    }]
                },
                'no_of_employees': {
                    identifier: 'no_of_employees',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter the # of employees'
                    }]
                },
                'annual_revenue': {
                    identifier: 'annual_revenue',
                    rules: [{
                        type: 'integer',
                        prompt: 'Please enter the annual revenue'
                    }]
                },
                'head_quaters': {
                    identifier: 'head_quaters',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the head quaters'
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
                        prompt: 'Please enter the number only for pincode'
                    },{
                        type: 'exactLength[6]',
                        prompt: 'Please enter a correct landline no'
                    }]
                },
                'state': {
                    identifier: 'state',
                    rules: [{
                        type: 'empty',
                        prompt: 'Please enter the state'
                    }]
                },
                'email_id': {
                    identifier: 'email_id',
                    rules: [{
                        type: 'email',
                        prompt: 'Please enter a correct email address'
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
        completeRegistration :completeRegistration
    };
}();