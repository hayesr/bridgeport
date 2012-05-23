$.fn.replaceClasses = (new_classes = []) ->
    @removeClass( (i,c) -> c).addClass( new_classes.join(' ') )
    
$.fn.changeData = (attr, value) ->
    @attr('data-' + attr, value)
    @data(attr, value)
    
    
# changeData = (elem, attr, value) ->
#     elem.attr('data-' + attr, value)
#     elem.data(attr, value)