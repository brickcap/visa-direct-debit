local helpers = require("lua/helpers")
local validate = require("lua/lua-resty-validation/lib/resty/validation")
ngx.req.read_body()
local body_data = ngx.req.get_body_data()
local post_args = cjson.decode(body_data)
post_args.systemsTraceAuditNumber = math.random(0,999999)
post_args.retrievalReferenceNumber = helpers.get_retreival_ref_no(post_args.systemsTraceAuditNumber)
-- primary account number is the no on the credit card (not the bank number)
if post_args.primaryAccountNumber == nil or post_args.primaryAccountNumber=='' then 
ngx.status = ngx.HTTP_BAD_REQUEST
ngx.say("Invalid primaryAccountNumber")
else
   helpers.set_common_headers()
   ngx.ctx.post_args = post_args
   ngx.exit(ngx.OK)
end
