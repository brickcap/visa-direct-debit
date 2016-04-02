local helpers = require("helpers")
local validate = require("lua/lua-resty-validation/lib/resty/validation")
local country_codes,currency_codes = require("lua/access/country_codes"),require("lua/access/currency_codes")
--note the address should be populated by the zip code lookup on google maps api
-- {
--   "acquirerCountryCode"= "840",
--   "acquiringBin": "408999",
--   "amount": "124.02",
--   "businessApplicationId": "AA",
--   "cardAcceptor": {
--     "address": {
--       "country": "USA",
--       "county": "San Mateo",
--       "state": "CA",
--       "zipCode": "94404"
--     },
--     "idCode": "ABCD1234ABCD123",
--     "name": "Visa Inc. USA-Foster City",
--     "terminalId": "ABCD1234"
--   },
--   "cavv": "0700100038238906000013405823891061668252",
--   "foreignExchangeFeeTransaction": "11.99",
--   "localTransactionDateTime": "2016-04-02T08:41:14",
--   "retrievalReferenceNumber": "330000550000"[required],
--   "senderCardExpiryDate": "2015-10",
--   "senderCurrencyCode": "USD",
--   "senderPrimaryAccountNumber": "4895142232120006",
--   "surcharge": "11.99",
--   "systemsTraceAuditNumber": "451001" [required 6 digits integer]
-- }
ngx.req.read_body()
local post_args = ngx.req.get_post_args()

if not validate:len(6,11)(post_args.acquiringBin) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid acquiringBin")
end
if not helpers.has_value(country_codes,post_args.acquirerCountryCode) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid acquirerCountryCode ")
end

if validate:len(13,19)(post_args.senderPrimaryAccountNumber) then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid senderPrimaryAccountNumber")
end

if post_args.senderCardExpiryDate=='' or post_args.senderCardExpiryDate==nil then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid senderCardExpiryDate")
end

if not helpers.has_value(currency_codes,post_args.senderCurrencyCode) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid senderCardExpiryDate")
end

if validate:nan()(post_args.amount) then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid amount")
end


if (post_args.surcharge~=nil or post_args.surcharge~='') and validate:nan()(post_args.surcharge) then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid surcharge")
end

if(post_args.cavv~=nil or post_args.cavv~='') and not validate:len(40,40)(post_args.cavv) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid cavv")
end

if(post_args.foreignExchangeFeeTransaction~=nil or post_args.foreignExchangeFeeTransaction~='') 
and  validate:nan()(post_args.foreignExchangeFeeTransaction) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid foreignExchangeFeeTransaction")
end

if not has_value(business_app_id,post_args.businessApplicationId) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid businessApplicationId")
end

if (post_args.merchantCategoryCode~=nil or post_args.merchantCategoryCode~='') and 
not validate:len(4,4)(post_args.merchantCategoryCode) then
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid merchantCategoryCode")
end

if post_args.cardAcceptor.terminalId==nil or post_args.cardAcceptor.terminalId=='' or 
not validate:len(1,8)(post_args.cardAcceptor.terminalId)then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid terminalId")
end


if post_args.cardAcceptor.name==nil or post_args.cardAcceptor.name=='' or 
not validate:len(1,25)(post_args.cardAcceptor.name)then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid name")
end

if post_args.cardAcceptor.idCode==nil or post_args.cardAcceptor.idCode=='' or 
not validate:len(1,25)(post_args.cardAcceptor.idCode)then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid idCode")
end

if has_value(country_codes,post_args.cardAcceptor.address.country)then 
   ngx.status = ngx.HTTP_BAD_REQUEST
   ngx.say("Invalid idCode")
end

if post_args.cardAcceptor.address.country == 'USA' or post_args.cardAcceptor.address.country == 'CAN' then
   if post_args.cardAcceptor.address.county == nil or post_args.cardAcceptor.address.county == '' 
      or post_args.cardAcceptor.address.state == nil or post_args.cardAcceptor.address.state == '' 
   or validate:len(2,2)(post_args.cardAcceptor.address.state) then
      ngx.status = ngx.HTTP_BAD_REQUEST
      ngx.say("Invalid address")
   end
end

post_args.systemsTraceAuditNumber = math.random(0,999999)
post_args.retrievalReferenceNumber = helpers.get_retreival_ref_no(systemsTraceAuditNumber)
post_args.localTransactionDateTime = os.date("%Y-%m-%dT%H:%M:%S")
