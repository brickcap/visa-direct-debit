local helpers = require("helpers")
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
local systemsTraceAuditNumber = math.random(0,999999)
local retrievalReferenceNumber = helpers.get_retreival_ref_no(systemsTraceAuditNumber)
