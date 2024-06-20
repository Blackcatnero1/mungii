import requests
from django.shortcuts import render
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import font_manager, rc
from django.http import HttpResponse
from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
import io
from flask import Flask, request, jsonify
import base64
import requests
import openpyxl

def index(request):
    return render(request, 'index.html')

# views.py

from django.shortcuts import render
import requests
from bs4 import BeautifulSoup



def test(request):
    url = 'https://www.iqair.com/ko/world-air-quality-ranking/cleanest-cities'

    # 웹페이지 가져오기
    html = requests.get(url)
    soup = BeautifulSoup(html.content, 'html.parser')

    # aqi-number 클래스를 가진 div 태그에서 값 추출
    aqi_values = []
    aqi_divs = soup.find_all('div', class_='aqi-number')
    for div in aqi_divs[:10]:
        aqi_values.append(div.text.strip())

    # country-flag 클래스를 가진 img 태그에서 alt 속성 값 추출
    alt_values = []
    img_tags = soup.find_all('img', class_='country-flag')
    for img_tag in img_tags[:10]:
        alt_values.append(img_tag.get('alt'))

    # 데이터를 템플릿으로 전달
    aqi_alt_values = zip(aqi_values, alt_values)
    
    
    url1 = 'https://www.iqair.com/ko/south-korea'

    # 웹페이지 가져오기
    html1 = requests.get(url1)
    soup1 = BeautifulSoup(html1.content, 'html.parser')

    # iqair-aqi-pill 클래스를 가진 모든 p 태그 선택
    pdata = []
    aqi_p = soup1.find_all('p', class_='iqair-aqi-pill')

    # 가장 마지막 p 태그 선택
    for i in aqi_p[10:20]:
        pdata.append(i.text.strip())

    # flag 클래스를 가진 모든 img 태그 선택
    flags = soup1.find_all('img', class_='flag')
    fdata = []
    # flag[11:20] 범위에 있는 각 img 태그의 형제 태그 중 a 태그의 값을 가져오기
    for flag in flags[10:20]:
        # 형제 태그 중에서 a 태그 찾기
        sibling_a = flag.find_next_sibling('a')
        a_value = sibling_a.text.strip()
        fdata.append(a_value)

    # 데이터를 템플릿으로 전달
    jdata_values = zip(fdata, pdata)
    context = {
        'aqi_alt_values': aqi_alt_values,
        'jdata_value': jdata_values
    }
    return render(request, 'boogi/test.html', context)

def Map(request):
    # 파일 경로
    xlsx_file_path = r'D:\study\python\booProj\boo\static\js\OpenDataCCTV.xlsx'

    # Excel 파일 읽기
    df = pd.read_excel(xlsx_file_path)
    # 'cctvid', 'cctvname', 'xcoord', 'ycoord' 열만 선택하여 새로운 데이터프레임 생성
    new_df = df[['CCTVID', 'CCTVNAME', 'XCOORD', 'YCOORD']]
    new_column_order = ['CCTVID', 'CCTVNAME', 'YCOORD', 'XCOORD']
    new_df = df.reindex(columns=new_column_order)
    new_df = new_df.rename(columns={'CCTVID': 'cctvid', 'CCTVNAME': 'cctvname', 'XCOORD': 'lon', 'YCOORD': 'lat'})
    # JSON 형식으로 변환
    json_data = new_df.to_json(orient='records')

    return render(request, 'boogi/Map.html', {'json_data': json_data})
