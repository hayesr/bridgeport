

@Mercury.dialogHandlers.regionsPanel = ->
    
    classNames = [
        'zero',
        'one', 'two', 'three'
        'four', 'five', 'six'
        'seven', 'eight', 'nine'
        'ten', 'eleven', 'twelve'
        ]
    numberToClassName = (num) ->
        classNames[num]
    classNameToNumber = (className) ->
        classNames.indexOf(className)
            

    @select = @element.find('select')
    @form = @element.find('form')
    
    jQuery('#mercury_iframe').contents().find('.mercury-region[data-width]').each (i,r) =>
        
        region = $(r)
        
        label = region.data('label') + '-width'
        # currentWidth = region.data('width')
        newSelect = @select.clone()
            .attr({ name: label, id: label })
            .val(classNameToNumber(region.data('width')))
        newSelect.on 'change', ->
            
            newWidth = numberToClassName($(@).val())
            $(region).attr('data-width', newWidth)
            $(region).parent()
                .removeClass( (i,c) -> c )
                .addClass(region.data('label') + ' ' + newWidth + ' columns')
            
        newField = $('<div/>', {class: 'field'})
        newLabel = $('<label for="' + label + '">width</label>')
        newLabel.appendTo(newField)
        newSelect.appendTo(newField).show()
        newField.appendTo(@form)


