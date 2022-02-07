-- local lunajson = require"libraries.lunajson"
-- local request = require "http.request"
-- local header = require "http.headers"
local URL

-- sumneko_root_path = os.getenv("HOME") .. "/language-servers/lua/"
print(os.getenv("USERPROFILE"))

-- local function check_ss_engine(file)
--   local f = io.open(file, "rb")
--   local jsonString = f:read "*a"
--   if f == nil then
--     return
--   else
--     -- let's get the SS engine port
--   local t = lunajson.decode(jsonString)
--   URL = "http://" .. t.address
--   end
-- end

-- local function send_to_ss(additionalURL, data)
--   print("sending request to " .. URL .. additionalURL)
--   local req = request.new_from_uri(URL .. additionalURL)
--   local req_body = data
--   local json_data = lunajson.encode(data)
--   print()
--   if req_body then
--     req.headers:upsert(":method", "POST")
--     req:set_body(json_data)
--   end

--   req.go(req, 1000)
-- end

-- light_body = {
--   ['device-type'] = "keyboard",
--   ['zone'] = "main-keyboard",
--   ['custom-zone-keys'] = '[26,4,22,7]',
--   ['mode'] = "color",
--   ['color'] = {
--     red = 255,
--     green = 0,
--     blue = 0
--   },
--   -- ['rate'] = "something",
--   ['context-frame-key'] = "something",
-- }

-- check_ss_engine("/mnt/c/ProgramData/SteelSeries/SteelSeries Engine 3/coreProps.json")
-- send_to_ss("/game_metadata", {
--   game = "Neovim",
--   game_display_name = "Vim"
-- })
-- print('req sent')
