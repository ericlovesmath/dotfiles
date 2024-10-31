-- Create quick code runner shortcuts
local config = {
    key = "<leader>r",
    filetypes = {
        bash = "bash $fileName",
        sh = "bash $fileName",
        go = "go run $fileName",
        python = "python3 $fileName",
        java = "java $fileName",
        javascript = "node $fileName",
        haskell = "runhaskell $fileName",
        ocaml = "ocaml $fileName",
        rust = "cargo run",
        typescript = "deno run",
        c = "cd $folder && gcc $fileName -o $fileNoExt.out && ./$fileNoExt.out",
        cpp = "cd $folder && g++ -std=c++17 %:p -o $fileNoExt.out -Wall -Wextra -Wshadow && ./$fileNoExt.out",
    },
}

local function parseCmd(ft)
    local mappings = {
        fileName = "%%:p",
        fileNoExt = "%%:t:r",
        folder = "%%:p:h",
    }

    local cmd = config.filetypes[ft]
    for keyword, modifier in pairs(mappings) do
        cmd = cmd:gsub("$" .. keyword, modifier)
    end

    return cmd
end

vim.api.nvim_create_augroup("CodeRunner", { clear = true })
for ft, _ in pairs(config.filetypes) do
    local cmd = ":w<CR>:vsp<CR>:term " .. parseCmd(ft) .. "<CR><C-\\><C-n>"
    vim.api.nvim_create_autocmd("Filetype", {
        group = "CodeRunner",
        pattern = ft,
        callback = function()
            vim.keymap.set("n", config.key, cmd, { buffer = true })
        end,
    })
end
