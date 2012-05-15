@Mercury.dialogHandlers.imagesPanel = ->
  # make the filter work
  @element.find('input.filter').on 'keyup', =>
    value = @element.find('input.filter').val()
    for image in @element.find('li[data-filter]')
      if LiquidMetal.score(jQuery(image).data('filter'), value) == 0 then jQuery(image).hide() else jQuery(image).show()

  # add image with click
  @element.find('img[data-snippet]').on 'click', ->
    Mercury.trigger('action', { action: 'insertImage', value: {src: @src.replace(/thumb_/i, '')} })
