local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
  -- common
  b.code_actions.refactoring,

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- go
  b.diagnostics.golangci_lint,
  b.formatting.gofmt,
  b.formatting.goimports,
  b.formatting.goimports_reviser,
  b.code_actions.impl,
  b.code_actions.gomodifytags,

  -- python
  b.diagnostics.ruff,
  b.formatting.black,


  -- docker
  b.diagnostics.hadolint,

  -- proto
  b.diagnostics.buf,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
