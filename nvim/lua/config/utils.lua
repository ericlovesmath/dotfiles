local substitutions = {
    { "−", "-" },

    { "α", [[\alpha ]] },
    { "β", [[\beta ]] },
    { "γ", [[\gamma ]] },
    { "δ", [[\delta ]] },
    { "Δ", [[\Delta ]] },
    { "ε", [[\epsilon ]] },
    { "ζ", [[\zeta ]] },
    { "η", [[\eta ]] },
    { "θ", [[\theta ]] },
    { "Θ", [[\Theta ]] },
    { "κ", [[\kappa ]] },
    { "λ", [[\lambda ]] },
    { "Λ", [[\Lambda ]] },
    { "μ", [[\mu ]] },
    { "ξ", [[\xi ]] },
    { "π", [[\pi ]] },
    { "Π", [[\Pi ]] },
    { "ρ", [[\rho ]] },
    { "σ", [[\sigma ]] },
    { "Σ", [[\Sigma ]] },
    { "τ", [[\tau ]] },
    { "φ", [[\varphi ]] },
    { "Φ", [[\Phi ]] },
    { "ψ", [[\psi ]] },
    { "Ψ", [[\Psi ]] },
    { "ω", [[\omega ]] },
    { "Ω", [[\Omega ]] },

    { "≠", [[\neq ]] },
    { "≤", [[\leq ]] },
    { "≥", [[\geq ]] },
    { "×", [[\times ]] },
    { "·", [[\cdot ]] },
    { "÷", [[\div ]] },
    { "±", [[\pm ]] },
    { "≡", [[\equiv ]] },
    { "∝", [[\propto ]] },
    { "∞", [[\infty ]] },
    { "∂", [[\partial ]] },
    { "∇", [[\nabla ]] },
    { "∀", [[\forall ]] },
    { "∃", [[\exists ]] },
    { "∄", [[\nexists ]] },
    { "∈", [[\in ]] },
    { "∉", [[\notin ]] },
    { "∋", [[\ni ]] },
    { "⊂", [[\subset ]] },
    { "⊆", [[\subseteq ]] },
    { "∪", [[\cup ]] },
    { "∩", [[\cap ]] },
    { "∅", [[\emptyset ]] },
    { "→", [[\to ]] },
    { "⇒", [[\implies ]] },
    { "⇔", [[\iff ]] },
    { "↦", [[\mapsto ]] },
    { "⟨", [[\langle ]] },
    { "⟩", [[\rangle ]] },
    { "∨", [[\lor ]] },
    { "∧", [[\land ]] },

    { "ℕ", [[\mathbb{N}]] },
    { "ℤ", [[\mathbb{Z}]] },
    { "ℚ", [[\mathbb{Q}]] },
    { "ℝ", [[\mathbb{R}]] },
    { "ℂ", [[\mathbb{C}]] },
    { "ℓ", [[\ell ]] },
    { "ℜ", [[\Re]] },
    { "ℑ", [[\Im]] },
    { "…", [[\dots ]] },
    { "⋯", [[\cdots ]] },
    { [[\. \. \.]], [[\ldots ]] },

    { "′", "'" },
    { "’", "'" },
    { "“", "``" },
    { "”", "''" },
}

-- Utility function to replace unicode character when copying from PDF
vim.api.nvim_create_user_command("LatexSubstituteUnicode", function()
    if not vim.bo.filetype == "tex" then
        print("Warning: This is not a LaTeX file.")
        return
    end

    for _, sub in ipairs(substitutions) do
        local src = sub[1]
        local dst = sub[2]:gsub([[\]], [[\\]])
        vim.cmd(":silent! %s/" .. src .. "/" .. dst .. "/g")
    end
end, {})

local function pdf_for(filepath)
    local basename = vim.fn.fnamemodify(filepath, ":t:r")
    return "/tmp/" .. basename .. "_preview.pdf"
end

local function render_md_to_pdf(filepath, on_done)
    local output = pdf_for(filepath)
    local cmd = { "pandoc", filepath, "-o", output }
    if on_done then
        vim.fn.jobstart(cmd, { on_exit = on_done })
    else
        vim.fn.jobstart(cmd)
    end
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    callback = function(args)
        render_md_to_pdf(args.file)
    end,
})

vim.api.nvim_create_user_command("MarkdownView", function()
    vim.notify("Rendering markdown preview...", vim.log.levels.INFO)
    local filepath = vim.api.nvim_buf_get_name(0)
    local output = pdf_for(filepath)

    render_md_to_pdf(filepath, function()
        vim.fn.jobstart({ "zathura", output })
    end)
end, {})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("n", "<leader>ll", "<cmd>MarkdownView<cr>", {
            desc = "Markdown live preview",
            silent = true,
            buffer = true,
        })
    end,
})
