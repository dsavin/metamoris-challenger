$().ready(function () {

    console.log('SignUp form valiudation init');
    // validate signup form on keyup and submit
    var validator = $("#register-form").validate({
        debug: true,
        rules: {
            password: {
                required: true,
                minlength: 5
            },
            'password-repeat': {
                required: true,
                minlength: 5,
                equalTo: "#password"
            },
            agree: "required"
        },
        messages: {
            password: {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long"
            },
            'password-repeat': {
                required: "Please provide a password",
                minlength: "Your password must be at least 5 characters long",
                equalTo: "Please enter the same password as above"
            },
            email: "Please enter a valid email address",
            agree: "Please accept our policy"
        }
    });

});
