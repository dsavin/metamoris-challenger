$().ready(function () {

    $('#location').on('change', function () {

        $.post("fetch-weight-classes", {city: this.value})
            .done(function (data) {

                $("#weight_class option").remove();
                $("#weight_class").get(0).options.add(
                    new Option('Select a weight class', ''));
                $($("#weight_class option").get(0)).prop('disabled', true);
                for (loop = 0; loop < data.length; loop++) {
                    var wClass = data[loop];
                    var text = (loop + 1) + ' - ' + wClass.name + ' ' + wClass.weight;
                    $("#weight_class").get(0).options.add(
                        new Option(text, wClass.id));
                }

                $("#weight_class").prop('disabled', false);
            });
    });

    $("#payment-form").validate({
        errorPlacement: function(error, element) {
            // Append error within linked label
            $( element )
                .closest( "form" )
                .find( "label[for='" + element.attr( "id" ) + "']" )
                .append( error);
        },
        rules: {

            'location': {
                required: true
            },
            'weight_class': {
                required: true
            },
            'card_holder': {
                required: true
            },
            'card_type': {
                required: true
            },
            'card_number': {
                creditcard: true,
                required: true
            },
            'card_month': {
                required: true
            },
            'card_year': {
                required: true
            },
            'card-cid': {
                required: true,
                digits: true,
                min: 3,
                max: 3
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
