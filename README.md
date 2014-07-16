# find-selection package for Atom Editor

Find the next or previous occurrence of the currently selected text with one keystroke. There is no need to bring up the find/replace dialog.

The default key to find the next occurrence is Ctrl-F3 (find-selection:find-next) and to find the previous occurrence is Ctrl-Shift-F3 (find-selection:find-previous).  The searches are not case sensitive.

If nothing is selected or there is no next occurrence of the selected text then
nothing will happen.

These search functions work whether the find/replace dialog is open or not. The find-dialog is not affected.

The functions are also available in the packages menu and in the editor context menu.


------

To-Do:
- Support case-sensitive searches.
- Add tests.
