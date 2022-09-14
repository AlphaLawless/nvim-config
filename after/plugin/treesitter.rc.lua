local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    "tsx",
    "bash",
    "c",
    "dockerfile",
    "clojure",
    "cpp",
    "go",
    "gitignore",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "rust",
    "elixir",
    "dart",
    "ruby",
    "python",
    "java",
    "erlang",
    "c_sharp",
    "haskell",
    "typescript",
    "javascript",
    "jsdoc",
    "markdown",
    "make",
    "nix",
    "pascal",
    "perl",
    "ocaml",
    "prisma",
    "scala",
    "scss",
    "regex",
    "r",
    "sql",
    "vim",
    "swift",
    "zig",
    "vue",
    "llvm",
    "kotlin",
    "http",
    "comment",
    "graphql",
    "solidity"
  },
  autotag = {
    enable = true
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
