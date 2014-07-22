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
