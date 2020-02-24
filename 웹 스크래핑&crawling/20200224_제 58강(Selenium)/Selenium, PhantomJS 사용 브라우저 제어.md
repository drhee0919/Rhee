#### Selenium Chrome Driver 사용 브라우저 제어

```python
from selenium import webdriver 

chrom_driver = webdriver.Chrome('C:\Users\student\chromedriver.exe')
chrom_driver.implicitly_wait(3)
chrom_driver.get('https://google.com')
chrom_driver.save_screenshot('./output/google_site.png')
chrom_driver.close()
```



#### PhantomJS 사용 브라우저 제어 

```python
from selenium import webdriver
url = "http://www.naver.com"
browser = webdriver.PhantomJS('C:/Users/student/phantomjs/bin/phantomjs.exe')
browser.implicitly_wait(3)  #3초 대기
browser.get("http://www.naver.com") #url 요청
browser.save_screenshot('./output/naver_site.png')  #실행된 브라우저화면 저장
browser.quit()

```



