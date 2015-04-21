FindSelect = require '../lib/find-selection.coffee'

describe 'find selection package', ->
  [activationPromise, editor, editorView] = []

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()

    runs ->
      editor = atom.workspace.getActiveTextEditor()
      editorView = atom.views.getView(editor)

      activationPromise = atom.packages.activatePackage('find-selection')

  findNext = (callback) ->
    atom.commands.dispatch(editorView, 'find-selection:find-next')
    waitsForPromise -> activationPromise
    runs(callback)

  describe 'find next command', ->
    describe 'when text is selected', ->
      it 'selects the next matching text', ->
        editor.setText 'Hello this is atom text editor!! Once again hello'
        editor.setCursorBufferPosition [0, 0]
        editor.selectToBufferPosition [0, 5]

        findNext ->
          expect(editor.getSelectedText()).toBe 'hello'
