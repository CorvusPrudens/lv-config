return {
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "felpafel/inlay-hint.nvim",
    branch = "nightly",
    event = "LspAttach",
    config = function()
      require("inlay-hint").setup({

        display_callback = function(line_hints, options, bufnr)
          if options.virt_text_pos == "inline" then
            local lhint = {}
            for _, hint in pairs(line_hints) do
              local text = ""
              local label = hint.label
              if type(label) == "string" then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if hint.paddingLeft then
                text = " " .. text
              end
              if hint.paddingRight then
                text = text .. " "
              end
              lhint[#lhint + 1] = { text = text, col = hint.position.character }
            end
            return lhint
          elseif options.virt_text_pos == "eol" or options.virt_text_pos == "right_align" then
            local k1 = {}
            local k2 = {}
            table.sort(line_hints, function(a, b)
              return a.position.character < b.position.character
            end)
            for _, hint in pairs(line_hints) do
              local label = hint.label
              local kind = hint.kind
              local node = kind == 1
                  and vim.treesitter.get_node({
                    bufnr = bufnr,
                    pos = {
                      hint.position.line,
                      hint.position.character - 1,
                    },
                  })
                or nil
              local node_text = node and vim.treesitter.get_node_text(node, bufnr, {}) or ""
              local text = ""
              if type(label) == "string" then
                text = label
              else
                for _, part in ipairs(label) do
                  text = text .. part.value
                end
              end
              if kind == 1 then
                k1[#k1 + 1] = text:gsub(":%s*", node_text .. ": ")
              else
                k2[#k2 + 1] = text:gsub(":$", "")
              end
            end
            local text = ""
            if #k2 > 0 then
              text = "<- (" .. table.concat(k2, ",") .. ")"
            end
            if #text > 0 then
              text = text .. " "
            end
            if #k1 > 0 then
              text = text .. "=> " .. table.concat(k1, ", ")
            end

            return text
          end
          return nil
        end,
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true,
    keys = {
      "<leader>wt",
      "<cmd>ToggleTerm size=20<cr>",
      desc = "Open a horizontal terminal",
    },
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4", -- Recommended
  --   ft = { "rust" },
  --   opts = {
  --     tools = {
  --       enable_clippy = false,
  --     },
  --     server = {
  --       on_attach = function(_, bufnr)
  --         vim.keymap.set("n", "<leader>cR", function()
  --           vim.cmd.RustLsp("codeAction")
  --         end, { desc = "Code Action", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>dr", function()
  --           vim.cmd.RustLsp("debuggables")
  --         end, { desc = "Rust Debuggables", buffer = bufnr })
  --       end,
  --       default_settings = {
  --         -- rust-analyzer language server configuration
  --         ["rust-analyzer"] = {
  --           cargo = {
  --             allFeatures = false,
  --             loadOutDirsFromCheck = true,
  --             buildScripts = {
  --               enable = true,
  --             },
  --           },
  --           -- Add clippy lints for Rust.
  --           checkOnSave = true,
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  --     if vim.fn.executable("rust-analyzer") == 0 then
  --       LazyVim.error(
  --         "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
  --         { title = "rustaceanvim" }
  --       )
  --     end
  --   end,
  -- },
}
