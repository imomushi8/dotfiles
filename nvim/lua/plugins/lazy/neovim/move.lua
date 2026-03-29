return {
  {
    "bkad/CamelCaseMotion",
    lazy = false,
    init = function()
      vim.g.camelcasemotion_key = "<leader>"
    end,
    keys = {
      { "w",  "<Plug>CamelCaseMotion_w",  mode = {"n", "v"}, silent = true },
      { "b",  "<Plug>CamelCaseMotion_b",  mode = {"n", "v"}, silent = true },
      { "e",  "<Plug>CamelCaseMotion_e",  mode = {"n", "v"}, silent = true },
      { "ge", "<Plug>CamelCaseMotion_ge", mode = {"n", "v"}, silent = true },
    }
  },
  {
    "haya14busa/vim-edgemotion",
    lazy = false,
    keys = {
      { "J", "<Plug>(edgemotion-j)", mode = {"n", "v"}},
      { "K", "<Plug>(edgemotion-k)", mode = {"n", "v"}},
      { "H", "^", mode = {"n", "v"}},
      { "L", "$", mode = {"n", "v"}},
    },
  },
  {
    "rhysd/clever-f.vim"
  },
  {
    "unblevable/quick-scope"
  },
}