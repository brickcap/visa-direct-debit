local _M = {}

function _M.set_common_headers()
   local base_64_auth_headers = "Basic "..ngx.encode_base64(uname_pass)
   ngx.req.set_header("Authorization",base_64_auth_headers)
   ngx.req.set_header("Content-Type","application/json")
   ngx.req.set_header("Accept","application/json")
end

function _M.get_retreival_ref_no(systemsTraceAuditNumber)
   local date = os.date("*t")
   local year,month,day,hour = tostring(date.year),tostring(date.month),tostring(date.yday),tostring(date.hour)
   local j_yday,j_year,j_hour = '','',''
   if string.len(hour)==1 then 
      j_hour = "0"..hour
   else 
      j_hour=hour
   end

   if string.len(day)==2 then
      j_yday = "0"..day
   elseif string.len(day)==1 then
      j_yday = "00"..day
   else 
      j_yday = day
   end
   j_year = string.sub(year,-1,-1)   
   return j_year..j_yday..j_hour..tostring(systemsTraceAuditNumber)
end
-- ngx.log(ngx.ERR,cjson.encode(os.date("*t")))
-- ngx.log(ngx.ERR,_M.get_retreival_ref_no(123456))
return _M;
