
SubAtom = require 'sub-atom'

module.exports =
  activate: (@state) ->
    @subs = new SubAtom

    @subs.add atom.commands.add 'atom-text-editor', "find-selection:find-next",     => @find +1, 'ig'
    @subs.add atom.commands.add 'atom-text-editor', "find-selection:find-previous", => @find -1, 'ig'
    @subs.add atom.commands.add 'atom-text-editor', "find-selection:find-next-casesensitive", => @find +1, 'g'
    @subs.add atom.commands.add 'atom-text-editor', "find-selection:find-previous-casesensitive", => @find -1, 'g'

    @state ?= {}
    @state.selection = (@state.selection ?= '')

  find: (dir, casesensitive) ->
    editor      = atom.workspace.getActivePaneItem()
    buffer      = editor.getBuffer()
    origRange   = editor.getLastSelection().getBufferRange()
    selText     = editor.getSelectedText().replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&"
    noSel       = origRange.isEmpty()

    if (selText or= @state.selection) then @state.selection = selText
    if not selText then return

    origIdx = null
    matchArray = []
    buffer.scan new RegExp(selText, casesensitive), (res) ->
      if origIdx is null
        comp = res.range.compare origRange
        if comp > -1
          origIdx = matchArray.length
      matchArray.push res

    if matchArray.length is 0 then return
    origIdx ?= 0

    if noSel and dir < 0 then selMatchIdx = origIdx - 1
    if noSel and dir > 0 then selMatchIdx = origIdx
    else
      if dir > 0
        if origIdx is matchArray.length - 1 then selMatchIdx = 0
        else selMatchIdx = origIdx + 1
      else
        if origIdx is 0 then selMatchIdx = matchArray.length - 1
        else selMatchIdx = origIdx - 1

    newRange = matchArray[selMatchIdx].range
    editor.setCursorBufferPosition newRange.start, {autoscroll: yes}
    editor.setSelectedBufferRanges [newRange]

  serialize: -> @state

  deactivate: -> @subs.dispose()
