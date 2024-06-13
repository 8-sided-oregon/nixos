{ lib, pkgs, awesome-neovim-plugins, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs; [
      {
        plugin = vimPlugins.coq_nvim;
        config = ''let g:coq_settings = { "auto_start": "shut-up" }'';
        type = "viml";
      }
      vimPlugins.coq-artifacts
      {
        plugin = vimPlugins.chadtree;
        config = "noremap <leader>v <cmd>CHADopen<cr>";
        optional = true;
        type = "viml";
      }
      {
        plugin = vimPlugins.nvim-lspconfig;
        config = ''
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup {}
          lspconfig.rust_analyzer.setup {}
        '';
        type = "lua";
      }
      {
        plugin = vimPlugins.nvim-navic;
        config = ''
          local navic = require("nvim-navic").setup {
              lsp = {
                  auto_attach = true,
              },
          }
        '';
        type = "lua";
      }
      {
        plugin = vimPlugins.gruvbox-community;
        config = "colorscheme retrobox";
        type = "viml";
      }
      {
        plugin = awesome-neovim-plugins.packages.x86_64-linux.NeoColumn-nvim;
        config = ''
          require("NeoColumn").setup {
            NeoColumn = "120"
          }
        '';
        type = "lua";
      }
    ];
    extraConfig = ''
      lua require("lsp")
      set statusline=%!v:lua.require'statusline'.statusline()
      noremap <leader>t <cmd>split<cr><cmd>wincmd w<cr><cmd>terminal zsh<cr><cmd>echomsg join(["Opened terminal in buffer", bufnr("%")])<cr>
      set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab rnu
      set statusline=%!v:lua.require'statusline'.statusline()
    '';
  };

  home.file.".config/nvim/lua/lsp.lua".text = ''
    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
            end, opts)
        end,
    })
  '';

  home.file.".config/nvim/lua/statusline.lua".source = ../configs/neovim/statusline.lua;
}
