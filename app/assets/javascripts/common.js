/**
 * Created with JetBrains RubyMine.
 * User: yi
 * Date: 14-3-22
 * Time: 上午11:52
 * To change this template use File | Settings | File Templates.
 */

$(document).mouseup(function (e)
{
    var ele =  $('.name_drop_down');
    if (!ele.is(e.target) // if the target of the click isn't the container...
        && ele.has(e.target).length === 0) // ... nor a descendant of the container
    {
        ele.hide();
    }
});

function find_item_by_name(obj){
    $.ajax({
        type:'get',
        url:'/item/search_name',
        data:{
            code :  $(obj).val()
        },
        success: function(data){
            var html = "<div class='name_drop_down'>";
            $(data).each(function(i,e){
                html+='<div class="name_drop_down_item">'+ e.item_code+'</div>';
            });
            html +='</div>';
            $('.name_drop_down').remove();
            $(obj).after(html);
            $('.name_drop_down_item').bind("click",(function(e){
                $(obj).val($(this).text());
                get_price($(this).text())
                $(this).parent().fadeOut();
            }));
        },
        error: function(data){
            alert('error'+data);
        },
        format: "json"
    });
}

function get_price(name){
    $.ajax({
        type:'get',
        url:'/item/search_price',
        data:{
            code :  name
        },
        success: function(price){
            $('#price').text(price)
            calc_price()
        },
        error: function(data){
            alert('error'+data);
        },
        format: "text"
    });
}

function calc_price(){
    if( $('#price').text()*1>0 && $('#sale_quantity').val()*1>0 ){
        amount =  $('#price').text()*1*$('#sale_quantity').val()*1
        $('#amount').text(amount)
    }else{
        amount = $('#sale_quantity').val()*1
        $('#amount').text(amount)
    }
}