jQuery ->
  $('ol.page-sorter').nestedSortable(
    disableNesting: 'no-nest',
    forcePlaceholderSize: true,
    handle: 'div',
    helper:	'clone',
    items: 'li',
    opacity: .6,
    revert: 250,
    tabSize: 25,
    tolerance: 'element',
    toleranceElement: 'div',
    update: ->
        $.post($(this).data('update-url'), $(this).sortable('serialize'))
        # console.log($(@).sortable('serialize'))
  )