$().ready(function () {

    console.log('Personal form validation init');
    // validate signup form on keyup and submit
    $("#payment-form").validate({
        rules: {
            'register_form[email]': {
                required: true,
                remote: {
                    url: "check-email",
                    type: "post"
                },
                email: true

            },
            'register_form[password][first]': {
                required: true,
                minlength: 5
            },
            'register_form[password][second]': {
                required: true,
                minlength: 5,
                equalTo: "#register_form_password_first"
            }
        },
        messages: {
            'register_form[password][first]': {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long"
            },
            'register_form[password][second]': {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long",
                equalTo: "Please enter the same password as above"
            },
            'register_form[email]': {
                required: "Please provide an email",
                email: "Please enter a valid email address",
                remote: "This email is already in use"

            },
            'register_form[terms-agree]': "Please accept our policy"
        }
    });

});
