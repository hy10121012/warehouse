/**
 * Created with JetBrains RubyMine.
 * User: yi
 * Date: 14-3-22
 * Time: 上午11:52
 * To change this template use File | Settings | File Templates.
 */

document.onkeydown = checkKey;
window.selected_item_id = 0;
window.boxObj=null;
window.cbfn=null;
function checkKey(e) {
    var ele = $('.name_drop_down');
    if (ele.length > 0) {
        e = e || window.event;

        console.log('#item_' + window.selected_item_id)
        $('.name_drop_down_item').removeClass('name_drop_down_item_selected');
        if (e.keyCode == '38') {
            if( window.selected_item_id>0){
                $('#item_' + --window.selected_item_id).addClass('name_drop_down_item_selected');
            }
            if( window.selected_item_id<=0){
                window.selected_item_id=0
            }
        }
        else if (e.keyCode == '40') {
            if( $('#item_'+(window.selected_item_id+1)).length>0){
                $('#item_' + ++window.selected_item_id).addClass('name_drop_down_item_selected');
            }
        }
        else if(e.keyCode == 13 && window.boxObj!=null){
            $(window.boxObj).val($('#item_' +window.selected_item_id).text())
            if(window.cbfn!=null){
                window.cbfn()
            }
            ele.remove();
        }
    }
}

function enterItem(boxObj,fn){
    var e = e || window.event;

}


$(document).mouseup(function (e) {
    var ele = $('.name_drop_down');
    if (!ele.is(e.target) // if the target of the click isn't the container...
        && ele.has(e.target).length === 0) // ... nor a descendant of the container
    {
        ele.remove();
    }
});
