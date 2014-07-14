module.exports =
  activate: ->
    atom.workspaceView.command "find-selection:find-next",     => @find +1
    atom.workspaceView.command "find-selection:find-previous", => @find -1

  find: (dir) ->
    editor      = atom.workspace.activePaneItem
    buffer      = editor.getBuffer()
    origRange   = editor.getSelection().getBufferRange()
    selText     = editor.getSelectedText().replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&"

    if not selText then return

    origIdx = null
    matchArray = []
    buffer.scan new RegExp(selText, 'ig'), (res) ->
      if res.range.isEqual origRange
        origIdx = matchArray.length
      matchArray.push res

    if matchArray.length < 2 or origIdx is null then return

    if dir > 0
      if origIdx is matchArray.length - 1 then selMatchIdx = 0
      else selMatchIdx = origIdx + 1
    else
      if origIdx is 0 then selMatchIdx = matchArray.length - 1
      else selMatchIdx = origIdx - 1

    editor.setSelectedBufferRanges [matchArray[selMatchIdx].range]
    
