-- For adding journal entries in my Markdown format
function JournalEntry()
    -- Input custom date if desired
    local date = vim.fn.input("Date (YYYY-MM-DD): ", os.date("%Y-%m-%d"))
    local y, m, d = date:match("(%d%d%d%d)-(%d%d)-(%d%d)")
    local path = y .. "_" .. m .. "_" .. d

    -- Make it easy for user to rename images in Desktop then add to folder
    vim.fn.setreg("+", path .. "_")
    vim.cmd("silent! !open ./imgs &")
    vim.fn.input("Press Enter to continue... ")

    -- Add Journal Date
    vim.cmd("normal! G")
    vim.api.nvim_put({ "", "# " .. date, "" }, "l", true, true)

    if vim.fn.input("Add images? (y/n): ") ~= "y" then
        return
    end

    -- Add links to images in Markdown format
    local images = vim.fn.glob(os.date("./imgs/" .. path .. "*"))
    if #images == 0 then
        vim.api.nvim_err_writeln("No images found for the current date.")
    else
        for img in images:gmatch("[^\r\n]+") do
            vim.api.nvim_put({ "![](" .. img .. ")" }, "l", true, true)
        end
    end
end
