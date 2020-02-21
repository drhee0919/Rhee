import requests 
url = 'http://70.12.116.160:8080/login/login.html'
r = requests.request('get', url )     #get방식으로 요청
r.encoding = 'utf-8'
print(type(r))
if r.text :
    print(r.text)
else :
    print("응답 컨텐츠가 없습니다.")

r = requests.request('head', url )  #head방식으로 요청
r.encoding = 'utf-8'
print(type(r))
if r.text :
    print(r.text)
else :
    print("응답 컨텐츠가 없습니다.")

params =  {'userid': '홍길동', 'userpwd': 1234 }
url = 'http://70.12.116.160:8080/login/data.jsp'
r = requests.request('post', url , data=params)   #post방식으로 요청
r.encoding = 'utf-8'
print(type(r))
if r.text :
    print(r.text)
else :
    print("응답 컨텐츠가 없습니다.")
    