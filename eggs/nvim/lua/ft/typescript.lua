local M = {}

M.vtsls = {
  settings = {
    vtsls = { autoUseWorkspaceTsdk = true },
    typescript = {
      -- referencesCodeLens = { enabled = false, showOnAllFunctions = true },
      referencesCodeLens = { enabled = true, showOnAllFunctions = true },
      -- implementationsCodeLens = { enabled = false, showOnInterfaceMethods = true },
      implementationsCodeLens = { enabled = true, showOnInterfaceMethods = true, showOnAllClassMethods = true },
      -- suggest = { enabled = true, completeFunctionCalls = true },
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}

M.tsls = {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true, showOnAllFunctions = true },
    },
  },
}

return M
