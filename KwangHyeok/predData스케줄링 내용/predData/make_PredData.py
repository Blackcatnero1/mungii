from selenium import webdriver
from selenium.webdriver.common.by import By
from misProject.predData.make_Scalere import make_standScaler, make_pm25testScaler, make_pm10testScaler 
from misProject.predData.make_coData import make_coModel, pred_co 
from misProject.predData.make_noData import make_noModel, pred_no
from misProject.predData.make_ozData import make_ozModel, pred_oz
from misProject.predData.make_soData import make_soModel, pred_so 
from misProject.predData.make_pm25Data import make_pm25Model, pred_pm25 
from misProject.predData.make_pm10Data import make_pm10Model, pred_pm10
from sqlalchemy import create_engine, text

import cx_Oracle
import time
import datetime
import pandas as pd
import os

# BASE_DIR과 MEDIA_ROOT 설정이 제대로 되어 있는지 확인
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')

def makePreData():
    # 지역 데이터
    localCode = {
        '강남구':1168066000,
        '강동구':1174051500,
        '강북구':1130553500,
        '강서구':1150060300,
        '관악구':1162058500,
        '광진구':1121581000,
        '구로구':1153059500,
        '금천구':1154551000,
        '노원구':1135059500,
        '도봉구':1132052100,
        '동대문구':1123060000,
        '동작구':1159051000,
        '마포구':1144056500,
        '서대문구':1141069000,
        '서초구':1165066000,
        '성동구':1120059000,
        '성복구':1129066000,
        '송파구':1171063100,
        '양천구':1147051000,
        '영등포구':1156055000,
        '용산구':1117053000,
        '은평구':1138055100,
        '종로구':1111060000,
        '중구':1114059000,
        '중랑구':1126065500
    }

    # 서울시 날씨 클롤링
    driver = webdriver.Chrome()
    localWheather_arr = []
    cnt = 1
    day_cnt = 3

    sc = make_standScaler()
    oz_model = make_ozModel(sc)
    no_model = make_noModel(sc)
    co_model = make_coModel(sc)
    so_model = make_soModel(sc)

    pm10_scaler = make_pm10testScaler()
    pm10_model = make_pm10Model(pm10_scaler)
    pm25_scaler = make_pm25testScaler()
    pm25_model = make_pm25Model(pm25_scaler)

    for key in localCode:
        code = localCode.get(key)
        driver.get(f'https://www.weather.go.kr/w/weather/forecast/short-term.do#dong/{code}')

        go_table = 2
        time.sleep(3)
        # 표로 보기
        test = driver.find_elements(By.CSS_SELECTOR, '#digital-forecast > .cmp-dfs-slider > .dfs-tab > .right > .btns > .btn-wrap > a')[go_table].click() 

        # 4일치 데이터
        for i in range(1, 4):
            total_temp = 0
            total_rain = 0
            total_hum = 0
            total_wind = 0
            total_wdeg = 0
            max_wind = 0
            # 확인 날짜 클릭
            test = driver.find_elements(By.CSS_SELECTOR, '#digital-forecast > .cmp-dfs-slider > .dfs-daily-slider-body > .dfs-daily-slider > div > div')[i].click()
            # 날짜 가져오기
            test = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .daily-head > span')[0].text

            # 날짜 데이터 가공
            day_slice = test.find('일')
            day = test[0:day_slice]
            if len(day) == 1:
                day = '0' + day
            now = datetime.datetime.now()
            date = now.strftime("%Y-%m-%d")
            date = date[0:8]
            format_date = date+day

            # 최고 최저 기온
            tmin = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-daily-slider-body > .dfs-daily-slider > div > div:nth-child({i}) > .dfs-daily-slide-box > .dfs-daily-item > .daily-minmax > div:nth-child(1) > span')[0].text
            tmax = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-daily-slider-body > .dfs-daily-slider > div > div:nth-child({i}) > .dfs-daily-slide-box > .dfs-daily-item > .daily-minmax > div:nth-child(2) > span')[0].text
            rainP_am = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-daily-slider-body > .dfs-daily-slider > div > div:nth-child({i}) > .dfs-daily-slide-box > .dfs-daily-item > .daily-pop-am > span')[0].text
            if rainP_am == '-':
                rainP_am = '0%'
            rainP_pm = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-daily-slider-body > .dfs-daily-slider > div > div:nth-child({i}) > .dfs-daily-slide-box > .dfs-daily-item > .daily-pop-pm > span')[0].text
            if rainP_pm == '-':
                rainP_pm = '0%'

            # 시간 변수(24시간)
            ul_cnt = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul')
            hour = len(ul_cnt)

            for j in range(1, hour+1):
                # 기온 합
                span_Tempval = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul:nth-child({j}) > li:nth-child(3) > span')[1]
                script = """
                    arguments[0].className = '';
                    return arguments[0].textContent.trim();
                    """
                span_Tempval = driver.execute_script(script, span_Tempval)
                hour_slice = span_Tempval.find('℃')
                span_Tempval = int(span_Tempval[0:hour_slice])
                total_temp += span_Tempval

                # 강수량 합
                span_Rainval = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul:nth-child({j}) > li:nth-child(5) > span')[1].text
                findChar = span_Rainval.find('~')
                if span_Rainval == '-' or span_Rainval == '':
                    span_Rainval = 0
                elif findChar == 0:
                    span_Rainval = span_Rainval[1:-2]
                elif findChar > 0:
                    span_Rainval = span_Rainval[0:-2]
                    span_Rainval = span_Rainval.replace('~', '+')
                    span_Rainval = eval(span_Rainval) / 2
                else :
                    span_Rainval = span_Rainval[0:-2]
                total_rain += int(span_Rainval)

                # 풍향 풍속 합
                span_Wdegval = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul:nth-child({j}) > li:nth-child(7) > span')[1].text
                span_Windval = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul:nth-child({j}) > li:nth-child(7) > span')[2].text

                if span_Wdegval == '동풍':
                    span_Wdegval = 90
                elif span_Wdegval == '남동풍':
                    span_Wdegval = 135
                elif span_Wdegval == '남풍':
                    span_Wdegval = 180
                elif span_Wdegval == '남서풍':
                    span_Wdegval = 225
                elif span_Wdegval == '서풍':
                    span_Wdegval = 270
                elif span_Wdegval == '북서풍':
                    span_Wdegval = 315
                elif span_Wdegval == '북풍':
                    span_Wdegval = 360
                elif span_Wdegval == '북동풍':
                    span_Wdegval = 45
                elif span_Wdegval == '바람없음풍':
                    span_Wdegval = 0

                wind_slice = span_Windval.find('m')
                span_Windval = int(span_Windval[0:wind_slice])
            
                if max_wind < span_Windval:
                    max_wind = span_Windval
                total_wdeg += span_Wdegval
                total_wind += span_Windval
                
                # 습도 합
                span_Humval = driver.find_elements(By.CSS_SELECTOR, f'#digital-forecast > .cmp-dfs-slider > .dfs-tab-body > .dfs-slider > .slide-wrap > div:nth-child({i+1}) > .daily > .item-wrap > ul:nth-child({j}) > li:nth-child(8) > span')[1].text
                span_Humval = int(span_Humval[0:-1])
                total_hum += span_Humval

            temp_avg = round(total_temp / hour, 2)
            rain_avg = round(total_rain / hour, 2)
            hum_avg = round(total_hum / hour, 2)
            wdeg_avg = round(total_wdeg / hour, 2)
            if 0 <= wdeg_avg <= 10:
                wdeg_avg += 360
            if 11 < wdeg_avg < 55:
                wdeg_avg = '북동풍'
            elif 56 < wdeg_avg < 100:
                wdeg_avg = '동풍'
            elif 101 < wdeg_avg < 145:
                wdeg_avg = '남동풍'
            elif 146 < wdeg_avg < 190:
                wdeg_avg = '남풍'
            elif 191 < wdeg_avg < 235:
                wdeg_avg = '남서풍'
            elif 236 < wdeg_avg < 280:
                wdeg_avg = '서풍'
            elif 281 < wdeg_avg < 325:
                wdeg_avg = '북서풍'
            elif 326 < wdeg_avg < 370:
                wdeg_avg = '북풍'

            wind_avg = round(total_wind / hour, 2)

            temp_max = tmax.find('℃')
            temp_max = float(tmax[:temp_max])
            temp_min = tmin.find('℃')
            temp_min = float(tmin[:temp_min])

            print('temp_min :', temp_min)
            print('temp_max :', temp_max)
            print('temp_avg :', temp_avg)
            print('rain_avg :', rain_avg)
            print('wdeg_avg :', wdeg_avg)
            print('wind_avg :', wind_avg)
            print('max_wind :', max_wind)
            print('hum_avg :', hum_avg)

            

            predOz = pred_oz(sc, oz_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg)
            predNo2 = pred_no(sc, no_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg)
            predco = pred_co(sc, co_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg)
            predso = pred_so(sc, so_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg)
            predPm10 = pred_pm10(pm10_scaler, pm10_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg, predOz, predNo2, predco, predso) 
            predPm25 = pred_pm25(pm25_scaler, pm25_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg, predOz, predNo2, predco, predso)

            localWheather_dic = {
                'code' : code,
                'name' : key,
                'fdate' : format_date,
                'temp_min' : tmin,
                'temp_max' : tmax,
                'temp_avg' : temp_avg,
                'rain_avg' : rain_avg,
                'wind_deg' : wdeg_avg,
                'wind_avg' : wind_avg,
                'wind_max' : max_wind,
                'hum_avg' : hum_avg,
                'rainp_am' : rainP_am,
                'rainp_pm' : rainP_pm,
                'pred_oz' : predOz,
                'pred_no2' : predNo2,
                'pred_co' : predco,
                'pred_so' : predso,
                'pred_pm10' : predPm10,
                'pred_pm25' : predPm25
            }
            localWheather_arr.append(localWheather_dic)
            
            print('[', key, format_date, '] 크롤링 완료', cnt, '/', len(localCode) * day_cnt)
            cnt += 1
    # 파일 경로를 MEDIA_ROOT를 사용하여 설정
    file_path = os.path.join(MEDIA_ROOT, 'local_TotalData.csv')
    pd.DataFrame(localWheather_arr).to_csv(file_path, index=False)

    # CSV 파일 읽기
    df1 = pd.read_csv(file_path)
    
    # 데이터베이스 연결 정보
    username = 'jennie'
    password = '12345'
    dsn = 'localhost:1521/xe'

    # cx_Oracle를 사용하여 데이터베이스에 연결
    connection = cx_Oracle.connect(username, password, dsn)
    cursor = connection.cursor()

    table_name = 'WEATHER_FORECAST'  # 사용할 테이블 이름

    # 데이터베이스에 연결하고 테이블의 모든 데이터 삭제
    delete_query = f"DELETE FROM {table_name}"
    cursor.execute(delete_query)
    connection.commit()

    # SQLAlchemy를 사용하여 데이터프레임을 테이블에 추가
    # cx_Oracle를 지원하는 SQLAlchemy 엔진 생성
    engine = create_engine(f'oracle+cx_oracle://{username}:{password}@{dsn}')

    # 데이터프레임을 테이블에 추가
    df1.to_sql(table_name, engine, if_exists='append', index=False)

    print(f"Data has been inserted into table {table_name}")

    # 연결 닫기
    cursor.close()
    connection.close()