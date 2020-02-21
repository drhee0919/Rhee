# 파라미터를 url에 함께 전송 요청하고 응답 출력 실습 
import urllib.request 
import urllib.parse

params = urllib.parse.urlencode({'userid': '홍길동', 'userpwd': 1234 })
print('URL 인코딩이 적용된 문자열 : %s' %params)
url = 'http://70.12.116.160:8080/login/data.jsp?%s' % params
with urllib.request.urlopen(url) as f:
	print(f.read().decode('utf-8'))