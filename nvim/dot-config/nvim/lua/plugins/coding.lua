return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.markdown = { "markdownlint-file" }
      opts.linters = opts.linters or {}
      opts.linters["markdownlint-file"] = {
        cmd = "markdownlint-cli2",
        stdin = false,
        args = {},
        ignore_exitcode = true,
        stream = "stderr",
        parser = require("lint.parser").from_errorformat("%f:%l:%c %m,%f:%l %m", {
          source = "markdownlint",
          severity = vim.diagnostic.severity.WARN,
        }),
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          on_new_config = function(config, root_dir)
            local ds_root = vim.fn.expand("~/data-science")
            if root_dir:find(ds_root, 1, true) then
              config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                python = {
                  pythonPath = ds_root .. "/dist/export/python/virtualenvs/python-default/3.12.12/bin/python",
                },
              })
            end
          end,
        },
      },
    },
  },
}
