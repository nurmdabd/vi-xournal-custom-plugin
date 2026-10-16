# vi-xournalpp
This is a tiny plugin for [Xournal++](https://github.com/xournalpp/xournalpp),
version 1.1.x, 1.2.x and 1.3.x. On 1.3 it uses the new action API
(`app.activateAction` / `app.changeActionState`); on older versions it
falls back to the deprecated `app.uiAction` / `app.sidebarAction`.

# Installation
To set the plugin up on Linux, run

```bash
cd ~/.config/xournalpp/plugins
git clone https://github.com/lryffel/vi-xournalpp
```

In Xournal++, activate the plugin using the _Plugin Manager_
in the menu bar under _Plugin_.

vi-xournalpp is inspired by the modal editing popularized
by the text editor vi.
The two basic principles of the default keybindings of vi-xournalpp are

- They should be easy to remember mnemonically,
- They should be accessible by the left hand on a QWERTY/QWERTZ/AZERTY keyboard.

The second principle is broken for certain colors (e.g. `o`range).

# Usage
vi-xournalpp is centered around so-called modes. They give access to different
sets of keybindings. This makes it possible for way more commands to be easily
accessible from a limited region on the keyboard.
Keybindings sorted by modes can be found in [keybindings.md](keybindings.md).

You can modify keybindings by editing [keybindings.lua](keybindings.lua) in your plugin
folder. Then regenerate the markdown file by running `lua documentation.lua`
in the plugin folder.

## Tool Mode
The default mode is **tool** mode.
Tool mode is used for switching between the different tools, modes,
and history operations. Available tools are _pen_, _eraser_, _highlighter_,
_text_, _image_, _hand_, _default tool_, _setsquare_, _compass_, plus
_text font_ (dialog, or `Ctrl+[` / `Ctrl+]` for a smaller / bigger size),
_new page after_, _zoom in/out/to fit_.
Available modes are **color**, **shape**, **linestyle**, **page**, **file**,
**more tool**, **navigation**, **visual**, **resize**.
Pressing any key in any mode other than _tool_ automatically
returns the user to tool mode, unless the mode was made "sticky"
by pressing `<Shift>`. E.g., to enter _sticky color mode_, press
`<Shift>c`. A key that has no meaning in the current mode
leaves the mode and does what it does in tool mode instead
(e.g. `c` `s` leaves color mode and enters shape mode).
A one-shot mode is also left automatically when no key is pressed
for more than 5 seconds (`MODE_TIMEOUT` in `modes.lua`).
Available history operations are _undo_, _redo_.

## Color Mode
The **color** mode is used to switch between the different colors,
_black_, _white_, _gray_, _light green_, _green_, _light blue_, _blue_,
_orange_, _red_, _yellow_, _purple_, _pink_, _magenta_, _brown_.

While typing in a text box, letters are typed into the text, so color mode
cannot be used. Use **Alt** + the color mode letter instead (`Alt+r` red,
`Alt+b` light blue, ...). Exceptions: green is `Alt+Shift+g` and brown is
`Alt+d`, because Alt + e, n (and f, v, j, t, p, h) open the menus.
This changes the color of the whole text box. While typing, Xournal++ itself
also offers `Ctrl+B` (bold) and `Ctrl++` / `Ctrl+-` (font size).

## Shape mode
The **shape** mode is used to select the different shapes, _ruler_,
_arrow_, _double arrow_, _rectangle_, _ellipse_, _coordinate system_,
_spline_, _shape recogniser_, and _fill_.

## Linestyle mode
The **linestyle** mode switches between the different kinds of linestyles,
namely _plain_, _dashed_, _dotted_, _dash-dotted_.

## Page mode
The **page** mode can manipulate pages and layers.
Available actions are _copy_, _delete_, _moveUp_, _moveDown_,
_newBefore_, _newAfter_, _newAtEnd_, _newLayer_, _deleteLayer_, and changing
the page background (_plain_, _ruled_, _ruled with vertical line_, _dotted_,
_isometric dotted_, _graph_, _isometric graph_, _staves_).
The somewhat ambiguously named _moveUp_ and _moveDown_
actually move the page around in the document
and are not to be confused with the scrolling commands.

## File mode
The **file** mode can open and write files.
Available actions are _new_, _open_, _save_, _saveAs_, _annotatePDF_,
_exportAsPDF_, _print_, _quit_.

## More tool mode
The **more tool** mode holds the less frequently used tools,
_setsquare_, _compass_, and _LaTeX_.

## Navigation mode
The **navigation** mode is responsible for scrolling.
Available actions are
_goToFirstPage_, _goToLastPage_, _goToTop_, _goToBottom_,
_scrollPageDown_, _scrollPageUp_, _previous/next annotated page_,
_goBack_ (to the last visited page), _layerUp_, _layerDown_.

## Visual mode
The **visual** mode switches between the selection tools,
_select region_ (lasso), _select rectangle_, _select object_,
their _multilayer_ variants, and _vertical space_.

## Resize mode
The **resize** mode can be used to change thicknesses.
Available thicknesses are
_very fine_, _fine_, _medium_, _thick_, _very thick_,
accessed by `a`, `s`, `d`, `f`, `g`, respectively.
Enter it with `r`, or `<Shift>r` for sticky resize mode.

## Debugging
Set `DEBUG = true` in `modes.lua` to log every key press to
`debug_output.log` in the plugin folder.

# Configuration
## Keybindings
Keybindings are defined in the file `keybindings.lua`.
One keybinding looks something like this:

```
pen = {
  description = "Pen",
  buttons     = {"w"},
  modes       = {"tool"},
  call        = clickPen
}
```

The `description` field is the menu
entry, and also what is logged into the terminal
if Xournal++ is started using the command `xournalpp`.
The characters in the `buttons` list are
the accelerators of the keybinding.
Modes present in the `modes` list listen
for the accelerators.
The function assigned `call` gets executed
when a valid accelerator is pressed
in a valid mode. In this case,
`clickPen` is a function
defined in `api.lua`.


## Colors
The colors can be changed in `colors.lua`.
They require RGB like so:
```lua
yellowColor = 0xe9f23a
```

# Extension
## New Modes
A mode `newMode` needs the following

1. An entry `"newMode"` in the `ALL_MODES` list in `keybindings.lua`,
2. A keybinding with `enters = "newMode"` in the `keybindings` list
   (add `sticky = true` for a sticky variant), e.g.

```lua
newMode = {
  description = "New mode",
  buttons     = {"m"},
  modes       = {"tool"},
  enters      = "newMode"
},
```

## New Keybindings
vi-xournalpp currently does not cover the full API. To add another entry,
follow the following steps.

1. Make a function in `api.lua` wrapping the API call. Prefer the helpers
   at the top of `api.lua` (`activate`, `toggle`, `selectTool`, ...), which
   pick the right API for the running Xournal++ version.
2. Create a new keybinding for it in `keybindings.lua`.

If the entry is a color, also update `colors.lua` accordingly.
