-- Update Checker for NeoCode
-- Checks GitHub for new versions and prompts user to update

local M = {}

local function get_local_commit()
    -- Get the current git commit hash of the NeoCode config
    local config_dir = vim.fn.stdpath("config")
    local handle = io.popen(string.format("cd '%s' && git rev-parse HEAD 2>/dev/null", config_dir))
    if not handle then
        return nil
    end
    local commit = handle:read("*a"):gsub("\n", "")
    handle:close()
    return commit ~= "" and commit or nil
end

local function get_remote_commit()
    -- Fetch the latest commit hash from GitHub
    local handle = io.popen("git ls-remote https://github.com/Sewdohe/NeoCode main 2>/dev/null")
    if not handle then
        return nil
    end
    local output = handle:read("*a")
    handle:close()
    
    if output == "" then
        return nil
    end
    
    -- ls-remote returns: <commit-hash> <ref>
    local remote_commit = output:match("^([a-f0-9]+)")
    return remote_commit
end

local function should_check_for_updates()
    -- Check if enough time has passed since last update check
    local config_dir = vim.fn.stdpath("config")
    local marker_file = config_dir .. "/.neocode_update_check"
    
    local last_check = 0
    if vim.fn.filereadable(marker_file) == 1 then
        local stat = vim.loop.fs_stat(marker_file)
        last_check = stat and stat.mtime.sec or 0
    end
    
    -- Check once every 24 hours (86400 seconds)
    local current_time = os.time()
    return (current_time - last_check) > 86400
end

local function update_check_marker()
    -- Update the timestamp of the last update check
    local config_dir = vim.fn.stdpath("config")
    local marker_file = config_dir .. "/.neocode_update_check"
    os.execute(string.format("touch '%s'", marker_file))
end

local function prompt_and_update()
    -- Prompt user and run git pull if they agree
    local choice = vim.fn.confirm(
        "A new version of NeoCode is available!\nWould you like to update?",
        "&Yes\n&No",
        2
    )
    
    if choice == 1 then
        local config_dir = vim.fn.stdpath("config")
        local cmd = string.format("cd '%s' && git pull origin main", config_dir)
        local handle = io.popen(cmd .. " 2>&1")
        if not handle then
            vim.notify("Failed to run git pull", vim.log.levels.ERROR)
            return
        end
        
        local output = handle:read("*a")
        handle:close()
        
        if output:match("Already up to date") or output:match("Fast-forward") or output:match("Merge made") then
            vim.notify("NeoCode updated successfully! Restart Neovim to apply changes.", vim.log.levels.INFO)
        else
            vim.notify("Update result:\n" .. output, vim.log.levels.WARN)
        end
        
        update_check_marker()
    end
end

function M.check()
    -- Main update check function
    -- Don't check if we're not in a git repo or if we checked recently
    if not should_check_for_updates() then
        return
    end
    
    local local_commit = get_local_commit()
    if not local_commit then
        -- Not a git repo, skip
        return
    end
    
    -- Schedule the check to run asynchronously
    vim.schedule(function()
        local remote_commit = get_remote_commit()
        
        if not remote_commit then
            -- Couldn't reach GitHub, skip
            return
        end
        
        if local_commit ~= remote_commit then
            prompt_and_update()
        else
            update_check_marker()
        end
    end)
end

return M
