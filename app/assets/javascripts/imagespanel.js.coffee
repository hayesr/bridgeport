@Mercury.dialogHandlers.imagesPanel = ->
  # make the filter work
  @element.find('input.filter').on 'keyup', =>
    value = @element.find('input.filter').val()
    for image in @element.find('li[data-filter]')
      if LiquidMetal.score(jQuery(image).data('filter'), value) == 0 then jQuery(image).hide() else jQuery(image).show()

  # when an element is dragged, set it so we have a global object
  @element.find('img[data-snippet]').on 'click', ->
    Mercury.trigger('action', { action: 'insertImage', value: {src: @src} })
