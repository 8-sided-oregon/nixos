-- shamelessly stolen from https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/ 
-- bc i have no idea what im doing lol

local M = {}

local buffer_instances = {}

function M.format_uri(uri)
    if vim.startswith(uri, 'jdt://') then
        local package = uri:match('contents/[%a%d._-]+/([%a%d._-]+)') or ''
        local class = uri:match('contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class') or ''
        return string.format('%s::%s', package, class)
    else
        return vim.fn.fnamemodify(vim.uri_to_fname(uri), ':.')
    end
end

function M.file_or_lsp_status()
    -- Neovim keeps the messages sent from the language server in a buffer and
    -- get_progress_messages polls the messages
    local messages = vim.lsp.status()
    local mode = vim.api.nvim_get_mode().mode

    -- If neovim isn't in normal mode, or if there are no messages from the
    -- language server display the file name
    -- I'll show format_uri later on
    if mode ~= 'n' or messages == "" then
        return M.format_uri(vim.uri_from_bufnr(vim.api.nvim_get_current_buf()))
    end
    return messages
end

function M.diagnostic_status()
    -- count the number of diagnostics with severity warning
    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

    local parts = {}

    if num_errors > 0 then
        table.insert(parts, '⛔ ' .. num_errors)
    end
    -- Otherwise show amount of warnings, or nothing if there aren't any.
    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
        table.insert(parts, '☢️  ' .. num_warnings)
    end

    if #parts > 0 then
        return '  ' .. table.concat(parts, ' ') .. ' '
    end

    return ''
end


function M.git_branch(inst)
    local current_time = os.time(os.date("!*t"))

    if current_time - inst.branch_cache_timestamp >= 3 then
        inst.branch_cache_timestamp = current_time
        local working_dir = vim.fn.expand("%:p:h")

        if string.sub(string.gsub(working_dir, "%s", ""), 1, 1) == "-" or string.gmatch(working_dir, "[^%-%w%s/\\]")() ~= nil then
            inst.branch_cache = ""
            return ""
        end

        local git_process = io.popen("git -C '" .. working_dir .. "' rev-parse --abbrev-ref HEAD 2> /dev/null")
        local read_branch = git_process:read("l*")
        if not git_process:close() or read_branch == nil then
            inst.branch_cache = ""
        else
            inst.branch_cache = "   " ..  read_branch .. " "
        end
    end

    return inst.branch_cache
end

function M.get_instance()
    local buf_id = vim.api.nvim_win_get_buf(0)
    if buffer_instances[buf_id] == nil then
        buffer_instances[buf_id] = {branch_cache = '', branch_cache_timestamp = 0}
    end
    return buffer_instances[buf_id]
end

function M.statusline()
    local parts = {
        -- git branch
        [[%<%#Search#%{luaeval("require'statusline'.git_branch(require'statusline'.get_instance())")}%* ]],

        -- file or lsp status (duh)
        [[%{luaeval("require'statusline'.file_or_lsp_status()")} %m%r%=]],

        -- %# starts a highlight group; Another # indicates the end of the highlight group name
        -- This causes the next content to display in colors (depending on the color scheme)
        "%#warningmsg#",

        -- vimL expressions can be placed into `%{ ... }` blocks
        -- The expression uses a conditional (ternary) operator: <condition> ? <truthy> : <falsy>
        -- If the current file format is not 'unix', display it surrounded by [], otherwise show nothing
        "%{&ff!='unix'?'['.&ff.'] ':''}",

        -- Resets the highlight group
        "%*",

        "%#warningmsg#",
        -- Same as before with the file format, except for the file encoding and checking for `utf-8`
        "%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.'] ':''}",
        "%*",

        -- nvim-navic
        [[ %{%v:lua.require'nvim-navic'.get_location()%} ]],

        -- diagnostic errors/warnings
        [[%{luaeval("require'statusline'.diagnostic_status()")}]],

        -- line number and position
        [[  %-14.(%l,%c%V%) %P]],
    }

    return table.concat(parts, '')
end

return M
