local payment_attributes_res = ngx.location.capture(
   url.."paai/fundstransferattinq/v1/cardattributes/fundstransferinquiry",
   {method=ngx.HTTP_POST,body=cjson.encode(ngx.ctx.post_args)})
ngx.status = payment_attributes_res.status
ngx.say(payment_attributes_res.body)

--https://sandbox.api.visa.com/paai/fundstransferattinq/v1/cardattributes/fundstransferinquiry
