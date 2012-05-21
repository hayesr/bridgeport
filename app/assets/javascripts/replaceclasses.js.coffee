$.fn.replaceClasses = (new_classes = []) ->
    @removeClass( (i,c) -> c).addClass( new_classes.join(' ') )
    