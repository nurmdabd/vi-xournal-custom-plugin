-- require "modes"
require "api"

ALL_MODES = {
  "tool",
  "color",
  "shape",
  "linestyle",
  "page",
  "file",
  "moreTool",
  "navigation",
  "visual",
  "resize"
}
--------------------
-- KEYBINDINGS:   --
--------------------
keybindings = {

  --------------------------------------------------------
  --Tools
  pen = {
    description = "Pen",
    buttons     = {"w"},
    modes       = {"tool"},
    call        = function() clickPen() ; cleanShape() end
  },
  eraser = {
    description = "Eraser",
    buttons     = {"e"},
    modes       = {"tool"},
    call        = function() clickEraser() ; cleanShape() end
  },
  highlighter = {
    description = "Highlighter",
    buttons     = {"g"},
    modes       = {"tool"},
    call        = function() clickHighlighter() ; cleanShape() end
  },
  text = {
    description = "Text",
    buttons     = {"x"},
    modes       = {"tool"},
    call        = clickText
  },
  textFont = {
    description = "Text font",
    buttons     = {"<Ctrl>grave"},
    modes       = {"tool"},
    call        = clickTextFont
  },
  image = {
    description = "Image",
    buttons     = {"i"},
    modes       = {"tool"},
    call        = clickImage
  },
  hand = {
    description = "Hand",
    buttons     = {"u"},
    modes       = {"tool"},
    call        = clickHand
  },
  newAfterTool = {
    description = "New page after",
    buttons     = {"a"},
    modes       = {"tool"},
    call        = clickNewAfter
  },
  defaultTool = {
    description = "Default tool",
    buttons     = {"d"},
    modes       = {"tool"},
    call        = clickDefaultTool
  },
  undo = {
    description = "Undo",
    buttons     = {"z"},
    modes       = {"tool"},
    call        = clickUndo,
  },
  redo = {
    description = "Redo",
    buttons     = {"y"},
    modes       = {"tool"},
    call        = clickRedo,
  },
  zoomIn = {
    description = "Zoom in",
    buttons     = {"greater", "<Shift>greater", "plus", "<Shift>plus"},
    modes       = {"tool"},
    call        = clickZoomIn
  },
  zoomOut = {
    description = "Zoom out",
    buttons     = {"minus", "less"},
    modes       = {"tool"},
    call        = clickZoomOut
  },
  zoomToFit = {
    description = "Zoom to fit",
    buttons     = {"o"},
    modes       = {"tool"},
    call        = clickZoomToFit
  },
  setsquareTool = {
    description = "Setsquare",
    buttons     = {"<Shift>e"},
    modes       = {"tool"},
    call        = clickSetsquare
  },
  compassTool = {
    description = "Compass",
    buttons     = {"<Shift>o"},
    modes       = {"tool"},
    call        = clickCompass
  },

  --------------------------------------------------------
  -- Mode Selection
  -- these only declare the mode they enter (and whether it is sticky);
  -- their `call` is generated below the table
  tool = {
    description = "Tool mode",
    buttons     = {"t"},
    modes       = ALL_MODES,
    enters      = "tool"
  },
  color = {
    description = "Color mode",
    buttons     = {"c"},
    modes       = {"tool"},
    enters      = "color"
  },
  stickyColor = {
    description = "Sticky color mode",
    buttons     = {"<Shift>c"},
    modes       = {"tool"},
    enters      = "color",
    sticky      = true
  },
  file = {
    description = "File mode",
    buttons     = {"f"},
    modes       = {"tool"},
    enters      = "file"
  },
  stickyFile = {
    description = "Sticky file mode",
    buttons     = {"<Shift>f"},
    modes       = {"tool"},
    enters      = "file",
    sticky      = true
  },
  linestyle = {
    description = "Linestyle mode",
    buttons     = {"q"},
    modes       = {"tool"},
    enters      = "linestyle"
  },
  stickyLinestyle = {
    description = "Sticky linestyle mode",
    buttons     = {"<Shift>q"},
    modes       = {"tool"},
    enters      = "linestyle",
    sticky      = true
  },
  moreTool = {
    description = "More tool mode",
    buttons     = {"m"},
    modes       = {"tool"},
    enters      = "moreTool"
  },
  stickyMoreTool = {
    description = "Sticky more tool mode",
    buttons     = {"<Shift>m"},
    modes       = {"tool"},
    enters      = "moreTool",
    sticky      = true
  },
  navigation = {
    description = "Navigation mode",
    buttons     = {"n"},
    modes       = {"tool"},
    enters      = "navigation"
  },
  stickyNavigation = {
    description = "Sticky navigation mode",
    buttons     = {"<Shift>n"},
    modes       = {"tool"},
    enters      = "navigation",
    sticky      = true
  },
  page = {
    description = "Page mode",
    buttons     = {"p", "b"},
    modes       = {"tool"},
    enters      = "page"
  },
  stickyPage = {
    description = "Sticky page mode",
    buttons     = {"<Shift>p", "<Shift>b"},
    modes       = {"tool"},
    enters      = "page",
    sticky      = true
  },
  resize = {
    description = "Resize mode",
    buttons     = {"r"},
    modes       = {"tool"},
    enters      = "resize"
  },
  stickyResize = {
    description = "Sticky resize mode",
    buttons     = {"<Shift>r"},
    modes       = {"tool"},
    enters      = "resize",
    sticky      = true
  },
  shape = {
    description = "Shape mode",
    buttons     = {"s"},
    modes       = {"tool"},
    enters      = "shape"
  },
  stickyShape = {
    description = "Sticky shape mode",
    buttons     = {"<Shift>s"},
    modes       = {"tool"},
    enters      = "shape",
    sticky      = true
  },
  visual = {
    description = "Visual mode",
    buttons     = {"v"},
    modes       = {"tool"},
    enters      = "visual"
  },
  stickyVisual = {
    description = "Sticky visual mode",
    buttons     = {"<Shift>v"},
    modes       = {"tool"},
    enters      = "visual",
    sticky      = true
  },


  --------------------------------------------------------
  --Color Mode
  black = {
    description = "Black",
    buttons     = {"x"},
    modes       = {"color"},
    call        = function() changeToolColor(blackColor) end
  },
  white = {
    description = "White",
    buttons     = {"w"},
    modes       = {"color"},
    call        = function() changeToolColor(whiteColor) end
  },
  gray = {
    description = "Gray",
    buttons     = {"a", "<Shift>x"},
    modes       = {"color"},
    call        = function() changeToolColor(grayColor) end
  },
  lightGreen = {
    description = "Light green",
    buttons     = {"g"},
    modes       = {"color"},
    call        = function() changeToolColor(lightGreenColor) end
  },
  green = {
    description = "Green",
    buttons     = {"<Shift>g", "e"},
    modes       = {"color"},
    call        = function() changeToolColor(greenColor) end
  },
  lightBlue = {
    description = "Light blue",
    buttons     = {"b"},
    modes       = {"color"},
    call        = function() changeToolColor(lightBlueColor) end
  },
  blue = {
    description = "Blue",
    buttons     = {"<Shift>b", "u"},
    modes       = {"color"},
    call        = function() changeToolColor(blueColor) end
  },
  orange = {
    description = "Orange",
    buttons     = {"o", "c"},
    modes       = {"color"},
    call        = function() changeToolColor(orangeColor) end
  },
  red = {
    description = "Red",
    buttons     = {"r"},
    modes       = {"color"},
    call        = function() changeToolColor(redColor) end
  },
  yellow = {
    description = "Yellow",
    buttons     = {"y"},
    modes       = {"color"},
    call        = function() changeToolColor(yellowColor) end
  },
  purple = {
    description = "Purple",
    buttons     = {"p", "s"},
    modes       = {"color"},
    call        = function() changeToolColor(purpleColor) end
  },
  pink = {
    description = "Pink",
    buttons     = {"q", "i"},
    modes       = {"color"},
    call        = function() changeToolColor(pinkColor) end
  },
  magenta = {
    description = "Magenta",
    buttons     = {"m"},
    modes       = {"color"},
    call        = function() changeToolColor(magentaColor) end
  },
  brown = {
    description = "Brown",
    buttons     = {"n"},
    modes       = {"color"},
    call        = function() changeToolColor(brownColor) end
  },


  --------------------------------------------------------
  -- File Mode
  newFile = {
    description = "New file",
    buttons     = {"n"},
    modes       = {"file"},
    call        = clickNewFile
  },
  open = {
    description = "Open file",
    buttons     = {"o"},
    modes       = {"file"},
    call        = clickOpen
  },
  save = {
    description = "Save file",
    buttons     = {"s", "w"},
    modes       = {"file"},
    call        = clickSave
  },
  saveAs = {
    description = "Save file as",
    buttons     = {"<Shift>s", "<Shift>w"},
    modes       = {"file"},
    call        = clickSaveAs
  },
  annotatePDF = {
    description = "Annotate PDF",
    buttons     = {"a"},
    modes       = {"file"},
    call        = clickAnnotatePDF
  },
  exportAsPDF = {
    description = "Export as PDF",
    buttons     = {"e"},
    modes       = {"file"},
    call        = clickExportAsPDF
  },
  print = {
    description = "Print",
    buttons     = {"p"},
    modes       = {"file"},
    call        = clickPrint
  },
  quit = {
    description = "Quit",
    buttons     = {"q"},
    modes       = {"file"},
    call        = clickQuit
  },


  --------------------------------------------------------
  --Linestyle Mode
  plain = {
    description = "Plain",
    buttons     = {"a", "p"},
    modes       = {"linestyle"},
    call        = clickPlain
  },
  dashed = {
    description = "Dashed",
    buttons     = {"s"},
    modes       = {"linestyle"},
    call        = clickDashed
  },
  dotted = {
    description = "Dotted",
    buttons     = {"d"},
    modes       = {"linestyle"},
    call        = clickDotted
  },
  dashDotted = {
    description = "Dash-dotted",
    buttons     = {"f"},
    modes       = {"linestyle"},
    call        = clickDashDotted
  },


  --------------------------------------------------------
  --More Tool Mode
  setsquare = {
    description = "Setsquare",
    buttons     = {"s", "e"},
    modes       = {"moreTool"},
    call        = clickSetsquare
  },
  compass = {
    description = "Compass",
    buttons     = {"c"},
    modes       = {"moreTool"},
    call        = clickCompass
  },
  tex = {
    description = "LaTeX",
    buttons     = {"x"},
    modes       = {"moreTool"},
    call        = clickTex
  },


  --------------------------------------------------------
  --Navigation Mode
  goToTop = {
    description = "Go to top",
    buttons     = {"u"},
    modes       = {"navigation"},
    call        = clickGoToTop
  },
  goToBottom = {
    description = "Go to bottom",
    buttons     = {"d"},
    modes       = {"navigation"},
    call        = clickGoToBottom
  },
  goToFirstPage = {
    description = "Go to first page",
    buttons     = {"f"},
    modes       = {"navigation"},
    call        = function()
      lastPage = currentPage()
      clickGoToFirstPage()
    end
  },
  goToLastPage = {
    description = "Go to last page",
    buttons     = {"<Shift>f", "e"},
    modes       = {"navigation"},
    call        = function()
      lastPage = currentPage()
      clickGoToLastPage()
    end
  },
  previousPage = {
    description = "Scroll page up",
    buttons     = {"p", "w"},
    modes       = {"navigation"},
    call        = clickScrollPageUp
  },
  nextPage = {
    description = "Scroll page down",
    buttons     = {"n", "s"},
    modes       = {"navigation"},
    call        = clickScrollPageDown
  },
  previousAnnotatedPage = {
    description = "Previous annotated page",
    buttons     = {"<Shift>p"},
    modes       = {"navigation"},
    call        = clickPreviousAnnotatedPage
  },
  nextAnnotatedPage = {
    description = "Next annotated page",
    buttons     = {"<Shift>n"},
    modes       = {"navigation"},
    call        = clickNextAnnotatedPage
  },
  goBack = {
    description = "Go back to last visited page",
    buttons     = {"v"},
    modes       = {"navigation"},
    call        = function()
      local cur = currentPage()
      goToPage(lastPage)
      lastPage = cur
    end
  },
  layerUp = {
    description = "Layer up",
    buttons     = {"x"},
    modes       = {"navigation"},
    call        = clickLayerUp
  },
  layerDown = {
    description = "Layer down",
    buttons     = {"y"},
    modes       = {"navigation"},
    call        = clickLayerDown
  },


  --------------------------------------------------------
  --Page Mode
  newBefore = {
    description = "New page before",
    buttons     = {"<Shift>a"},
    modes       = {"page"},
    call        = clickNewBefore
  },
  newAfter = {
    description = "New page after",
    buttons     = {"a"},
    modes       = {"page"},
    call        = clickNewAfter
  },
  newPageAtEnd = {
    description = "New page at end",
    buttons     = {"e"},
    modes       = {"page"},
    call        = clickNewPageAtEnd
  },
  moveUp = {
    description = "Move page up",
    buttons     = {"u"},
    modes       = {"page"},
    call        = clickMoveUp
  },
  moveDown = {
    description = "Move page down",
    buttons     = {"d"},
    modes       = {"page"},
    call        = clickMoveDown
  },
  copyPage = {
    description = "Copy page",
    buttons     = {"c"},
    modes       = {"page"},
    call        = clickCopyPage,
  },
  duplicatePage = {
    description = "Duplicate page",
    buttons     = {"<Shift>c"},
    modes       = {"page"},
    call        = clickDuplicatePage
  },
  deletePage = {
    description = "Delete page",
    buttons     = {"x"},
    modes       = {"page"},
    call        = function ()
      confirm("Do you really want to delete this page?", "confirmDeletePage")
    end
  },
  newLayer = {
    description = "New layer",
    buttons     = {"y"},
    modes       = {"page"},
    call        = clickNewLayer
  },
  deleteLayer = {
    description = "Delete layer",
    buttons     = {"<Shift>y"},
    modes       = {"page"},
    call        = function ()
      confirm("Do you really want to delete this layer?", "confirmDeleteLayer")
    end
  },

  -- Backgrounds
  plainBG = {
    description = "Plain background",
    buttons     = {"p"},
    modes       = {"page"},
    call        = clickPlainBG
  },
  ruledBG = {
    description = "Ruled background",
    buttons     = {"r"},
    modes       = {"page"},
    call        = clickRuledBG
  },
  ruledWithVerticalLineBG = {
    description = "Ruled with vertical line background",
    buttons     = {"v"},
    modes       = {"page"},
    call        = clickRuledWithVerticalLineBG
  },
  dottedGraphBG = {
    description = "Dotted background",
    buttons     = {"o"},
    modes       = {"page"},
    call        = clickDottedGraphBG
  },
  isodottedGraphBG = {
    description = "Isometric dotted background",
    buttons     = {"<Shift>o"},
    modes       = {"page"},
    call        = clickIsometricDottedGraphBG
  },
  graphBG = {
    description = "Graph background",
    buttons     = {"g"},
    modes       = {"page"},
    call        = clickGraphBG
  },
  isoGraphBG = {
    description = "Isometric graph background",
    buttons     = {"<Shift>g"},
    modes       = {"page"},
    call        = clickIsometricGraphBG
  },
  stavesBG = {
    description = "Staves background",
    buttons     = {"s"},
    modes       = {"page"},
    call        = clickStavesBG
  },


  --------------------------------------------------------
  --Resize Mode (Thickness)
  veryFine = {
    description = "Very fine",
    buttons     = {"a"},
    modes       = {"resize"},
    call        = clickVeryFine,
  },
  fine = {
    description = "Fine",
    buttons     = {"s"},
    modes       = {"resize"},
    call        = clickFine,
  },
  medium = {
    description = "Medium",
    buttons     = {"d", "m", "r"},
    modes       = {"resize"},
    call        = clickMedium,
  },
  thick = {
    description = "Thick",
    buttons     = {"f", "<Shift>m", "<Shift>r", "<Shift>d"},
    modes       = {"resize"},
    call        = clickThick,
  },
  veryThick = {
    description = "Very thick",
    buttons     = {"g"},
    modes       = {"resize"},
    call        = clickVeryThick,
  },


  --------------------------------------------------------
  --Shape Mode
  arrow = {
    description = "Arrow",
    buttons     = {"a"},
    modes       = {"shape"},
    call        = clickArrow
  },
  coordinateSystem = {
    description = "Coordinate system",
    buttons     = {"c"},
    modes       = {"shape"},
    call        = clickCoordinateSystem
  },
  doubleArrow = {
    description = "Double arrow",
    buttons     = {"d"},
    modes       = {"shape"},
    call        = clickDoubleArrow
  },
  ellipse = {
    description = "Ellipse",
    buttons     = {"e"},
    modes       = {"shape"},
    call        = clickEllipse
  },
  fill = {
    description = "Fill",
    buttons     = {"f"},
    modes       = {"shape"},
    call        = clickFill
  },
  rectangle = {
    description = "Rectangle",
    buttons     = {"r"},
    modes       = {"shape"},
    call        = clickRectangle
  },
  ruler = {
    description = "Ruler",
    buttons     = {"u", "s"},
    modes       = {"shape"},
    call        = clickRuler
  },
  shapeRecogniser = {
    description = "Shape recogniser",
    buttons     = {"g"},
    modes       = {"shape"},
    call        = clickShapeRecogniser
  },
  spline = {
    description = "Spline",
    buttons     = {"p", "q"},
    modes       = {"shape"},
    call        = clickSpline
  },


  --------------------------------------------------------
  --Visual Mode
  selectObject = {
    description = "Select object",
    buttons     = {"o", "a"},
    modes       = {"visual"},
    call        = clickSelectObject
  },
  selectRectangle = {
    description = "Select rectangle",
    buttons     = {"r", "v"},
    modes       = {"visual"},
    call        = clickSelectRectangle
  },
  selectMultilayerRectangle = {
    description = "Select multilayer rectangle",
    buttons     = {"<Shift>r", "<Shift>v"},
    modes       = {"visual"},
    call        = clickSelectMultilayerRectangle
  },
  lasso = {
    description = "Select region",
    buttons     = {"e"},
    modes       = {"visual"},
    call        = clickSelectRegion
  },
  selectMultilayerRegion = {
    description = "Select multilayer region",
    buttons     = {"<Shift>e"},
    modes       = {"visual"},
    call        = clickSelectMultilayerRegion
  },
  verticalSpace = {
    description = "Vertical space",
    buttons     = {"s"},
    modes       = {"visual"},
    call        = clickVerticalSpace
  },
}

