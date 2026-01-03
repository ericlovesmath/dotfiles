return {
    "lervag/vimtex",
    dependencies = {
        "xuhdev/vim-latex-live-preview",
        "preservim/vim-markdown"
    },
    ft = { "tex", "markdown" },
    config = function()
        vim.cmd([[
        let g:vimtex_compiler_progname = "nvr"
        let g:vimtex_view_method = "zathura"   " skim on MacOS
        let g:vimtex_imaps_enabled = 1
        let g:vimtex_complete_enabled = 0
        let g:vimtex_indent_on_ampersands = 0

        call vimtex#init()

        set conceallevel=2
        let g:vimtex_syntax_conceal["math_super_sub"]=0
        highlight Conceal guifg=#d19a66 guibg=NONE

        augroup vimtex_config
            au!
            au User VimtexEventQuit call vimtex#compiler#clean(0)
        augroup END

        let g:vim_markdown_math = 1
        let g:vim_markdown_folding_disabled = 1
        ]])
    end

}
