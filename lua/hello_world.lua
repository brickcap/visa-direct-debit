local base_64_auth_headers = "Basic "..ngx.encode_base64(uname_pass)
ngx.req.set_header("Authorization",base_64_auth_headers)
ngx.req.set_header("Content-Type","application/json")
ngx.req.set_header("Accept","application/json")

local hello_res = ngx.location.capture("/visa_sandbox/vdp/helloworld")
ngx.status =hello_res.status
ngx.say(hello_res.body)
