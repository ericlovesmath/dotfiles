local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local function in_mathzone()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

local function simple(trig, condition, nodes, opts)
    return s({ trig = trig, snippetType = "autosnippet", condition = condition }, nodes, opts)
end

local function math(trig, text)
    return simple(trig, in_mathzone, { t(text) }, nil)
end

local function math_fmt(trig, fmt, nodes)
    return simple(trig, in_mathzone, fmta(fmt, nodes), nil)
end

local function auto_fmt(trig, fmt, nodes)
    return simple(trig, nil, fmta(fmt, nodes), nil)
end

local function left_right(trig, l, r)
    local fmt = [[\left]] .. l .. " DM " .. [[\right]] .. r
    return simple(trig, in_mathzone, fmta(fmt, { i(1) }, { delimiters = "DM" }))
end

local function math_regex(trig, nodes)
    return s({ trig = trig, regTrig = true, snippetType = "autosnippet", condition = in_mathzone }, nodes)
end

return {
    -- TODO: If in enumerate / itemize, auto add \item
    -- TODO: Rewrite generate_pset
    -- TODO: \text, \texttt, \textbb
    -- TODO: sum, limit, prod, int
    -- TODO: Tabular

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
    math("<->", [[\leftrightarrow]]),
    math("cc", [[\subset]]),
    math("CC", [[\subseteq]]),
    -- math("notin", [[\not\in]]),
    -- math("inn", [[\in]]),
    -- math("Nn", [[\cap]]),
    -- math("UU", [[\cup]]),

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
    math_fmt("==", [[&= <> \\]], { i(1) }),

    math_fmt(
        "cases",
        [[
            \begin{cases}
                <>
            \end{cases}
            <>
        ]],
        { i(1), i(0) }
    ),

    auto_fmt("mk", "$<>$", { i(1) }),

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
        ]],
        { i(1) }
    ),

    s(
        "figure",
        fmta(
            [[
                \begin{figure}[htpb]
                    \centering
                    \includegraphics[width=0.8\textwidth]{<>}
                    \caption{<>}
                \end{figure}
                <>
            ]],
            { i(2), i(3), i(0) }
        )
    ),

    -- Expand x1 to x_1, for example
    math_regex("([%a])([%d])", {
        f(function(_, parent)
            return parent.captures[1] .. "_" .. parent.captures[2]
        end),
    }),

    -- Expands symbols like `x_1`, `\alpha`, or `y^{10}` followed by `/`. into \frac form
    math_regex(
        "([%w\\%_%^{}]+)/",
        fmta("\\frac{<>}{<>}", {
            f(function(_, parent)
                return parent.captures[1]
            end),
            i(1),
        })
    ),

    -- Expand (<any>)/<cursor> to \frac{<any>}/{<cursor}
    math_regex(
        "(%b())/",
        fmta("\\frac{<>}{<>}", {
            f(function(_, parent)
                return string.sub(parent.captures[1], 2, -2)
            end),
            i(1),
        })
    ),

    -- Expands `()` to `\left(\right)` even when preceded by a word (like `sin()`)
    math_regex(
        "([%w\\]+)%(%)",
        fmta("<>\\left(<>\\right)", {
            f(function(_, parent)
                return parent.captures[1]
            end),
            i(1),
        })
    ),
}
