return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              lint = { ignore = { "E501", "E402", "W291", "W293" } },
            },
          },
        },
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
