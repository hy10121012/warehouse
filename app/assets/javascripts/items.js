$(function() {
$.plot("#placeholder", [data], {
    lines: {
        show: true
    },
    points: {
        show: true
    },
    xaxis: {
        mode: "time",
        minTickSize: [1, "day"]
    }
});

});