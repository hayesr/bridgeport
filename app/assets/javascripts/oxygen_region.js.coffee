
class OxygenRegion
    constructor: (r) ->
        @region = $(r)
        @column = @region.parent()
        @label = @region.data('label')
        
    @classNames = [
        'zero',
        'one', 'two', 'three'
        'four', 'five', 'six'
        'seven', 'eight', 'nine'
        'ten', 'eleven', 'twelve'
        ]
        
    @numberToClassName = (num) ->
        classNames[num]
    @classNameToNumber = (className) ->
        classNames.indexOf(className)
            
    changeWidth = (width) =>
        newWidth = numberToClassName(width)
        @region.attr('data-width', newWidth)
        @column.replaceClasses([@label, newWidth, 'columns'])
        
    changeLabel = (newLabel) =>
        @region.attr('data-label', new_label)
        @parent.replaceClasses([new_label, region.data('width'), 'columns'])
        
    changePosition = (pos) =>
        @region.attr('data-position', pos)
        
    selfDestruct = () =>
        @region.attr('data-destroy', 'true')
        @region.hide()
        
    labelControl = (group) =>
        label = group.find('.label_control')
        label.val(@label)
        label.on 'blur', ->
            newLabel = $(@).val()
            changeLabel(newLabel)
            
    widthControl = (group) =>
        select = group.find('.width_control')
        select.val(classNameToNumber(region.data('width')))
        select.on 'change', ->
            changeWidth($(@).val())
            
    positionControl = (group) =>
        select = group.find('.position_control')
        select.val(region.data('position'))
        select.on 'change', ->
            changePosition($(@).val())
            
    deleteButton = (group) =>
        button = group.find('.delete_region')
        button.on 'click', (event) ->
            selfDestruct()
            event.preventDefault()
            this.parent('.region_controls_template').slideUp()
            
    createControls = (group) =>
        labelControl(group)
        widthControl(group)
        positionControl(group)
        deleteButton(group)