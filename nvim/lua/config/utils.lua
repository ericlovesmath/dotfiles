local substitutions = {
    { "−", "-" },

    { "α", [[\alpha ]] }, { "β", [[\beta ]] }, { "γ", [[\gamma ]] },
    { "δ", [[\delta ]] }, { "Δ", [[\Delta ]] }, { "ε", [[\epsilon ]] },
    { "ζ", [[\zeta ]] },  { "η", [[\eta ]] },   { "θ", [[\theta ]] },
    { "Θ", [[\Theta ]] }, { "κ", [[\kappa ]] }, { "λ", [[\lambda ]] },
    { "Λ", [[\Lambda ]] },{ "μ", [[\mu ]] },    { "ξ", [[\xi ]] },
    { "π", [[\pi ]] },    { "Π", [[\Pi ]] },    { "ρ", [[\rho ]] },
    { "σ", [[\sigma ]] }, { "Σ", [[\Sigma ]] }, { "τ", [[\tau ]] },
    { "φ", [[\varphi ]] },{ "Φ", [[\Phi ]] },   { "ψ", [[\psi ]] },
    { "Ψ", [[\Psi ]] },   { "ω", [[\omega ]] }, { "Ω", [[\Omega ]] },

    { "≠", [[\neq ]] },   { "≤", [[\leq ]] },   { "≥", [[\geq ]] },
    { "×", [[\times ]] }, { "·", [[\cdot ]] },  { "÷", [[\div ]] },
    { "±", [[\pm ]] },    { "mp", [[\mp ]] },   { "≈", [[\approx ]] },
    { "≡", [[\equiv ]] }, { "∝", [[\propto ]] },
    { "∞", [[\infty ]] }, { "∂", [[\partial ]] }, { "∇", [[\nabla ]] },
    { "∀", [[\forall ]] },{ "∃", [[\exists ]] },{ "∄", [[\nexists ]] },
    { "∈", [[\in ]] },    { "∉", [[\notin ]] }, { "∋", [[\ni ]] },
    { "⊂", [[\subset ]] },{ "⊆", [[\subseteq ]] },
    { "∪", [[\cup ]] },   { "∩", [[\cap ]] },
    { "∅", [[\emptyset ]] },
    { "→", [[\to ]] },    { "⇒", [[\implies ]] }, { "⇔", [[\iff ]] },
    { "↦", [[\mapsto ]] },
    { "⟨", [[\langle ]] }, { "⟩", [[\rangle ]] },
    { "∨", [[\lor ]] },    { "∧", [[\land ]] },

    { "ℕ", [[\mathbb{N}]] }, { "ℤ", [[\mathbb{Z}]] },
    { "ℚ", [[\mathbb{Q}]] }, { "ℝ", [[\mathbb{R}]] },
    { "ℂ", [[\mathbb{C}]] },
    { "ℓ", [[\ell ]] },   { "ℜ", [[\Re]] },     { "ℑ", [[\Im]] },
    { "…", [[\dots ]] },  { "⋯", [[\cdots ]] }, { [[\. \. \.]], [[\ldots ]] },

    { "′", "'" }, { "’", "'" }, { "“", "``" }, { "”", "''" },
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
