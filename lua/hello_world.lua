local config = require("lua/config_main").visa_config
local unname_pass = ''
if test then
   uname_pass = config.username_sand..":"..config.password_sand
else
   uname_prod = config.username_prod..":"..config.password_prod
end
local base_64_auth_headers = "Basic "..ngx.encode_base64(uname_pass)
ngx.req.set_header("Authorization",base_64_auth_headers)
local hello_res = ngx.location.capture("/visa_sandbox/vdp/helloworld")
ngx.status =hello_res.status
ngx.say(hello_res.body)
