//$("input[name='company[paying_it]']").next().addClass('paying_it');
//$(".paying_it").on('click', function () {
//    it_flag = $(this).prev().val();
//    if (it_flag == 'true'){
//        $('#tan_number').show();
//        $('#tan_number input').rules( "add", {required: true});
//    }
//    else
//        $('#tan_number').hide();
//
//});

function radioSwitch(clickedElm, dependentElmID, flagToCompare){
    flag = clickedElm.children('div').children('input').val();
    if (flag == flagToCompare) {
        $('#' + dependentElmID).show();
        $('#' + dependentElmID + ' input').rules("add", {required: true});
    }
    else
        $('#' + dependentElmID).hide();
}

function radioSwitcher(clickedElm, dependentElmID, flagToCompare){
    flag = clickedElm.prev('input').val();
    if (flag == flagToCompare) {
        $('#' + dependentElmID).show();
        $('#' + dependentElmID + ' input').rules("add", {required: true});
    }
    else
        $('#' + dependentElmID).hide();
}

function radioSwitchClass(clickedElm, dependentElmClass, flagToCompare){
    flag = clickedElm.children('div').children('input').val();
    if (flag == flagToCompare) {
        $('.' + dependentElmClass).show();
        $('.' + dependentElmClass + ' input').rules("add", {required: true});
    }
    else
        $('.' + dependentElmClass).hide();
}

function radioSwitcherClass(clickedElm, dependentElmClass, flagToCompare){
    flag = clickedElm.prev('input').val();
    if (flag == flagToCompare) {
        $('.' + dependentElmClass).show();
        $('.' + dependentElmClass + ' input').rules("add", {required: true});
    }
    else
        $('.' + dependentElmClass).hide();
}

function addSwitcherClasses(elementName, classToAddForText, classToAddForCircle){
    setTimeout(function(){
        $("input[name='"+ elementName +"']").parent().parent().addClass(classToAddForText);    
        $("input[name='"+ elementName +"']").next('ins').addClass(classToAddForCircle);
    }, 100)

}


function getQueryStringParams(sParam) {
    //alert('inside getQueryStringParams')
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split('&');
    for (var i = 0; i < sURLVariables.length; i++) {
        var sParameterName = sURLVariables[i].split('=');
        if (sParameterName[0] == sParam)
            return sParameterName[1];
    }
}

function searchTable(searchKey,className,tableId) {
    // Show only matching TR, hide rest of them
    $.each($('#'+tableId+' tbody').find("tr"), function () {
        if ($('.'+className, this).text().toLowerCase().indexOf(searchKey.toLowerCase()) == -1)
            $(this).hide();
        else
            $(this).show();
    });
};

function sortTable(column_number, tableId){
    var $tbody = $('#'+tableId+' tbody');
    $tbody.find('tr').sort(function(a,b){
        var tda = $(b).find('td:eq(0)').text(); // can replace 1 with the column you want to sort on
        var tdb = $(a).find('td:eq(0)').text(); // this will sort on the second column
        // if a < b return 1
        return tda < tdb ? 1
            // else if a > b return -1
            : tda > tdb ? -1
            // else they are equal - return 0
            : 0;
    }).appendTo($tbody);
}

function fnOpenNormalDialog() {
    $("#dialog-confirm").html("Are you sure you want to delete this Field?");
    alert($("#dialog-confirm").html());
    // Define the Dialog and its properties.
    $("#dialog-confirm").dialog({
        resizable: false,
        modal: true,
        title: "Modal",
        height: 250,
        width: 400,
        buttons: {
            "Yes": function () {
                $(this).dialog('close');
                callback(true);
            },
            "No": function () {
                $(this).dialog('close');
                callback(false);
            }
        }
    });
}



function callback(value) {
    if (value) {
        alert("Confirmed");
    } else {
        alert("Rejected");
    }
}

function fullTextTime(value) {
    if(!value){
        return null
    }
    if (value.indexOf("Hours") > -1) {
        return value;
    }
    else{
        return value.split(':')[0] + ' Hours : ' + value.split(':')[1] + ' Minutes'  || '00 Hours : 00 Minutes'
    }
}

function month_year_list(how_many_months, from_month, from_year) {
    var monthYearList = new Array();
    date = new Date(Date.parse(from_month + "1, " + from_year));
    year = parseInt(from_year);
    month = date.getMonth();
    no_of_months = how_many_months;
    var monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];
    while (no_of_months > 0) {
        if (month > 11) {
            month = 0;
            year += 1;
        }
        monthYearList.push(monthNames[month] + "-" + year);
        month += 1;
        no_of_months--;
    }
    return monthYearList
}

function load_checkbox(){
    $('#assignments-table .icheck1').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue'
    });

    $('.iCheck-helper').click(function () {
        var resultArray = [];
        $('.checked').children('.icheck1').each(function() {
            resultArray.push($(this).attr('id'));
        });

//            $('#employee').attr('val', resultArray)

        if ($(this).siblings('input').attr('name')=='select_all') {
            if ($(this).find(':first-child').hasClass('checked') || ($(this).hasClass('iCheck-helper') && $(this).parent().hasClass('checked'))) {
                $('.selection-processed').prop('checked', true);
                $('.selection-processed').parent().addClass('checked');
            } else {
                $('.selection-processed').prop('checked', false);
                $('.selection-processed').parent().removeClass('checked');

            }
        } else {
            if ($(this).find(':first-child').hasClass('checked') || ($(this).hasClass('iCheck-helper') && $(this).parent().hasClass('checked'))) {
                $(this).siblings('.selection-processed').prop('checked', true);
                $(this).siblings('.selection-processed').parent().addClass('checked');
            } else {
                $(this).siblings('.selection-processed').prop('checked', false);
                $(this).siblings('.selection-processed').parent().removeClass('checked');

            }
        }

    });


    $('ins').on('click', function () {
        if ($(this).siblings('input').hasClass('selection-processed') && $('#select-all-processed').find(':first-child').hasClass('checked'))
            $('#select-all-processed').find(':first-child').removeClass('checked');
    });

    $('.allocation-delete').click(function(event){
        event.preventDefault();
        $('#custom-confirm-box').find('.delete').data('remote', true);
    });
    $("#custom-confirm-box").find('.delete').data('remote', false);
}

function change_type_request(value) {
    var type_of_request = value;
    if (type_of_request == 'Check In Request') {
        $('.check-in-time').removeClass('hide');
        $('.check-out-time').addClass('hide');
    }
    else if (type_of_request == 'Check Out Request') {
        $('.check-in-time').addClass('hide');
        $('.check-out-time').removeClass('hide');
    }
    else if (type_of_request == 'Check In & Check Out Request') {
        $('.check-in-time').removeClass('hide');
        $('.check-out-time').removeClass('hide');
    }
    else {
        $('.check-in-time').addClass('hide');
        $('.check-out-time').addClass('hide');
    }
}

var delay = (function(){
    var timer = 0;
    return function(callback, ms){
        clearTimeout (timer);
        timer = setTimeout(callback, ms);
    };
})();


function calculate_income_tax(){

}

$(function() {
  $(".datetime").on('change', function(){
    if (!($(this).val()=="")) {
      $(this).parent().find('label.error').hide();
      $(this).parent().find('input.error').removeClass('error');
    }
  })
})
