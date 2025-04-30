-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*.tmpl",
  },
  callback = function(args)
    local fname = vim.fn.fnamemodify(args.file, ":t")
    local ftmap = {
      ["dot_zshrc.tmpl"] = "zsh",
      ["dot_bashrc.tmpl"] = "bash",
      ["Microsoft.PowerShell_profile.ps1.tmpl"] = "ps1",
      ["dot_wezterm.lua.tmpl"] = "lua",
    }

    local ft = ftmap[fname]

    if not ft then
      -- fallback for extensions
      if fname:match("%.lua%.tmpl$") then
        ft = "lua"
      elseif fname:match("%.bash%.tmpl$") then
        ft = "bash"
      elseif fname:match("%.ps1%.tmpl$") then
        ft = "ps1"
      elseif fname:match("%.zsh%.tmpl$") then
        ft = "zsh"
      end
    end

    if ft then
      vim.bo.filetype = ft
    end
  end,
})
