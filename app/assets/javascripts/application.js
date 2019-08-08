// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require_tree ./inputmask
//= require twitter/bootstrap
//= require bootstrap-datepicker/core
//= require moment
//= require daterangepicker
//= require icheck
//= require jquery_nested_form
//= require regularize_request
//= require fullcalendar
//= require jquery-customselect.js
//= require jquery-customselect-1.9.1.js
//= require jquery-customselect-1.9.1.min.js
//= require jquery.remotipart
//= require jquery-sortable.js

//= require highcharts
//= require Chart.bundle
//= require chartkick
//= require jquery.easy-pie-chart.js
//= require jquery.flot.js
//= require jquery.flot.pie.js
//= require_tree ./inputmask
//= require_tree .

$(function () {
    $(window).resize(function() {
        var width = $(window).width();
        if (width <= 1081) {
            $("#sidebar-collapse").parents('#cl-wrapper').addClass('sb-collapsed');
            $("#sidebar-collapse").parents('#cl-wrapper').find('#quikchex-logo').hide();
        } else {
            $("#sidebar-collapse").parents('#cl-wrapper').removeClass('sb-collapsed');
            $("#sidebar-collapse").parents('#cl-wrapper').find('#quikchex-logo').show();
        }
    });

    var width = $(window).width();
    if (width <= 1081) {
        $("#sidebar-collapse").parents('#cl-wrapper').addClass('sb-collapsed');
        $("#sidebar-collapse").parents('#cl-wrapper').find('#quikchex-logo').hide();
    } else {
        $("#sidebar-collapse").parents('#cl-wrapper').removeClass('sb-collapsed');
        $("#sidebar-collapse").parents('#cl-wrapper').find('#quikchex-logo').show();
    }


    $("#sidebar-collapse").click(function () {
        var boolean_value = $(this).parents("#cl-wrapper").hasClass('sb-collapsed');
        if (boolean_value) {
            $(this).parents('#cl-wrapper').find('#quikchex-logo').hide();
        } else {
            $(this).parents('#cl-wrapper').find('#quikchex-logo').show();
        }
    });
    $('select.sort-list-options').each(function () {
        var options = $(this).find("option");
        var arr = options.map(function(_, o) { return { t: $(o).text(), v: o.value }; }).get();
        if ($(this).attr('multiple') !== 'multiple'){
            var first_elm = arr.shift();
        }

        arr.sort(function(o1, o2) {
            var t1 = o1.t.toLowerCase(), t2 = o2.t.toLowerCase();
            return t1 > t2 ? 1 : t1 < t2 ? -1 : 0;
        });
        if ($(this).attr('multiple') !== 'multiple'){
            arr.unshift(first_elm);
        }
        options.each(function(i, o) {
            o.value = arr[i].v;
            $(o).text(arr[i].t);
        });
    });
});


function calculateSum(elementClass) {
    total = 0;
    //iterate through each textboxes and add the values
    $(elementClass).each(function () {
        //add only if the value is number
        if (!isNaN(this.value) && this.value.length != 0) {
            total += parseInt(this.value);
        }
    });
    return total;
}

(function (i, s, o, g, r, a, m) {
    i['GoogleAnalyticsObject'] = r;
    i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
    a = s.createElement(o),
        m = s.getElementsByTagName(o)[0];
    a.async = 1;
    a.src = g;
    m.parentNode.insertBefore(a, m)
})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

ga('create', 'UA-67257791-1', 'auto');
ga('send', 'pageview');


// For ckeditor editable popup
$.fn.modal.Constructor.prototype.enforceFocus = function () {
    modal_this = this
    $(document).on('focusin.modal', function (e) {
        if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select')
            && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
            modal_this.$element.focus()
        }
    })
};

