return {
  -- root_dir = require("lspconfig").util.root_pattern("pyrightconfig.json", ".git", "."),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "on",
        diagnosticMode = "workspace",
        extraPaths = { "/Applications/Sublime Text.app/Contents/MacOS/Lib/python38" },
      },
    },
  },
}
