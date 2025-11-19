local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local function in_mathzone()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function math(trigger, text)
    return s({ trig = trigger, snippetType = "autosnippet", condition = in_mathzone }, { t(text) })
end

local function math_fmt(trigger, fmt, nodes)
    return s({ trig = trigger, snippetType = "autosnippet", condition = in_mathzone }, fmta(fmt, nodes))
end

local function auto_fmt(trigger, fmt, nodes)
    return s({ trig = trigger, snippetType = "autosnippet" }, fmta(fmt, nodes))
end

local function left_right(trigger, l, r)
    return s(
        { trig = trigger, snippetType = "autosnippet", condition = in_mathzone },
        fmta([[\left]] .. l .. " DM " .. [[\right]] .. r, { i(1) }, { delimiters = "DM" })
    )
end

return {
    -- TODO: If in enumerate / itemize, auto add \item
    -- TODO: Rewrite generate_pset

    math("=>", [[\implies]]),
    math("=<", [[\impliedby]]),
    math("iff", [[\iff]]),
    math("!=", [[\neq]]),
    math("<=", [[\leq]]),
    math(">=", [[\geq]]),
    math("EE", [[\exists]]),
    math("AA", [[\forall]]),
    math("oo", [[\infty]]),
    math("xx", [[\times]]),
    math("**", [[\cdot]]),
    math("nabl", [[\nabla]]),
    math([[\\\]], [[\setminus]]),
    math("||", [[\mid]]),
    math([[...]], [[\ldots]]),
    math("lll", [[\ell]]),
    math("~~", [[\sim]]),
    math("->", [[\to]]),
    math("cc", [[\subset]]),
    math("CC", [[\subseteq]]),

    left_right("ceil", [[\lceil]], [[\rceil ]]),
    left_right("floor", [[\lfloor]], [[\rfloor ]]),
    left_right("()", "(", ")"),
    left_right("lr[", "[", "]"),
    left_right("lr{", [[\{]], [[\}]]),
    left_right("lra", "<", ">"),

    math_fmt("part", [[\frac{\partial <>}{\partial <>}]], { i(1), i(2) }),
    math_fmt("sq", [[\sqrt{<>}]], { i(1) }),
    math_fmt("mcal", [[\mathcal{<>}]], { i(1) }),
    math_fmt("hat", [[\hat{<>}]], { i(1) }),
    math_fmt("bar", [[\overline{<>}]], { i(1) }),
    math_fmt("//", [[\frac{<>}{<>}]], { i(1), i(2) }),
    math_fmt("__", [[_{<>}]], { i(1) }),
    math_fmt("td", [[^{<>}]], { i(1) }),
    math_fmt("set", [[\{<>\}]], { i(1) }),
    math_fmt("norm", [[\|<>\|]], { i(1) }),
    math_fmt("pmat", [[\begin{pmatrix} <> \end{pmatrix}]], { i(1) }),
    math_fmt("bmat", [[\begin{bmatrix} <> \end{bmatrix}]], { i(1) }),

    auto_fmt(
        "beg",
        [[
            \begin{<>}
                <>
            \end{<>}
            <>
        ]],
        { i(1), i(2), rep(1), i(0) }
    ),

    auto_fmt(
        "dm",
        [[
            \[
                <>
            \]
            <>
        ]],
        { i(1), i(0) }
    ),
}
