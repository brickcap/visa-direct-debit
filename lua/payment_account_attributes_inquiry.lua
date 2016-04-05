--https://sandbox.api.visa.com/paai/fundstransferattinq/v1/cardattributes/fundstransferinquiry

local post_args = ngx.ctx.post_args
local payment_attributes_res = ngx.location.capture(
   url.."paai/fundstransferattinq/v1/cardattributes/fundstransferinquiry",
   {method=ngx.HTTP_POST,body=cjson.encode(post_args)})

local payment_attributes = cjson.decode(payment_attributes_res.body)

payment_attributes.systemsTraceAuditNumber = post_args.systemsTraceAuditNumber
payment_attributes.retrievalReferenceNumber = post_args.retrievalReferenceNumber

ngx.status = payment_attributes_res.status
ngx.header.content_type = payment_attributes_res.header["Content-Type"]
ngx.say(cjson.encode({status="success",data=payment_attributes}))

