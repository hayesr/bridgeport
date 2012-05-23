

@Mercury.dialogHandlers.regionsPanel = ->
    
    @form = @element.find('form')
    @controlTemplate = @element.find('.region_controls_template')
    @iframe = jQuery('#mercury_iframe').contents()
    @regionTemplate = @iframe.find('#region_template')
    @regions = @iframe.find('#regions')
    
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
        
    changeRegionWidth = (region, width) ->
        newWidth = numberToClassName(width)
        region.changeData('width', newWidth)
        region.parent().replaceClasses([region.data('label'), newWidth, 'columns'])
        
    changeRegionLabel = (region, label) ->
        region.changeData('label', label)
        region.parent().replaceClasses([label, region.data('width'), 'columns'])
    
    changeRegionPosition = (region, pos) ->
        region.changeData('position', pos)
        
    changeRegionAttrs = (region, label, width, pos) ->
        changeRegionWidth(region, width)
        changeRegionLabel(region, label)
        changeRegionPosition(region, pos)
        
    deleteRegion = (region) ->
        region.attr('data-destroy', 'true')
        region.hide()
        
    balanceWidths = (holdRegion, numColumns) =>
        flexWidth = 12 - classNameToNumber(holdRegion.data('width'))
        newColumnWidth = flexWidth / 2
        @regions.each (i,r) ->
            region = $(r)
            if !region.is(holdRegion)
                changeRegionWidth(region, newColumnWidth)

    addRegion = () =>
        column = @regionTemplate.clone()
        region = column.find('.new-region')
        region.replaceClasses(['mercury-region'])
        changeRegionWidth(region, 6)
        column.removeAttr('id')
        column.appendTo(@regions).show()
        mercuryInstance.buildRegion(region)
        return region
    
    regionLabelControl = (region, group) ->
        label = group.find('.label_control')
        label.val(region.data('label'))
        label.on 'blur', ->
            changeRegionLabel(region, $(@).val())

    
    regionWidthControl = (region, group) ->
        select = group.find('.width_control')
        select.val(classNameToNumber(region.data('width')))
        select.on 'change', ->
            changeRegionWidth(region, $(@).val())
    
    regionPositionControl = (region, group) ->
        select = group.find('.position_control')
        select.val(region.data('position'))
        select.on 'change', ->
            newPos = $(@).val()
            changeRegionPosition(region, newPos)
    
    regionDeleteControl = (region, group) ->
        button = group.find('.delete_region')
        button.on 'click', (event) ->
            deleteRegion(region)
            event.preventDefault()
            @parent('.region_controls_template').slideUp()
            
    regionAddControl = () =>
        button = @element.find('#add_region button')
        button.on 'click', (event) ->
            newRegion = addRegion()
            addRegionControls(newRegion)
            event.preventDefault()
            
    configRegionControls = (region, group) ->
        regionLabelControl(region, group)
        regionWidthControl(region, group)
        regionPositionControl(region, group)
        
    addRegionControls = (region) =>
        group = @controlTemplate.clone()
        configRegionControls(region, group)
        group.appendTo(@form).show()
    
    @regions.find('.mercury-region').each (i,r) =>
        region = $(r)   
        addRegionControls(region)
        # regionAddControl()