{Range} = require 'atom'

describe 'find selection package', ->
  [activationPromise, editor, editorView] = []

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)

      activationPromise = atom.packages.activatePackage('find-selection')

  findCommand = (command, callback) ->
    atom.commands.dispatch(editorView, command)
    waitsForPromise -> activationPromise
    runs(callback)

  describe 'find-next command', ->
    describe 'when text is selected', ->
      it 'selects the next matching text', ->
        editor.setText 'Hello this is atom text editor!! Once again hello'
        editor.setCursorBufferPosition [0, 0]
        editor.selectToBufferPosition [0, 5]

        findCommand 'find-selection:find-next', ->
          expect(editor.getSelectedText()).toBe 'hello'

  describe 'find-previous command', ->
    describe 'when text is selected', ->
      it 'selects the previous matching text', ->
        editor.setText 'Hello this is atom text editor!! Once again hello'
        editor.setCursorBufferPosition [0, 44]
        editor.selectToBufferPosition [0, 49]

        findCommand 'find-selection:find-previous', ->
          expect(editor.getSelectedText()).toBe 'Hello'

  describe 'find-next-case-sensitive command', ->
    describe 'when text is selected', ->
      it 'selects the previous matching text', ->
        editor.setText 'Hello this is atom text editor!! Once again Hello'
        editor.setCursorBufferPosition [0, 0]
        editor.selectToBufferPosition [0, 5]

        findCommand 'find-selection:find-next-casesensitive', ->
          selectedBufferRange = editor.getSelectedBufferRanges()[0]
          expect(selectedBufferRange.isEqual([[0, 44], [0, 49]])).toBe true

  describe 'find-previous-case-sensitive command', ->
    describe 'when text is selected', ->
      it 'selects the previous matching text', ->
        editor.setText 'Hello this is atom text editor!! Once again Hello'
        editor.setCursorBufferPosition [0, 44]
        editor.selectToBufferPosition [0, 49]

        findCommand 'find-selection:find-previous-casesensitive', ->
          selectedBufferRange = editor.getSelectedBufferRanges()[0]
          expect(selectedBufferRange.isEqual([[0, 0], [0, 5]])).toBe true
