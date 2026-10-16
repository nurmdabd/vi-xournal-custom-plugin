-- Xournal++ 1.3 replaced app.uiAction / app.sidebarAction with
-- app.activateAction / app.changeActionState (the old ones are deprecated).
-- These helpers use the new API when it exists and fall back to the old one
-- on Xournal++ 1.1 / 1.2.

-- runs a one-shot action, e.g. "undo"
local function activate(action, oldAction)
  if app.activateAction then
    app.activateAction(action)
  else
    app.uiAction({["action"] = oldAction})
  end
end

-- turns an on/off action on (default) or off, e.g. "tool-draw-rectangle"
local function toggle(action, enabled, oldAction)
  if enabled == nil then enabled = true end
  if app.changeActionState then
    app.changeActionState(action, enabled)
  else
    app.uiAction({["action"] = oldAction, ["enabled"] = enabled})
  end
end

-- tool is the suffix of an app.C.Tool_* constant, e.g. "pen"
local function selectTool(tool, oldAction)
  if app.changeActionState then
    app.changeActionState("select-tool", app.C["Tool_" .. tool])
  else
    app.uiAction({["action"] = oldAction})
  end
end

-- size is the suffix of an app.C.ToolSize_* constant, e.g. "medium"
local function setSize(size, oldAction)
  if app.changeActionState then
    app.changeActionState("tool-size", app.C["ToolSize_" .. size])
  else
    app.uiAction({["action"] = oldAction})
  end
end

local function setLineStyle(style, oldAction)
  if app.changeActionState then
    app.changeActionState("tool-pen-line-style", style)
  else
    app.uiAction({["action"] = oldAction})
  end
end

-- the old sidebarAction acted on pages or layers depending on the open
-- sidebar tab; the new actions always act on pages
local function pageAction(action, oldSidebarAction)
  if app.activateAction then
    app.activateAction(action)
  else
    app.sidebarAction(oldSidebarAction)
  end
end

-- line width
function clickVeryFine()
  setSize("veryThin", "ACTION_SIZE_VERY_FINE")
end

function clickFine()
  setSize("thin", "ACTION_SIZE_FINE")
end

function clickMedium()
  setSize("medium", "ACTION_SIZE_MEDIUM")
end

function clickThick()
  setSize("thick", "ACTION_SIZE_THICK")
end

function clickVeryThick()
  setSize("veryThick", "ACTION_SIZE_VERY_THICK")
end

-- tools
function clickPen()
  selectTool("pen", "ACTION_TOOL_PEN")
end

function clickEraser()
  selectTool("eraser", "ACTION_TOOL_ERASER")
end

function clickHighlighter()
  selectTool("highlighter", "ACTION_TOOL_HIGHLIGHTER")
end

function clickSelectRegion()
  selectTool("selectRegion", "ACTION_TOOL_SELECT_REGION")
end

function clickSelectRectangle()
  selectTool("selectRect", "ACTION_TOOL_SELECT_RECT")
end

function clickSelectObject()
  selectTool("selectObject", "ACTION_TOOL_SELECT_OBJECT")
end

function clickTex()
  activate("tex", "ACTION_TEX")
end

function clickText()
  selectTool("text", "ACTION_TOOL_TEXT")
end

function clickHand()
  selectTool("hand", "ACTION_TOOL_HAND")
end

function clickDelete()
  activate("delete", "ACTION_DELETE")
end


-- shapes
function clickRuler(enabled)
  toggle("tool-draw-line", enabled, "ACTION_RULER")
end

function clickArrow(enabled)
  toggle("tool-draw-arrow", enabled, "ACTION_TOOL_DRAW_ARROW")
end

function clickEllipse(enabled)
  toggle("tool-draw-ellipse", enabled, "ACTION_TOOL_DRAW_ELLIPSE")
end

function clickRectangle(enabled)
  toggle("tool-draw-rectangle", enabled, "ACTION_TOOL_DRAW_RECT")
end

function clickSpline(enabled)
  toggle("tool-draw-spline", enabled, "ACTION_TOOL_DRAW_SPLINE")
end

