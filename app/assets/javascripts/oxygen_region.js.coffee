window.Oxygen ||= {}

Oxygen.buildId = () ->
    d = new Date().getTime()
    parseInt(d * Math.random())

# Oxygen RegionRow
# Keeps a regions array
# balances region widths
# repositions
# creates region controls
class Oxygen.RegionRow
    constructor: (row) ->
        @id = Oxygen.buildId()
        @row = row
        @_regions = []
        @_controls = []
        @_widths = () ->
            @_regions.map (reg) ->
                reg.widthNum()
                
        @findRegions = () =>
            @row.find('.mercury-region').each (i,e) =>
                @_regions.push(new Oxygen.RegionWrapper(e, @))
        
        @findRegions()
        
        @findById = (id) ->
            @_regions.filter (r) ->
                r.id == id
                
        @findByPosition = (pos) ->
            @_regions.filter (r) ->
                r.position() == pos
        
        @balanceWidths = () ->
            cols = @_regions.length
            newWidth = parseInt(12 / cols)
            region.changeWidth(newWidth) for region in @_regions
            if @_controls.length > 0
                ctrl.updateWidthVal() for ctrl in @_controls
            
        @currentTemplate = () =>
            widths = @_regions.map (reg) -> reg.widthNum()
        
        @applyTemplate = (template) ->
            if @_regions.length == template.length
                @_regions.map (reg, i) ->
                    reg.changeWidth(template[i])
            else if @_regions.legnth < template.length
                # add a region
                return false
            else
                # confirm region delete
                return false
                
                
        @currentPositions = () =>
            @_regions.map (reg,i) ->
                { id: reg.id, position: reg.position() }
                
        @prepRegion = (newReg) =>
            # newReg.attr('data-mercury', 'full')
            # newReg.attr('data-position', @_regions.length + 1)
            # newReg.attr('data-mercury', 'full')
            # newReg.attr('data-width', 'two')
            # newReg.attr('data-mercury', 'full')
            newReg.attr({
                id: 'new_region_' + (@_regions.length + 1),
                class: 'mercury-region',
                'data-mercury': 'full',
                'data-position': @_regions.length + 1,
                'data-width': 'two'
                'data-label': 'new_region_' + (@_regions.length + 1)
                })
                
        @addRegion = () =>
            # clone template
            column = Oxygen.regionTemplate.clone()
            newReg = @prepRegion( column.find('div') )
            column.insertAfter( @_regions[@_regions.length-1].region.parent() )
            column.removeAttr('id')
            column.show()
            mercuryInstance.buildRegion(newReg)
            newWrapper = new Oxygen.RegionWrapper(newReg)
            @_regions.push(newWrapper)
            @balanceWidths()
            return newWrapper
            
        @deleteRegion = (num) ->
            goAhead = window.confirm("Are you sure you want to delete this region?")
            if(goAhead)
                @_regions[num].destroy()
                @_regions.splice(num, 1)
                @balanceWidths()
                Mercury.changes = true
            else
                return false
                
        @unregisterRegion = (id) =>
            @_regions.map (r,i) =>
                if r.id == id
                    @_regions.splice(i, 1)
                
        @moveRegionToLeft = (num) =>
            @_regions[num].column.prependTo(@row)
            
        @reorderRegions = (order) =>
            order.reverse().map (n) => @moveRegionToLeft(n)
            newRegionOrder = order.reverse().map (n) => @_regions[n]
            @_regions = newRegionOrder
            @_regions.map (r,i) -> r.changePosition(i)
            
        @registerAddRegionButton = (button, controlTemplate, form) =>
            button.on 'click', (event) =>
                newRegion = @addRegion()
                Oxygen.controls ||= []
                Oxygen.controls.push(new Oxygen.RegionControlGroup(newRegion, controlTemplate, form))
                event.preventDefault()
                


class Oxygen.RegionWrapper
    constructor: (region_selector, row) ->
        @id = Oxygen.buildId()
        @region = $(region_selector)
        @row = row
        @dataWidth = () ->
            @region.data('width')
        @widthNum = () ->
            @classNames.indexOf(@dataWidth())
        @position = () ->
            @region.data('position')
        @label = @region.data('label')
        @uiLabel = $("<div class=\"region-label\">#{@label}</div>")
        @classNames = [
            'zero','one', 'two', 
            'three','four', 'five', 
            'six','seven', 'eight', 
            'nine','ten', 'eleven', 'twelve'
            ]
        @column = @region.parent()
        
        @labelize = () ->
            @uiLabel.insertBefore(@region)
            
        @labelize()
        
        # @controls = new Oxygen.RegionControlGroup(@)
        
        @changeWidth = (newWidth) ->
            @region.changeData('width', @classNames[newWidth])
            @column.replaceClasses([ @region.data('label'), @classNames[newWidth], 'columns' ])
            # @updateWidthControl()
        
        @changePosition = (newPos) ->
            @region.changeData('position', newPos)
            
        @changeLabel = (newLabel) ->
            @region.changeData('label', newLabel)
            @uiLabel.text(newLabel)
            @column.replaceClasses([newLabel, @dataWidth(), 'columns'])
            
        @shiftUp = () ->
            @changePosition(@position - 1)
            @column.insertBefore(@column.prev())
            
        @shiftDown = () ->
            @changePosition(@position + 1)
            @column.insertAfter(@column.next())
            
        @moveBefore = (otherRegion) ->
            @column.insertBefore(otherRegion.region.parent())
            
        @destroy = () ->
            @region.attr('data-destroy', 'true')
            @column.hide()
            @row.unregisterRegion(@id)


class Oxygen.RegionControlGroup
    constructor: (region_wrapper, controlTemplate, form) ->
        @id = Oxygen.buildId()
        @region = region_wrapper
        @group = controlTemplate.clone().replaceClasses(['region_controls'])
        @form = form
        
        @label = @group.find('.label_control')
        @width = @group.find('.width_control')
        @position = @group.find('.position_control')
        @deleteButton = @group.find('.delete_region')
        
        @configLabelControl = () =>
            @label.val(@region.label)
            @label.on 'blur', ->
                _this.region.changeLabel($(@).val())
        
        @configWidthControl = () =>
            @width.val(@region.widthNum())
            @width.on 'change', ->
                _this.region.changeWidth($(@).val())
                
        @configPositionControl = () =>
            @position.val(@region.position())
            @position.on 'change', ->
                _this.region.changePosition($(@).val())
                
        @configDeleteControl = () ->
            @deleteButton.on 'click', (event) =>
                event.preventDefault()
                @region.destroy()
                @group.slideUp()
                
        @updateWidthVal = () ->
            @width.val(@region.widthNum())
        
        @configControls = () =>
            @configLabelControl()
            @configWidthControl()
            @configPositionControl()
            @configDeleteControl()
        
        @configControls()
        @group.appendTo(@form).show()
            


Mercury.on 'ready', ->
    Oxygen.iframe = $('#mercury_iframe').contents()
    Oxygen.regionTemplate = Oxygen.iframe.find('#region_template')
    Oxygen.regionRows = Oxygen.iframe.find('.regions.row').map (i,r) ->
        new Oxygen.RegionRow($(r))
    