for _, binding in pairs(keybindings) do
  -- write modifiers the same way everywhere ("<shift>e" -> "<Shift>e"),
  -- otherwise the same key would be registered twice under different names
  for i, button in ipairs(binding.buttons) do
    binding.buttons[i] = button:gsub("<(%a+)>", function(m)
      return "<" .. m:sub(1, 1):upper() .. m:sub(2):lower() .. ">"
    end)
  end

  -- mode switching: generate the call of every binding with an `enters` field
  if binding.enters then
    binding.call = function()
      currentMode = binding.enters
      sticky = binding.sticky or false
    end
  end
end

-- helper functions
function cleanShape()
  clickRuler(false)
  clickArrow(false)
  clickDoubleArrow(false)
  clickRectangle(false)
  clickEllipse(false)
  clickCoordinateSystem(false)
  clickSpline(false)
  clickShapeRecogniser(false)
  clickFill(false)
  clickPlain()
end

-- asks a yes/no question and calls the global function named `callback`
-- with the pressed button (1 = Yes)
function confirm(message, callback)
  if app.openDialog then
    app.openDialog(message, {"Yes", "No"}, callback)
  else
    -- Xournal++ < 1.2 has no openDialog; msgbox is deprecated in newer versions
    _G[callback](app.msgbox(message, {[1] = "Yes", [2] = "No"}))
  end