function clickPlain()
  setLineStyle("plain", "ACTION_TOOL_LINE_STYLE_PLAIN")
end

function clickFill(enabled)
  toggle("tool-fill", enabled, "ACTION_TOOL_FILL")
end


-- linestyle
function clickDotted()
  setLineStyle("dot", "ACTION_TOOL_LINE_STYLE_DOT")
end

function clickDashed()
  setLineStyle("dash", "ACTION_TOOL_LINE_STYLE_DASH")
end

function clickDashDotted()
  setLineStyle("dashdot", "ACTION_TOOL_LINE_STYLE_DASH_DOT")
end

-- color
function changeToolColor(color)
  app.changeToolColor({["color"] = color, ["selection"] = true})

  -- change text tool color too, because (with the default template) the TEX tool also uses that color
  app.changeToolColor({["color"] = color, ["tool"] = "TEXT"})
end

-- zooming
function clickZoomIn()
  activate("zoom-in", "ACTION_ZOOM_IN")
end

function clickZoomOut()
  activate("zoom-out", "ACTION_ZOOM_OUT")
end


-- page
function clickCopyPage()
  pageAction("duplicate-page", "COPY")
end

function clickDeletePage()
  activate("delete-page", "ACTION_DELETE_PAGE")
end

function clickMoveUp()
  pageAction("move-page-towards-beginning", "MOVE_UP")
end

function clickMoveDown()
  pageAction("move-page-towards-end", "MOVE_DOWN")
end

function clickNewBefore()
  pageAction("new-page-before", "NEW_BEFORE")
end

function clickNewAfter()
  pageAction("new-page-after", "NEW_AFTER")
end

function clickNewLayer()
  activate("layer-new-above-current", "ACTION_NEW_LAYER")
end

function clickDeleteLayer()
  activate("layer-delete", "ACTION_DELETE_LAYER")
end

-- navigation
function clickGoToFirstPage()
  app.scrollToPage(1)
end

function clickGoToTop()
  app.scrollToPos(0, 0, false)
end

function goToPage(page)
  app.scrollToPage(page)
end

function goToPos(x, y)
  app.scrollToPos(x, y)
end

function clickScrollPageDown()
  app.scrollToPage(1, true)
end

function clickScrollPageUp()
  app.scrollToPage(-1, true)
end

function clickGoToBottom()
  local docStructure = app.getDocumentStructure()
  local currentPage = docStructure["currentPage"]
  local pageHeight = docStructure["pages"][currentPage]["pageHeight"]
  app.scrollToPos(0, pageHeight, false)
end

function clickGoToLastPage()
  -- it gets clamped in applib_scrollToPage anyway.
  app.scrollToPage(1000000000)
end

function currentPage()
  return app.getDocumentStructure()["currentPage"]
end

function clickLayerDown()
  activate("layer-goto-previous", "ACTION_GOTO_PREVIOUS_LAYER")
end

function clickLayerUp()
  activate("layer-goto-next", "ACTION_GOTO_NEXT_LAYER")
end


-- history
function clickUndo()
  activate("undo", "ACTION_UNDO")
end

function clickRedo()
  activate("redo", "ACTION_REDO")
end


-- files
function clickAnnotatePDF()
  activate("annotate-pdf", "ACTION_ANNOTATE_PDF")
end

function clickExportAsPDF()
  activate("export-as-pdf", "ACTION_EXPORT_AS_PDF")
end

function clickSave()
  activate("save", "ACTION_SAVE")
end

function clickSaveAs()
  activate("save-as", "ACTION_SAVE_AS")
end

function clickOpen()
  activate("open", "ACTION_OPEN")
end

-- background
function clickRuledBG()
  app.changeCurrentPageBackground("ruled");
end

function clickGraphBG()
  app.changeCurrentPageBackground("graph");
end

function clickIsometricGraphBG()
  app.changeCurrentPageBackground("isograph");
end

function clickDottedGraphBG()
  app.changeCurrentPageBackground("dotted");
end

function clickIsometricDottedGraphBG()
  app.changeCurrentPageBackground("isodotted");
end

function clickPlainBG()
  app.changeCurrentPageBackground("plain");
end
