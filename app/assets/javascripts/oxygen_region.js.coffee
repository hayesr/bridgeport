window.Oxygen ||= {}

# Oxygen RegionRow
# Keeps a regions array
# balances region widths
# repositions
# creates region controls
class Oxygen.RegionRow
    constructor: (row) ->
        @row = row
        @_regions = []
        @findRegions = () =>
            @row.find('.mercury-region').each (i,e) =>
                @_regions.push(new Oxygen.RegionWrapper(e))
        
        @findRegions()
        
        @balanceWidths = () ->
            cols = @_regions.length
            newWidth = parseInt(12 / cols)
            region.changeWidth(newWidth) for region in @_regions
            
        @currentTemplate = () =>
            widths = @_regions.map (reg) -> reg.widthNum()
        
        @applyTemplate = (template) ->
            if @_regions.length == template.length
                @_regions.map (reg, i) ->
                    reg.changeWidth(template[i])
            else
                # find the difference
                
                # create regions for extra
                
        @addRegion = () =>
            # clone template
            column = Oxygen.regionTemplate.clone()
            newReg = column.find('.new-region')
            newReg.replaceClasses(['mercury-region'])
            column.insertAfter( @_regions[@_regions.length-1].region.parent() )
            column.removeAttr('id')
            newReg.removeAttr('id')
            column.show()
            mercuryInstance.buildRegion(newReg)
            @_regions.push(new Oxygen.RegionWrapper(newReg))
            @balanceWidths()
            
        @deleteRegion = (num) ->
            goAhead = window.confirm("Are you sure you want to delete this region?")
            if(goAhead)
                @_regions[num].destroy()
                @_regions.splice(num, 1)
                @balanceWidths()
                Mercury.changes = true
            else
                return false
                
        @moveRegionToLeft = (num) =>
            @_regions[num].column.prependTo(@row)
            
        
        @reorderRegions = (order) =>
            order.reverse().map (n) => @moveRegionToLeft(n)
            newRegionOrder = order.reverse().map (n) => @_regions[n]
            @_regions = newRegionOrder
            @_regions.map (r,i) -> r.changePosition(i)

# Xregion = (region) ->
class Oxygen.RegionWrapper
    constructor: (region_selector) ->
        @region = $(region_selector)
        @dataWidth = () ->
            @region.data('width')
        @widthNum = () ->
            @classNames.indexOf(@dataWidth())
        @position = @region.data('position')
        @label = @region.data('label')
        @classNames = [
            'zero','one', 'two', 
            'three','four', 'five', 
            'six','seven', 'eight', 
            'nine','ten', 'eleven', 'twelve'
            ]
        @column = @region.parent()
        
        @labelize = () ->
            $("<div class=\"region-label\">#{@label}</div>").insertBefore(@region)
            
        @labelize()
        
        @changeWidth = (newWidth) ->
            @region.changeData('width', @classNames[newWidth])
            @column.replaceClasses([ @region.data('label'), @classNames[newWidth], 'columns' ])
        
        @changePosition = (newPos) ->
            @region.changeData('position', newPos)
            
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

# window.regions = []

Mercury.on 'ready', ->
    Oxygen.iframe = $('#mercury_iframe').contents()
    Oxygen.regionTemplate = Oxygen.iframe.find('#region_template')
    window.oxygen_row = new Oxygen.RegionRow($("#mercury_iframe").contents().find('#regions'))
    # $("#mercury_iframe").contents().find('#regions .mercury-region').each (i,e) ->
    #     regions.push(new Oxygen.RegionWrapper(e))