local helpers = require("helpers")
local validate = require("lua/lua-resty-validation/lib/resty/validation")
ngx.req.read_body()
local post_args = ngx.req.get_post_args()
post_args.systemsTraceAuditNumber = math.random(0,999999)
post_args.retrievalReferenceNumber = helpers.get_retreival_ref_no(systemsTraceAuditNumber)

if post_args.primaryAccountNumber == nil or post_args.primaryAccountNumber=='' then 
ngx.status = ngx.HTTP_BAD_REQUEST
ngx.say("Invalid primaryAccountNumber")
else
   ngx.exit(ngx.OK)
end
