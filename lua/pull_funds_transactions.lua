local helpers = require("lua/helpers")
helpers.set_common_headers()
local pull_funds_res = ngx.location.catpure("/visa_sandbox/fundstransfer/v1/pullfundstransactions")
