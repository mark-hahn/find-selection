# find-selection package for Atom Editor

Find the next or previous occurrence of the currently selected text with one keystroke. There is no need to bring up the file dialog.

The default key to find the next occurrence is Ctrl-F3 (find-selection:find-next) and to find the previous occurrence is Ctrl-Shift-F3 (find-selection:find-previous).  The searches are not case sensitive.

If nothing is selected or there is no next occurrence of the selected text then
nothing will happen.

These search functions work whether the find/replace dialog is open or not.  If the find/replace dialog has been open since the editor loaded then the search text is inserted into the find dialog (open or not) so the next F3 uses that text.

The functions are also available in the packages menu and in the editor context menu.


------

To-Do:
- Make F3 work whether the find dialog has been opened or not.
- Support case-sensitive searches.
- Add tests.
