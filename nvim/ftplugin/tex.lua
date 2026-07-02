vim.pack.add({
    "https://www.github.com/lervag/vimtex",
    "https://www.github.com/xuhdev/vim-latex-live-preview",
    "https://www.github.com/preservim/vim-markdown",
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    once = true,
    callback = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventQuit",
            callback = function()
                vim.fn["vimtex#compiler#clean"](0)
            end,
        })
    end,
})

vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_imaps_enabled = 1
vim.g.vimtex_imaps_leader = ";"
vim.g.vimtex_complete_enabled = 0
vim.g.vimtex_indent_on_ampersands = 0

vim.g.vim_markdown_math = 1
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_auto_insert_bullets = 0
vim.g.vim_markdown_new_list_item_indent = 0

vim.cmd([[
call vimtex#init()

set conceallevel=2
let g:vimtex_syntax_conceal["math_super_sub"]=0
highlight Conceal guifg=#d19a66 guibg=NONE
]])
