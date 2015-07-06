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

});
