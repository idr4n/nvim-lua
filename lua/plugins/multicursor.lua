return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  keys = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>/", group = "Multicursor" },
    })

    local mc = require("multicursor-nvim")
      -- stylua: ignore
      return {
        -- Add or skip cursor above/below the main cursor.
        { "<up>", function() mc.lineAddCursor(-1) end, mode = { "n", "x" }, desc = "Multicursor" },
        { "<down>", function() mc.lineAddCursor(1) end, mode = { "n", "x" }, desc = "Multicursor" },
        { "<leader><up>", function() mc.lineSkipCursor(-1) end, mode = { "n", "x" }, desc = "Multicursor" },
        { "<leader><down>", function() mc.lineSkipCursor(1) end, mode = { "n", "x" }, desc = "Multicursor" },

        { "<C-N>", function() mc.matchAddCursor(1) end, mode = { "n", "x" }, desc = "Multicursor" },
        { "<leader>/n", function() mc.matchAddCursor(1) end, mode = { "n", "x" }, desc = "Multicursor - Add next match" },
        { "<leader>/s", function() mc.matchSkipCursor(1) end, mode = { "n", "x" }, desc = "Multicursor - Skip match" },

        { "<leader>/t", mc.toggleCursor, mode = { "n", "x" }, desc = "Multicursor - Toggle" },
        { "<leader>/a", mc.duplicateCursors, mode = { "n", "x" }, desc = "Multicursor - Add cursor in place" },
        { "<leader>/v", mc.restoreCursors, desc = "Multicursor - Restore cursors" },

        { "<leader>/I", mc.insertVisual, mode = { "x" }, desc = "Multicursor - Insert for each line" },

        { "<leader>/A", mc.searchAllAddCursors, desc = "Multicursor - Add all cursors on search" },
        { "<leader>/N", function() mc.searchAddCursor(1) end, desc = "Multicursor - Search add cursor" },
        { "<leader>/S", function() mc.searchSkipCursor(1) end, desc = "Multicursor - Search skip cursor" },
        { "<leader>/l", mc.alignCursors, desc = "Multicursor - Aligh cursors" },

        { "<leader>/M", mc.matchCursors, mode = "x", desc = "Multicursor - Match by regex" },
        { "<leader>/P", mc.splitCursors, mode = "x", desc = "Multicursor - Split by regex" },
      }
  end,

  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<left>", mc.prevCursor)
      layerSet({ "n", "x" }, "<right>", mc.nextCursor)

      -- Delete the main cursor.
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)
  end,
}