end

function confirmDeletePage(button)
  if button == 1 then clickDeletePage() end
end

function confirmDeleteLayer(button)
  if button == 1 then clickDeleteLayer() end
end





-- GTK Keyboard Key Names
-- =======================

-- Alphanumeric Keys:
-- ------------------
-- a b c d e f g h i j k l m
-- n o p q r s t u v w x y z
-- 0 1 2 3 4 5 6 7 8 9

-- Symbol Keys:
-- ------------
-- `         → grave
-- ~         → asciitilde
-- !         → exclam
-- @         → at
-- #         → numbersign
-- $         → dollar
-- %         → percent
-- ^         → asciicircum
-- &         → ampersand
-- *         → asterisk
-- (         → parenleft
-- )         → parenright
-- -         → minus
-- _         → underscore
-- =         → equal
-- +         → plus
-- [         → bracketleft
-- ]         → bracketright
-- {         → braceleft
-- }         → braceright
-- ;         → semicolon
-- :         → colon
-- '         → apostrophe
-- "         → quotedbl
-- ,         → comma
-- .         → period
-- /         → slash
-- ?         → question
-- \         → backslash
-- |         → bar or brokenbar
-- (space)   → space

-- Navigation Keys:
-- ----------------
-- Up
-- Down
-- Left
-- Right
-- Home
-- End
-- Page_Up
-- Page_Down
-- Insert
-- Delete
-- BackSpace
-- Tab
-- Return
-- Escape

-- Modifier Keys:
-- --------------
-- Shift
-- Control
-- Alt (or Mod1)
-- Meta
-- Super
-- Caps_Lock
-- Num_Lock
-- Scroll_Lock

-- Function Keys:
-- --------------
-- F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12

-- Keypad (Numpad) Keys:
-- ---------------------
-- KP_0 KP_1 KP_2 KP_3 KP_4 KP_5 KP_6 KP_7 KP_8 KP_9
-- KP_Add
-- KP_Subtract
-- KP_Multiply
-- KP_Divide
-- KP_Enter
-- KP_Decimal

-- Example GTK Shortcut Notations:
-- -------------------------------
-- <Control>a
-- <Shift>grave
-- <Alt>F4
-- <Control><Shift>z
-- <Shift>asciitilde
