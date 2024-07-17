from django.shortcuts import render
from django.http import HttpResponse
from django.http import JsonResponse
from django.views.generic import TemplateView
import pandas as pd
import oracledb as db
from sqlalchemy import create_engine
from datetime import datetime
import oracledb as db
from flask import Flask, request, jsonify
import pandas as pd
import random
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import pandas as pd
from setuptools import find_packages, setup
from io import BytesIO
import base64
from django.views.decorators.http import require_GET
import mplcursors

# Create your views here.
def mise(req):
    return render(req, 'pred.html', {})


#@require_GET
def get_data(request):
    if request.method == 'GET':
        Areaselect = request.GET.get('Areaselect')
        dateSelect1 = request.GET.get('dateSelect1')
        timeSelect1 = request.GET.get('timeSelect1')
        dateSelect2 = request.GET.get('dateSelect2')
        timeSelect2 = request.GET.get('timeSelect2')

        # createChart 함수 호출하여 그래프 생성
        pred_chart = createChart(Areaselect, dateSelect1, timeSelect1, dateSelect2, timeSelect2)

        return HttpResponse(pred_chart)

    else:
        return HttpResponse({'error': 'GET method required'})


def createChart(Areaselect, dateSelect1, timeSelect1, dateSelect2, timeSelect2): 
    start_datetime_str = f"{dateSelect1} {timeSelect1}"
    start_date = datetime.strptime(start_datetime_str, '%Y-%m-%d %H:%M:%S')

    end_datetime_str = f"{dateSelect2} {timeSelect2}"
    end_date = datetime.strptime(end_datetime_str, '%Y-%m-%d %H:%M:%S')

    query = f"""
        SELECT ds, yhat, area
        FROM pred
        WHERE area LIKE '{Areaselect}%'
            AND ds BETWEEN TO_TIMESTAMP('{start_date}', 'YYYY-MM-DD HH24:MI:SS')
                   AND TO_TIMESTAMP('{end_date}', 'YYYY-MM-DD HH24:MI:SS')
        order by ds
        """
    db.init_oracle_client()
    engine = create_engine('oracle+oracledb://jennie:12345@localhost:1521/?service_name=xe')

    #오라클에 있는 데이터 불러오기
    pred_df = pd.read_sql_query(query, engine)

    #plt.rcParams['font.family'] ='D2Coding'
    plt.rcParams['font.family'] ='sans-serif' #matplotlib 기본폰트 설정
    filtered_df = pred_df[(pred_df['ds'] >= start_date) & (pred_df['ds'] <= end_date)]

    # 그래프 그리기
    plt.figure(figsize=(16, 10))

    # 기준선 추가
    plt.axhline(y=30, color='r', linestyle='--', linewidth=1)
    plt.axhline(y=90, color='r', linestyle='--', linewidth=1)
    plt.axhline(y=150, color='r', linestyle='--', linewidth=1)

    # yhat 값에 따라 색상 변경 및 해당 범위에 있는 부분만 그래프로 그리기
    for i in range(1, len(filtered_df)):
        yhat = filtered_df['yhat'].iloc[i]
        if yhat <= 30:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='b')
            plt.axhspan(0, 30, facecolor='lightblue', alpha=0.3)
        elif yhat <= 90:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='g')
            plt.axhspan(30, max(filtered_df['yhat'])+1, facecolor='lightgreen', alpha=0.3)
        elif yhat <= 150:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='y')
            plt.axhspan(90, max(filtered_df['yhat'])+1, facecolor='lightyellow', alpha=0.3)
        else:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='r')


    #plt.xlabel('날짜')
    #plt.ylabel('미세먼지 농도(PM10)')
    #plt.title('지역 미세먼지 농도(PM10) 예측치(단위: ㎍/m³)')
    plt.xticks(rotation=45)
    plt.rcParams.update({'font.size': 14})
    plt.grid(True)
    plt.tight_layout(pad=2.0) 

    # X축 날짜 형식 설정
    # 아래쪽에는 1시간 간격으로 시간을 표시
    ax_bottom = plt.gca()
    ax_bottom.xaxis.set_major_locator(mdates.HourLocator(interval=1))
    ax_bottom.xaxis.set_major_formatter(mdates.DateFormatter('%H'))
    ax_bottom.tick_params(axis='x', rotation=0, labelsize=12)

    # 위쪽에는 1일 간격으로 날짜를 표시
    ax_top = ax_bottom.twiny()
    ax_top.xaxis.set_major_locator(mdates.DayLocator(interval=1))
    ax_top.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    ax_top.tick_params(axis='x', rotation=0, labelsize=12)
    
    # x축과 y축 범위 설정
    plt.xlim(filtered_df['ds'].min(), filtered_df['ds'].max())
    plt.ylim(filtered_df['yhat'].min() - 1, filtered_df['yhat'].max() + 1)

    # 그래프를 base64로 인코딩하여 반환
    buffer = BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)
    pred_chart = base64.b64encode(buffer.getvalue()).decode('utf-8')
    plt.close()

    return pred_chart

