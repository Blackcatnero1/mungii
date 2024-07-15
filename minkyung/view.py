import pandas as pd 
import matplotlib.pyplot as plt
import oracledb as db
from sqlalchemy import create_engine
from django.shortcuts import render
from datetime import datetime
import matplotlib.dates as mdates

#사용자가 입력한 값을 입력받으면,
area1 = '서울'
area2 = '전체'
month1 = 5
day1 = 6
hour1 = 6
month2 = 6
day2 = 2
hour2 = 18

#지역정보와 날짜정보 결합
co_area = area1 + ' ' + area2
start_date = datetime(2024, month1, day1, hour1)
end_date = datetime(2024, month2, day2, hour2)

#전체가 있느냐 없느냐에 따라서 
if area2 == '전체':
    co_area = area1 		#전체가 포함되어 있으면 시/도만 들어감(지역 전체 비교 진행)
else : 
    co_area = area1 + ' ' + area2  	#전체가 포함되어 있지 않으면 시/군/구 모두 들어감

#오라클 데이터베이스에 있는 데이터 불러오는 쿼리문 작성
query = f"""
        SELECT ds, yhat, area
        FROM pred
        WHERE area LIKE '{co_area}%'
            AND ds BETWEEN TO_TIMESTAMP('{start_date}', 'YYYY-MM-DD HH24:MI:SS')
                   AND TO_TIMESTAMP('{end_date}', 'YYYY-MM-DD HH24:MI:SS')
        order by ds
        """

#오라클과 연결하고,
db.init_oracle_client()
engine = create_engine('oracle+oracledb://jennie:12345@localhost:1521/?service_name=xe')

#오라클에 있는 데이터 불러오기
pred_df = pd.read_sql_query(query, engine)


#전체가 있느냐 없느냐에 따라서 다른 그래프 만들기
if area2 == '전체': 	#전체가 포함되어 있으면 시/도만 들어감(지역 전체 비교 진행)
    # area 별 yhat 평균 계산
    avg_yhat = pred_df.groupby('area')['yhat'].mean().reset_index()
    avg_yhat_sorted = avg_yhat.sort_values(by='yhat', ascending=False)

	# 막대그래프 그리기
    plt.figure(figsize=(10, 5))
    plt.bar(avg_yhat_sorted['area'], avg_yhat_sorted['yhat'], color='skyblue')
    plt.xlabel('지역', fontsize=12)
    plt.ylabel('미세먼지농도(PM10)', fontsize=12)
    plt.title(f'{co_area} 미세먼지 농도(PM10) 예측치(단위: ㎍/m³)')
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()
    plt.show()
	
else : 
    # 데이터 필터링
	filtered_df = pred_df[(pred_df['ds'] >= start_date) & (pred_df['ds'] <= end_date)]

	# 그래프 그리기
	plt.figure(figsize=(10, 5))

    # yhat 값에 따라 색상 변경, 기준선 추가
    for i in range(1, len(filtered_df)):
        if filtered_df['yhat'].iloc[i] <= 30:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='b')
            plt.axhspan(min(filtered_df['yhat']), 30, facecolor='lightblue', alpha=0.5)
        elif filtered_df['yhat'].iloc[i] > 30 and filtered_df['yhat'].iloc[i] <= 90:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='g')
            plt.axhspan(30, 90, facecolor='lightgreen', alpha=0.5)
            plt.axhline(y=30, color='r', linestyle='--', linewidth=1)
            plt.axhline(y=90, color='r', linestyle='--', linewidth=1)
        elif filtered_df['yhat'].iloc[i] > 90 and filtered_df['yhat'].iloc[i] <= 150:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='y')
            plt.axhspan(90, 150, facecolor='lightyellow', alpha=0.5)
            plt.axhline(y=90, color='r', linestyle='--', linewidth=1)
        else:
            plt.plot(filtered_df['ds'].iloc[i-1:i+1], filtered_df['yhat'].iloc[i-1:i+1], color='r')
            plt.axhline(150, max(filtered_df['yhat']), color='r', linestyle='--', linewidth=1)
        
        plt.xlabel('날짜')
        plt.ylabel('미세먼지 농도(PM10)')
        plt.title(f'{co_area} 미세먼지 농도(PM10) 예측치(단위: ㎍/m³)')
        plt.xticks(rotation=45)  # x축 레이블 회전
        plt.grid(True)
        plt.legend()
        plt.tight_layout()

        # X축 날짜 형식 설정
        ax = plt.gca()
        ax.xaxis.set_major_locator(mdates.DayLocator(interval=1))  # 날짜 간격을 1일로 설정
        ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))  # 날짜 형식을 '연도-월-일'로 설정

        plt.grid(True)
        plt.legend()
        plt.tight_layout()

        plt.show()