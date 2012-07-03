@Mercury.dialogHandlers.regionsPanel = ->
    @form = @element.find('form')
    @controlTemplate = @element.find('.region_controls_template')
    @addButton = @element.find('#add_region button')
    
    Oxygen.regionRows[0]._controls = Oxygen.regionRows[0]._regions.map (r,i) =>
        new Oxygen.RegionControlGroup(r, @controlTemplate, @form)
    
    Oxygen.regionRows[0].registerAddRegionButton(@addButton, @controlTemplate, @form)
    # console.log(@form)
    # console.log(@controlTemplate)