#@require_GET
def compare(request):
    if request.method == 'GET':
        Areaselect = request.GET.get('Areaselect')
        dateSelect1 = request.GET.get('dateSelect1')
        timeSelect1 = request.GET.get('timeSelect1')
        dateSelect2 = request.GET.get('dateSelect2')
        timeSelect2 = request.GET.get('timeSelect2')

        # createChart 함수 호출하여 그래프 생성
        compare_result = compareChart(Areaselect, dateSelect1, timeSelect1, dateSelect2, timeSelect2)

        return HttpResponse(compare_result)

    else:
        return HttpResponse({'error': 'GET method required'})


def compareChart(Areaselect, dateSelect1, timeSelect1, dateSelect2, timeSelect2): 
    start_datetime_str = f"{dateSelect1} {timeSelect1}"
    start_date = datetime.strptime(start_datetime_str, '%Y-%m-%d %H:%M:%S')

    end_datetime_str = f"{dateSelect2} {timeSelect2}"
    end_date = datetime.strptime(end_datetime_str, '%Y-%m-%d %H:%M:%S')

    query = f"""
        SELECT ds, yhat, area
        FROM pred
        WHERE area LIKE '{Areaselect}%'
            AND ds BETWEEN TO_TIMESTAMP('{start_date}', 'YYYY-MM-DD HH24:MI:SS')
                   AND TO_TIMESTAMP('{end_date}', 'YYYY-MM-DD HH24:MI:SS')
        order by ds
        """
    db.init_oracle_client()
    engine = create_engine('oracle+oracledb://jennie:12345@localhost:1521/?service_name=xe')

    #오라클에 있는 데이터 불러오기
    pred_df = pd.read_sql_query(query, engine)

    # area 별 yhat 평균 계산
    avg_yhat = pred_df.groupby('area')['yhat'].mean().reset_index()
    avg_yhat_sorted = avg_yhat.sort_values(by='yhat', ascending=False)

	# 막대그래프 그리기
    plt.rcParams['font.family'] ='D2Coding'
    #plt.rcParams['font.family'] ='sans-serif' #matplotlib 기본폰트 설정
    plt.figure(figsize=(13, 8))
    bars =plt.bar(avg_yhat_sorted['area'], avg_yhat_sorted['yhat'], color='skyblue')
    #plt.xlabel('지역', fontsize=12)
    #plt.ylabel('미세먼지농도(PM10)', fontsize=12)
    #plt.title(f'{co_area} 미세먼지 농도(PM10) 예측치(단위: ㎍/m³)')
    plt.xticks(rotation=45, ha='right')
    plt.rcParams.update({'font.size': 14})
    plt.grid(True)
    plt.tight_layout(pad=2.0) 

    # 각 막대 위에 평균 값을 텍스트로 표시
    for i, bar in enumerate(bars):
        plt.text(bar.get_x() + bar.get_width() / 2, 
                bar.get_height() + 0.5,  # 텍스트 위치 조정
                f'{int(avg_yhat_sorted["yhat"].iloc[i])}',
                ha='center', va='bottom', fontsize=9)
        
    # 그래프를 base64로 인코딩하여 반환
    buffer = BytesIO()
    plt.savefig(buffer, format='png')
    buffer.seek(0)
    compare_result = base64.b64encode(buffer.getvalue()).decode('utf-8')
    plt.close()

    return compare_result