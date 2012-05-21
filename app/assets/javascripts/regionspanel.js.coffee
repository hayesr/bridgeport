

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
            

    # @select = @element.find('select')
    @form = @element.find('form')
    @template = @element.find('.region_controls_template')
    
    regionLabelControl = (region, group) ->
        label = group.find('.label_control')
        label.val(region.data('label'))
        label.on 'blur', ->
            new_label = $(@).val()
            region.attr('data-label', new_label)
            region.parent().replaceClasses([new_label, region.data('width'), 'columns'])
    
    regionWidthControl = (region, group) ->
        select = group.find('.width_control')
        select.val(classNameToNumber(region.data('width')))
        select.on 'change', ->
            newWidth = numberToClassName($(@).val())
            region.attr('data-width', newWidth)
            region.parent().replaceClasses([region.data('label'), newWidth, 'columns'])
    
    regionPositionControl = (region, group) ->
        select = group.find('.position_control')
        select.val(region.data('position'))
        select.on 'change', ->
            newPos = $(@).val()
            region.attr('data-position', newPos)
    
    regionDeleteControl = (region, group) ->
        button = group.find('.delete_region')
        button.on 'click', (event) ->
            region.attr('data-destroy', 'true')
            region.hide()
            event.preventDefault()
            @parent('.region_controls_template').slideUp()
            
    configRegionControls = (region, group) ->
        regionLabelControl(region, group)
        regionWidthControl(region, group)
        regionPositionControl(region, group)
        regionDeleteControl(region, group)
        
    # addRegion = () ->
    
    jQuery('#mercury_iframe').contents().find('.mercury-region[data-width]').each (i,r) =>
        region = $(r)
        # clone all fields
        # pre-fill label text
        # bind event to label field
        # pre-fill width value
        # bind event to width select
        # pre-fill position value
        # bind event to position select
        
        new_group = @template.clone()
        configRegionControls(region, new_group)
        new_group.appendTo(@form).show()
    #     
    #     region = $(r)
    #     
    #     label = region.data('label') + '-width'
    #     # currentWidth = region.data('width')
    #     newSelect = @select.clone()
    #         .attr({ name: label, id: label })
    #         .val(classNameToNumber(region.data('width')))
    #     newSelect.on 'change', ->
    #         
    #         newWidth = numberToClassName($(@).val())
    #         $(region).attr('data-width', newWidth)
    #         $(region).parent()
    #             .removeClass( (i,c) -> c )
    #             .addClass(region.data('label') + ' ' + newWidth + ' columns')
    #         
    #     newField = $('<div/>', {class: 'field'})
    #     newLabel = $('<label for="' + label + '">width</label>')
    #     newLabel.appendTo(newField)
    #     newSelect.appendTo(newField).show()
    #     newField.appendTo(@form)
        