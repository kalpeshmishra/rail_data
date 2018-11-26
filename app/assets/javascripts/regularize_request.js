$(document).ready(function () {
    $('body').on('ajax:success', '#regularize-info', function (event, data) {
        var obj = data.regularize_request;
        if (obj !== undefined){
            var bbb = "td#" + data.employee_id_111 + "_" + obj.date;
            $(this).parents('#individual-modal').find('.close').click();
            var check_in_out = data.checkin_time + '-' + data.checkout_time;
            var divClass = 'data-class';
            var tdClass = data.cell_class;
            if(tdClass.includes('hider')){
                tdClass = '';
                divClass = 'hider';
            }
            //$(this).parents('.table-responsive').find('#regularize_request_body').find(bbb).html('<div class="'+divClass+' '+tdClass+'">'+check_in_out+'</div>');
            $(this).parents('.table-responsive').find('#regularize_request_body').find(bbb).html('<div class="' + divClass + ' ' + tdClass + '">' + check_in_out + '</div>' +
            '<span class="regularize_emp_id" val="'+data.employee_id_111+'"></span>' +
            '<span class="employee-date-selected regularize_emp_date"></span>');
        }
    });
});