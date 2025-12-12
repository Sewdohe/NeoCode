-- Update Checker for NeoCode
-- Checks GitHub for new versions and prompts user to update

local M = {}

local function get_repo_dir()
    -- Find the actual git repo directory by following symlinks
    -- The config dir is symlinked from nvim-config/, we need the parent (repo root)
    local config_dir = vim.fn.stdpath("config")

    -- Try to resolve the symlink for init.lua to find the real location
    local init_lua = config_dir .. "/init.lua"
    local real_init = vim.loop.fs_realpath(init_lua)

    if real_init then
        -- real_init should be something like /path/to/NeoCode/nvim-config/init.lua
        -- We want /path/to/NeoCode (parent of nvim-config)
        local nvim_config_dir = vim.fn.fnamemodify(real_init, ":h")  -- Gets directory of init.lua
        local repo_dir = vim.fn.fnamemodify(nvim_config_dir, ":h")   -- Gets parent (repo root)
        return repo_dir
    end

    -- Fallback to config dir (for non-symlinked installations)
    return config_dir
end

local function get_local_commit()
    -- Get the current git commit hash of the NeoCode config
    local repo_dir = get_repo_dir()
    local handle = io.popen(string.format("cd '%s' && git rev-parse HEAD 2>/dev/null", repo_dir))
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

    -- Check once every 6 hours (21600 seconds) - reduced from 24h
    local current_time = os.time()
    local cooldown = 21600
    return (current_time - last_check) > cooldown
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
        local repo_dir = get_repo_dir()
        local cmd = string.format("cd '%s' && git pull origin main", repo_dir)
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
        -- Not a git repo, skip silently
        return
    end

    -- Schedule the check to run asynchronously
    vim.schedule(function()
        local remote_commit = get_remote_commit()

        if not remote_commit then
            -- Couldn't reach GitHub, skip silently
            return
        end

        if local_commit ~= remote_commit then
            prompt_and_update()
        else
            -- Up to date, update marker silently
            update_check_marker()
        end
    end)
end

-- Force check regardless of time
function M.force_check()
    local local_commit = get_local_commit()
    if not local_commit then
        vim.notify("NeoCode is not in a git repository. Cannot check for updates.", vim.log.levels.WARN)
        return
    end

    vim.notify("Checking for NeoCode updates...", vim.log.levels.INFO)

    vim.schedule(function()
        local remote_commit = get_remote_commit()

        if not remote_commit then
            vim.notify("Could not reach GitHub to check for updates.", vim.log.levels.WARN)
            return
        end

        if local_commit ~= remote_commit then
            vim.notify("Update available!", vim.log.levels.INFO)
            prompt_and_update()
        else
            vim.notify("NeoCode is up to date!", vim.log.levels.INFO)
            update_check_marker()
        end
    end)
end

return M
