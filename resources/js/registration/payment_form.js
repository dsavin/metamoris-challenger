$().ready(function () {

    $('#location').on('change', function () {

        $.post("fetch-weight-classes", {city: this.value})
            .done(function (data) {

                $("#weight-class option").remove();
                $("#weight-class").get(0).options.add(
                    new Option('Select a weight class', ''));
                $($("#weight-class option").get(0)).prop('disabled', true);
                for (loop = 0; loop < data.length; loop++) {
                    var wClass = data[loop];
                    var text = (loop + 1) + ' - ' + wClass.name + ' ' + wClass.weight;
                    $("#weight-class").get(0).options.add(
                        new Option(text, wClass.id));
                }

                $("#weight-class").prop('disabled', false);
            });
    });

    $("#personal-data-form").validate({
        rules: {

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
