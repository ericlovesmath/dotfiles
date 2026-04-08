local function prompt_and_output_code(system, input, buf, start_row, end_row)
    local ns_id = vim.api.nvim_create_namespace("")

    local start_extmark = vim.api.nvim_buf_set_extmark(buf, ns_id, start_row, 0, {})
    local end_extmark = vim.api.nvim_buf_set_extmark(buf, ns_id, end_row, 0, {})

    if (end_row == start_row) then
        vim.api.nvim_buf_set_extmark(buf, ns_id, start_row - 1, 0, {
            sign_text = "*",
            sign_hl_group = "DiagnosticInfo"
        })
    else
        for i = start_row, end_row - 1 do
            vim.api.nvim_buf_set_extmark(buf, ns_id, i, 0, {
                sign_text = "*",
                sign_hl_group = "DiagnosticInfo"
            })
        end
    end

    vim.system({ "llm", "-s", system, "-x" }, { stdin = input, text = true },
        function(obj)
            vim.schedule(function()
                if obj.code == 0 then
                    local output_lines = vim.split(obj.stdout:gsub("\n+$", ""), "\n", { plain = true })
                    local start_pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns_id, start_extmark, {})
                    local end_pos = vim.api.nvim_buf_get_extmark_by_id(buf, ns_id, end_extmark, {})
                    vim.api.nvim_buf_set_lines(buf, start_pos[1], end_pos[1], false, output_lines)
                else
                    vim.notify("llm failed", vim.log.levels.ERROR)
                end
                vim.api.nvim_buf_clear_namespace(buf, ns_id, 0, -1)
            end)
        end)
end

function insert_below_cursor()
    vim.ui.input({ prompt = "prompt: " }, function(input)
        if not input or input == "" then return end

        local buf = vim.api.nvim_get_current_buf()
        local row = vim.api.nvim_win_get_cursor(0)[1]

        local buffer_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false);
        table.insert(buffer_lines, row + 1, "<<<INSERT HERE>>>")
        local buffer_text = table.concat(buffer_lines, "\n")

        local system = input ..
            "Output code in a markdown code block. " ..
            "Follow this prompt exactly, do not add anything extra." ..
            "The code you output will be inserted at <<<INSERT HERE>>>. " ..
            "Do not rewrite any existing lines."

        prompt_and_output_code(system, buffer_text, buf, row, row);
    end)
end

function edit_selection()
    vim.ui.input({ prompt = "prompt: " }, function(input)
        if not input or input == "" then return end

        local buf = vim.api.nvim_get_current_buf()
        local start_row = vim.fn.line("v")
        local end_row = vim.fn.line(".")
        if start_row > end_row then
            start_row, end_row = end_row, start_row
        end

        local buffer_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        table.insert(buffer_lines, end_row + 1, "<<<EDIT END>>>")
        table.insert(buffer_lines, start_row, "<<<EDIT START>>>")
        local buffer_text = table.concat(buffer_lines, "\n")

        -- deselect lines
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
            "n", false)

        local system = input ..
            "Output code in a markdown code block. " ..
            "Follow this prompt exactly, do not add anything extra. " ..
            "The code you output will replace the region between <<<EDIT START>>> and <<<EDIT END>>>. " ..
            "Do not rewrite anything outside of this region." ..
            "Do not output the start or end tag."

        prompt_and_output_code(system, buffer_text, buf, start_row - 1, end_row)
    end)
end

vim.keymap.set("n", "<leader>li", insert_below_cursor)
vim.keymap.set("v", "<leader>le", edit_selection)
