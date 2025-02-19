-- For adding journal entries in my Markdown format
vim.api.nvim_create_user_command("JournalEntry", function()
    -- Input custom date if desired
    local date = vim.fn.input("Date (YYYY-MM-DD): ", os.date("%Y-%m-%d"))
    local y, m, d = date:match("(%d%d%d%d)-(%d%d)-(%d%d)")
    local path = y .. "_" .. m .. "_" .. d

    -- Add Journal Date
    vim.cmd("normal! G")
    vim.api.nvim_put({ "", "# " .. date, "" }, "l", true, true)

    -- Make it easy for user to rename images in Desktop then add to folder
    if vim.fn.input("Add images? (y/n): ") ~= "y" then
        return
    end
    vim.fn.setreg("+", path .. "_")
    vim.cmd("silent! !xdg-open $HOME/Downloads & xdg-open ./imgs &")
    vim.fn.input("Press Enter to continue... ")

    -- Add links to images in Markdown format
    local images = vim.fn.glob(os.date("./imgs/" .. path .. "*"))
    if #images == 0 then
        vim.api.nvim_err_writeln("No images found for the current date.")
    else
        for img in images:gmatch("[^\r\n]+") do
            vim.api.nvim_put({ "![](" .. img .. ")" }, "l", true, true)
        end
    end
end, {})

local substitutions = {
    { src = "σ", dst = [[\sigma ]] },
    { src = "τ", dst = [[\tau ]] },
    { src = "π", dst = [[\pi ]] },
    { src = "Ω", dst = [[\Omega ]] },
    { src = "ω", dst = [[\omega ]] },
    { src = "′", dst = "'" },
    { src = "’", dst = "'" },
    { src = "≥", dst = [[\geq ]] },
    { src = "≤", dst = [[\leq ]] },
    { src = "×", dst = [[\times ]] },
    { src = "→", dst = [[\to ]] },
    { src = "·", dst = [[\cdot ]] },
    { src = "∈", dst = [[\in ]] },
    { src = "θ", dst = [[\theta ]] },
    { src = "∪", dst = [[\cup ]] },
    { src = "∩", dst = [[\cap ]] },
    { src = "⊆", dst = [[\subseteq ]] },
    { src = "⊂", dst = [[\subset ]] },
    { src = "∅", dst = [[\emptyset ]] },
    { src = "ℜ", dst = [[\mathfrak{R}]] },
    { src = "ℓ", dst = [[\ell ]] },
    { src = "μ", dst = [[\mu ]] },
    { src = "ε", dst = [[\epsilon ]] },
    { src = "“", dst = "``" },
    { src = "”", dst = "''" },
    { src = "−", dst = "-" }, -- The bane of my existence
    { src = [[\. \. \.]], dst = [[\ldots ]] },
    { src = "∀", dst = [[\forall ]] },
    { src = "∃", dst = [[\exists ]] },
    { src = "⇒", dst = [[\implies ]] },
    { src = "∨", dst = [[\lor ]] },
    { src = "∧", dst = [[\land ]] },
    { src = "⟨", dst = [[\left< ]] },
    { src = "⟩", dst = [[\right> ]] },
}

-- Utility function to replace unicode character when copying from PDF
vim.api.nvim_create_user_command("LatexSubstituteUnicode", function()
    if not vim.bo.filetype == "tex" then
        print("Warning: This is not a LaTeX file.")
        return
    end

    for _, sub in ipairs(substitutions) do
        vim.cmd(":silent! %s/" .. sub.src .. "/" .. sub.dst:gsub([[\]], [[\\]]) .. "/g")
    end
end, {})
