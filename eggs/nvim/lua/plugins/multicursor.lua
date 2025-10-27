return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      local set = vim.keymap.set
      set({ "n", "x" }, "<C-m>", function()
        mc.lineAddCursor(-1)
      end)
      set({ "n", "x" }, "<C-n>", function()
        mc.lineAddCursor(1)
      end)
      set({ "n", "x" }, "<C-;>", function()
        mc.lineSkipCursor(-1)
      end)
      set({ "n", "x" }, "<C-'>", function()
        mc.lineSkipCursor(1)
      end)
      set({ "n", "x" }, "<C-p>", mc.deleteCursor)
      set("n", "<C-leftmouse>", mc.handleMouse)
      mc.addKeymapLayer(function(layerSet)
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end,
  },
}
