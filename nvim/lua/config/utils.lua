local substitutions = {
    { src = "−", dst = "-" }, -- The bane of my existence
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
