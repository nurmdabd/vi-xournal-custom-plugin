-- require "modes"
require "api"

ALL_MODES = {
  "tool",
  "color",
  "shape",
  "linestyle",
  "page",
  "file",
  "navigation",
  "visual",
  "resize"
}
--------------------
-- KEYBINDINGS:   --
--------------------
keybindings = {
  -- Tools
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
    buttons     = {"h"},
    modes       = {"tool"},
    call        = function() clickHighlighter() ; cleanShape() end
  },
  hand = {
    description = "Hand",
    buttons     = {"space"},
    modes       = {"tool"},
    call        = clickHand
  },
  selection = {
    description = "Selection",
    buttons     = {"k"},
    modes       = {"tool"},
    call        = clickSelectRegion
  },
  tex = {
    description = "LaTeX",
    buttons     = {"i"},
    modes       = {"tool"},
    call        = clickTex
  },
  text = {
    description = "Text",
    buttons     = {"<Shift>t", "<Shift>i"},
    modes       = {"tool"},
    call        = clickText
  },
  delete = {
    description = "Delete",
    buttons     = {"x"},
    modes       = {"tool"},
    call        = clickDelete
  },

  -- History
  undo = {
    description = "Undo",
    buttons     = {"d", "u", "z"},
    modes       = {"tool"},
    call        = clickUndo,
  },
  redo = {
    description = "Redo",
    buttons     = {"y"},
    modes       = {"tool"},
    call        = clickRedo,
  },

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
  linestyle = {
    description = "Linestyle mode",
    buttons     = {"l", "q"},
    modes       = {"tool"},
    enters      = "linestyle"
  },
  stickyLinestyle = {
    description = "Sticky linestyle mode",
    buttons     = {"<Shift>l"},
    modes       = {"tool"},
    enters      = "linestyle",
    sticky      = true
  },
  page = {
    description = "Page mode",
    buttons     = {"b", "p"},
    modes       = {"tool"},
    enters      = "page"
  },
  stickyPage = {
    description = "Sticky page mode",
    buttons     = {"<Shift>b", "<Shift>p"},
    modes       = {"tool"},
    enters      = "page",
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

  -- Various tool mode commands
  newAfterTool = {
    description = "New page after",
    buttons     = {"a"},
    modes       = {"tool"},
    call        = clickNewAfter
  },
  annotatePDFTool = {
    description = "Annotate PDF",
    buttons     = {"o"},
    modes       = {"tool"},
    call        = clickAnnotatePDF
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

  -- Thickness
  veryFine = {
    description = "Very fine",
    buttons     = {"e"},
    modes       = {"resize"},
    call        = clickVeryFine,
  },
  fine = {
    description = "Fine",
    buttons     = {"f"},
    modes       = {"resize"},
    call        = clickFine,
  },
  medium = {
    description = "Medium",
    buttons     = {"m", "r"},
    modes       = {"resize"},
    call        = clickMedium,
  },
  thick = {
    description = "Thick",
    buttons     = {"h"},
    modes       = {"resize"},
    call        = clickThick,
  },
  veryThick = {
    description = "Very thick",
    buttons     = {"v"},
    modes       = {"resize"},
    call        = clickVeryThick,
  },
  -- Colors
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
  pink = {
    description = "Pink",
    buttons     = {"q"},
    modes       = {"color"},
    call        = function() changeToolColor(pinkColor) end
  },
  red = {
    description = "Red",
    buttons     = {"r"},
    modes       = {"color"},
    call        = function() changeToolColor(redColor) end
  },
  orange = {
    description = "Orange",
    buttons     = {"o"},
    modes       = {"color"},
    call        = function() changeToolColor(orangeColor) end
  },
  yellow = {
    description = "Yellow",
    buttons     = {"y"},
    modes       = {"color"},
    call        = function() changeToolColor(yellowColor) end
  },
  green = {
    description = "Green",
    buttons     = {"g"},
    modes       = {"color"},
    call        = function() changeToolColor(greenColor) end
  },
  cyan = {
    description = "Cyan",
    buttons     = {"c"},
    modes       = {"color"},
    call        = function() changeToolColor(cyanColor) end
  },
  blue = {
    description = "Blue",
    buttons     = {"b"},
    modes       = {"color"},
    call        = function() changeToolColor(blueColor) end
  },
  purple = {
    description = "Purple",
    buttons     = {"p", "a"},
    modes       = {"color"},
    call        = function() changeToolColor(purpleColor) end
  },

  -- Shapes
  ruler = {
    description = "Ruler",
    buttons     = {"s"},
    modes       = {"shape"},
    call        = clickRuler
  },
  arrow = {
    description = "Arrow",
    buttons     = {"a"},
    modes       = {"shape"},
    call        = clickArrow
  },
  rectangle = {
    description = "Rectangle",
    buttons     = {"r", "c"},
    modes       = {"shape"},
    call        = clickRectangle
  },
  ellipse = {
    description = "Ellipse",
    buttons     = {"e"},
    modes       = {"shape"},
    call        = clickEllipse
  },
  spline = {
    description = "Spline",
    buttons     = {"b"},
    modes       = {"shape"},
    call        = clickSpline
  },
  fill = {
    description = "Fill",
    buttons     = {"f"},
    modes       = {"shape"},
    call        = clickFill
  },
  -- Linestyles
  plain = {
    description = "Plain",
    buttons     = {"l", "p"},
    modes       = {"linestyle"},
    call        = clickPlain
  },
  dashed = {
    description = "Dashed",
    buttons     = {"d"},
    modes       = {"linestyle"},
    call        = clickDashed
  },
  dotted = {
    description = "Dotted",
    buttons     = {"o"},
    modes       = {"linestyle"},
    call        = clickDotted
  },
  dashDotted = {
    description = "Dash-dotted",
    buttons     = {"a", "h"},
    modes       = {"linestyle"},
    call        = clickDashDotted
  },

  -- Page
  copyPage = {
    description = "Copy page",
    buttons     = {"c"},
    modes       = {"page"},
    call        = clickCopyPage,
  },
  deletePage = {
    description = "Delete page",
    buttons     = {"d"},
    modes       = {"page"},
    call        = function ()
      confirm("Do you really want to delete this page?", "confirmDeletePage")
    end
  },
  moveUp = {
    description = "Move page up",
    buttons     = {"w"},
    modes       = {"page"},
    call        = clickMoveUp
  },
  moveDown = {
    description = "Move page down",
    buttons     = {"s"},
    modes       = {"page"},
    call        = clickMoveDown
  },
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
  deleteLayer = {
    description = "Delete layer",
    buttons     = {"x"},
    modes       = {"page"},
    call        = function ()
      confirm("Do you really want to delete this layer?", "confirmDeleteLayer")
    end
  },
  newLayer = {
    description = "New layer",
    buttons     = {"y"},
    modes       = {"page"},
    call        = clickNewLayer
  },
  ruledBG = {
    description = "Ruled background",
    buttons     = {"f"},
    modes       = {"page"},
    call        = clickRuledBG
  },
  graphBG = {
    description = "Graph background",
    buttons     = {"g"},
    modes       = {"page"},
    call        = clickGraphBG
  },
  isoGraphBG = {
    description = "Isometric graph background",
    buttons     = {"r"},
    modes       = {"page"},
    call        = clickIsometricGraphBG
  },
  dottedGraphBG = {
    description = "Dotted background",
    buttons     = {"v"},
    modes       = {"page"},
    call        = clickDottedGraphBG
  },
  isodottedGraphBG = {
    description = "Isometric dotted background",
    buttons     = {"b"},
    modes       = {"page"},
    call        = clickIsometricDottedGraphBG
  },
  plainBG = {
    description = "Plain background",
    buttons     = {"n"},
    modes       = {"page"},
    call        = clickPlainBG
  },

  -- Navigation
  goToLastPage = {
    description = "Go to last page",
    buttons     = {"<Shift>g", "e"},
    modes       = {"navigation"},
    call        = function()
      lastPage = currentPage()
      clickGoToLastPage()
    end
  },
  goToFirstPage = {
    description = "Go to first page",
    buttons     = {"g"},
    modes       = {"navigation"},
    call        = function()
      lastPage = currentPage()
      clickGoToFirstPage()
    end
  },
  goToTop = {
    description = "Go to top",
    buttons     = {"<Shift>b"},
    modes       = {"navigation"},
    call        = clickGoToTop
  },
  goToBottom = {
    description = "Go to bottom",
    buttons     = {"b"},
    modes       = {"navigation"},
    call        = clickGoToBottom
  },
  scrollPageDown = {
    description = "Scroll page down",
    buttons     = {"s"},
    modes       = {"navigation"},
    call        = clickScrollPageDown
  },
  scrollPageUp = {
    description = "Scroll page up",
    buttons     = {"w"},
    modes       = {"navigation"},
    call        = clickScrollPageUp
  },
  goBack = {
    description = "Go back to last visited page",
    buttons     = {"a"},
    modes       = {"navigation"},
    call        = function()
      local cur = currentPage()
      goToPage(lastPage)
      lastPage = cur
    end
  },
  layerUp = {
    description = "Layer up",
    buttons     = {"y"},
    modes       = {"navigation"},
    call        = clickLayerUp
  },
  layerDown = {
    description = "Layer down",
    buttons     = {"x"},
    modes       = {"navigation"},
    call        = clickLayerDown
  },

  -- Files
  annotatePDF = {
    description = "Annotate PDF",
    buttons     = {"a", "o"},
    modes       = {"file"},
    call        = clickAnnotatePDF
  },
  exportAsPDF = {
    description = "Export as PDF",
    buttons     = {"e"},
    modes       = {"file"},
    call        = clickExportAsPDF
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
  open = {
    description = "Open file",
    buttons     = {"f"},
    modes       = {"file"},
    call        = clickOpen
  },

  -- Visual
  lasso = {
    description = "Select region",
    buttons     = {"e"},
    modes       = {"visual"},
    call        = clickSelectRegion
  },
  selectRectangle = {
    description = "Select rectangle",
    buttons     = {"v", "r"},
    modes       = {"visual"},
    call        = clickSelectRectangle
  },
  selectObject = {
    description = "Select object",
    buttons     = {"o"},
    modes       = {"visual"},
    call        = clickSelectObject
  }
}

-- mode switching: generate the call of every binding with an `enters` field
for _, binding in pairs(keybindings) do
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
  clickRectangle(false)
  clickEllipse(false)
  clickSpline(false)
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
