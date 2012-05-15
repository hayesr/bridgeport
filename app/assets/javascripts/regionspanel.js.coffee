@Mercury.dialogHandlers.regionsPanel = ->
  
    @element.find('p').hide()
    @select = @element.find('select')
    @form = @element.find('form')
    
    jQuery('#mercury_iframe').contents().find('.mercury-region[data-width]').each =>
        @select.clone().appendTo(@form)


