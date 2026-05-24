local load = function()
  require("grug-far").setup({
    enabledEngines = { "ripgrep" },
    helpLine = { enabled = false },
    startInInsertMode = false,
    keymaps = {
      replace = { n = "<localleader>r" },
      -- qflist = { n = "<localleader>q" },
      qflist = false,
      -- syncLocations = { n = "<localleader>s" },
      syncLocations = false,
      syncLine = { n = "<localleader>l" },
      -- close = { n = "<localleader>c" },
      close = { n = "<localleader>q" },
      historyOpen = { n = "<localleader>h" },
      -- historyAdd = { n = "<localleader>a" },
      historyAdd = false,
      refresh = { n = "<localleader>f" },
      -- openLocation = { n = "<localleader>o" },
      -- openNextLocation = { n = "<down>" },
      -- openPrevLocation = { n = "<up>" },
      -- gotoLocation = { n = "<enter>" },
      pickHistoryEntry = { n = "<enter>" },
      openLocation = false,
      openNextLocation = false,
      openPrevLocation = false,
      gotoLocation = false,
      -- abort = { n = "<localleader>b" },
      abort = { n = "<localleader>a" },
      -- help = { n = "g?" },
      help = false,
      -- toggleShowCommand = { n = "<localleader>w" },
      toggleShowCommand = { n = "<localleader>c" },
      -- swapEngine = { n = "<localleader>e" },
      -- previewLocation = { n = "<localleader>i" },
      -- swapReplacementInterpreter = { n = "<localleader>x" },
      -- swapEngine = { n = "rs" },
      swapEngine = false,
      previewLocation = false,
      swapReplacementInterpreter = false,
      -- applyNext = { n = "<localleader>j" },
      -- applyPrev = { n = "<localleader>k" },
      applyNext = { n = "<localleader>j" },
      applyPrev = { n = "<localleader>k" },
      -- syncNext = { n = "<localleader>n" },
      -- syncPrev = { n = "<localleader>p" },
      -- syncFile = { n = "<localleader>v" },
      syncNext = false,
      syncPrev = false,
      syncFile = false,
      nextInput = { n = "<tab>" },
      prevInput = { n = "<C-tab>" },
    },
  })
end

local key_load = true

vim.pack.add({
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
}, {
  load = function(v)
    vim.keymap.set("n", "<leader>s", function()
      if key_load then
        vim.cmd.packadd(v.spec.name)
        load()
        key_load = false
      end
      local grug = require("grug-far")
      local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
      grug.open({
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= "" and "*." .. ext or nil,
        },
      })
    end, { desc = "Search & Replace" })
  end,
})
