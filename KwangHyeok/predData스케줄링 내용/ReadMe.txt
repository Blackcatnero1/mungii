pip 설치 내용
 - pandas
 - scikit-learn
 - tensorflow

사용 방법
 - DB에 WEATHER_FORECAST 테이블이 있다면 삭제
 - localDB.ipynb에서 (# 일기예보 테이블 만들기) 실행
 - DB에 WEATHER_FORECAST 테이블이 정상적으로 만들어졌는지 확인
 - predData와 predDataSet 폴더를 urls.py와 동일한 레벨에 넣기
 - settings.py에서 
	MEDIA_URL = '/predDataSet/'
	MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')
   추가

 - predData의 make_PredData의 from misProject.~ 부분 프로젝트 폴더 이름으로 변경

 - views, urls 설정 내용
 [views.py]
from django.http import HttpResponse
from misProject.predData.make_PredData import makePreData

def make_PredData(request):
    makePreData()  # make_PredData 함수 호출
    return HttpResponse("make_PredData 함수가 실행되었습니다.")

 [urls.py]
from django.urls import path
from misProject import views

urlpatterns = [
    path('weatherScheduler.mis/', views.make_PredData, name='getScheduler'),
]

