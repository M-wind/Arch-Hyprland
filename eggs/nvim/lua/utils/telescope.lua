local M = {}

local themes = {
  { idx = 1, text = "1: Everforest", value = "everforest" },
  { idx = 2, text = "2: Onedarkpro", value = "onedark" },
  { idx = 3, text = "3: Solarized Osaka", value = "solarized-osaka" },
  { idx = 4, text = "4: Dracula", value = "dracula" },
  { idx = 5, text = "5: Tokyodark", value = "tokyodark" },
  -- { idx = 7, text = "7: Tokyonight Day", value = "tokyonight-day" },
  { idx = 6, text = "6: Vscode", value = "vscode" },
  { idx = 7, text = "7: Catppuccin Mocha", value = "catppuccin-mocha" },
  { idx = 8, text = "8: Tokyonight Moon", value = "tokyonight-moon" },
  { idx = 9, text = "9: Bamboo", value = "bamboo" },
}

local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

local create_mapping = function(prompt_bufnr, mapping_config)
  return function()
    local selection = action_state.get_selected_entry()
    if mapping_config.before_action ~= nil then
      mapping_config.before_action(selection)
    end

    -- Close Telescope window
    actions._close(prompt_bufnr, mapping_config.keepinsert or false)

    mapping_config.action(selection)

    if mapping_config.after_action ~= nil then
      mapping_config.after_action(selection)
    end
  end
end

M.change_theme = function()
  local entry_maker = function(entry)
    return { ordinal = entry.text, display = entry.text, value = entry.value }
  end
  pickers
    .new({
      sorting_strategy = "ascending",
      layout_strategy = "center",
      default_selection_index = vim.iter(themes):find(function(v)
        return v.value == vim.g.colors_name
      end).idx,
      layout_config = { height = #themes + 4, width = 35 },
      prompt_title = " Themes",
      finder = finders.new_table({
        results = themes,
        entry_maker = entry_maker,
      }),
      sorter = conf.file_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(create_mapping(prompt_bufnr, {
          action = function(selection)
            if vim.g.colors_name == selection.value then
              vim.notify("Already The Theme.", "warn")
              return
            end
            local theme = require("utils.theme")
            theme.load(selection.value)
            for k, v in pairs(theme.tailwindColor) do
              vim.api.nvim_set_hl(0, k, { fg = v })
            end
          end,
        }))
        return true
      end,
    })
    :find()
end

M.zoxide = function()
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      return { "zoxide", "query", "-ls" }
    end,
    entry_maker = function(entry)
      local score = string.match(entry, "%s*[0-9.]+%s")
      local value = string.gsub(entry, score, "")
      return { ordinal = entry, display = entry, value = value }
    end,
  })
  pickers
    .new({
      prompt_title = "Zoxide History",
      layout_strategy = "vertical",
      layout_config = {
        vertical = { preview_height = 0.4, prompt_position = "bottom" },
      },
      debounce = 100,
      finder = finder,
      previewer = require("telescope.previewers.buffer_previewer").cat.new({}),
      sorter = conf.file_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(create_mapping(prompt_bufnr, {
          action = function(selection)
            vim.cmd.cd(selection.value)
          end,
          after_action = function(selection)
            vim.notify("Directory change to " .. selection.value)
          end,
        }))
        return true
      end,
    })
    :find()
end

M.live_grep = function(opts)
  local make_entry = require("telescope.make_entry")
  local sorters = require("telescope.sorters")
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local serchTerm = ""
  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return
      end
      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
        serchTerm = pieces[1]
      end
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      return vim.list_extend(
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
      )
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })
  pickers
    .new(opts, {
      prompt_title = "Live Grep",
      debounce = 100,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = sorters.new({
        scoring_function = function()
          return 1
        end,
        highlighter = function(_, _, display)
          local fzy = require("telescope.algos.fzy")
          return fzy.positions(serchTerm, display)
        end,
      }),
    })
    :find()
end

return M
