# find-selection package

Find the next or previous occurrence of the currently selected text with one keystroke. There is no need to bring up the file dialog.

The default key to find the next occurrence is Ctrl-F3 (find-selection:find-next) and to find the previous occurrence is Ctrl-Shift-F3 (find-selection:find-previous).  The searches are not case sensitive.

If nothing is selected or there is no next occurrence of the selected text then
nothing will happen.

It will work when the find/replace dialog is showing but it doesn't change anything in the dialog.  It does not affect the value used by f3.

The functions are also available in the packages menu and in the editor context menu.

------

To-Do:
- Add tests.
- Support case-sensitive searches.
- Insert selection into find dialog so next F3 uses the same text.
