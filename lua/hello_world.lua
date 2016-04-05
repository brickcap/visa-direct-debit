local helpers = require("lua/helpers")
helpers.set_common_headers()
local hello_res = ngx.location.capture(url.."vdp/helloworld")
ngx.status =hello_res.status
ngx.say(hello_res.body)
