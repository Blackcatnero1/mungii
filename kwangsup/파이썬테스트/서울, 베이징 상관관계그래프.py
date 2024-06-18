# 서울, 베이징 상관관계 그래프, 표 만들기

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 데이터 불러오기
seoul_data = pd.read_csv('D:\FILE\\서울.csv')
beijing_data = pd.read_csv('D:\FILE\베이징.csv')

# 열 이름의 공백 제거
seoul_data.columns = seoul_data.columns.str.strip()
beijing_data.columns = beijing_data.columns.str.strip()

# 날짜 열을 datetime 형식으로 변환
seoul_data['date'] = pd.to_datetime(seoul_data['date'])
beijing_data['date'] = pd.to_datetime(beijing_data['date'])

# 열을 숫자로 변환하며, 변환 오류를 NaN으로 설정
for col in ['pm25', 'pm10', 'o3', 'no2', 'so2', 'co']:
    seoul_data[col] = pd.to_numeric(seoul_data[col], errors='coerce')
    beijing_data[col] = pd.to_numeric(beijing_data[col], errors='coerce')

# 날짜 열을 기준으로 데이터셋 병합
merged_data = pd.merge(seoul_data, beijing_data, on='date', suffixes=('_seoul', '_beijing'))

# 어떤 열이든 NaN 값을 포함하는 행 제거
merged_data = merged_data.dropna()

# 상관관계 행렬 계산
correlation_matrix = merged_data[['pm25_seoul', 'pm25_beijing', 'pm10_seoul', 'pm10_beijing', 
                                  'o3_seoul', 'o3_beijing', 'no2_seoul', 'no2_beijing', 
                                  'so2_seoul', 'so2_beijing', 'co_seoul', 'co_beijing']].corr()

# 상관관계 행렬 시각화
plt.figure(figsize=(12, 8))
sns.heatmap(correlation_matrix, annot=True, fmt=".2f", cmap='coolwarm', vmin=-1, vmax=1)
plt.title('서울과 베이징 대기오염물질 간 상관관계 행렬')
plt.show()

# 각 대기오염물질에 대한 산점도 그리기
pollutants = ['pm25', 'pm10', 'o3', 'no2', 'so2', 'co']

for pollutant in pollutants:
    plt.rcParams['font.family'] = 'D2coding'
    plt.figure(figsize=(10, 6))
    plt.scatter(merged_data[f'{pollutant}_seoul'], merged_data[f'{pollutant}_beijing'], alpha=0.5)
    correlation = merged_data[f'{pollutant}_seoul'].corr(merged_data[f'{pollutant}_beijing'])
    plt.title(f'서울과 베이징의 {pollutant.upper()} 농도 간 상관관계\n상관관계 계수: {correlation:.2f}')
    plt.xlabel(f'서울의 {pollutant.upper()}')
    plt.ylabel(f'베이징의 {pollutant.upper()}')
    plt.grid(True)
    plt.show()

# 상관관계 행렬 출력
correlation_matrix