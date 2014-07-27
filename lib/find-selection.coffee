module.exports =
  activate: ->
    atom.workspaceView.command "find-selection:find-next",     => @find +1
    atom.workspaceView.command "find-selection:find-previous", => @find -1
    @selection = ''

  find: (dir) ->
    editor      = atom.workspace.activePaneItem
    buffer      = editor.getBuffer()
    origRange   = editor.getSelection().getBufferRange()
    selText     = editor.getSelectedText().replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&"
    noSel       = origRange.isEmpty()

    if (selText or= @selection) then @selection = selText
    if not selText then return

    origIdx = null
    matchArray = []
    buffer.scan new RegExp(selText, 'ig'), (res) ->
      if origIdx is null
          comp = res.range.compare origRange
          if comp > -1
            origIdx = matchArray.length
      matchArray.push res

    if matchArray.length is 0 then return
    origIdx ?= 0

    if noSel then selMatchIdx = origIdx
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
