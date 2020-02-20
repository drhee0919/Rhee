import urllib.request 
res = urllib.request.urlopen("http://70.12.116.160:8080/login/login.html")
print(res)
res_header = res.getheaders()
print("[header 정보]##############")
for s in res_header:
    print(s)

print("[body 정보]##############")
print(res.read().decode('utf-8')) 


