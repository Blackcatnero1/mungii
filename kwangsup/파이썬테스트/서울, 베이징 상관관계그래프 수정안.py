import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 데이터 불러오기
seoul_data = pd.read_csv('D:\FILE\\서울.csv')
beijing_data = pd.read_csv('D:\FILE\베이징.csv')
jinzhou_data = pd.read_csv('D:\FILE\진조우.csv')

# 열 이름의 공백 제거
seoul_data.columns = seoul_data.columns.str.strip()
beijing_data.columns = beijing_data.columns.str.strip()
jinzhou_data.columns = jinzhou_data.columns.str.strip()

# 날짜 열을 datetime 형식으로 변환
seoul_data['date'] = pd.to_datetime(seoul_data['date'])
beijing_data['date'] = pd.to_datetime(beijing_data['date'])
jinzhou_data['date'] = pd.to_datetime(jinzhou_data['date'])

# 열을 숫자로 변환하며, 변환 오류를 NaN으로 설정
for col in ['pm25', 'pm10', 'o3', 'no2', 'so2', 'co']:
    seoul_data[col] = pd.to_numeric(seoul_data[col], errors='coerce')
    beijing_data[col] = pd.to_numeric(beijing_data[col], errors='coerce')
    jinzhou_data[col] = pd.to_numeric(jinzhou_data[col], errors='coerce')

# 진조우 데이터의 열 이름에 '_jinzhou' 접두사 추가
jinzhou_data = jinzhou_data.rename(columns={
    'pm25': 'pm25_jinzhou',
    'pm10': 'pm10_jinzhou',
    'o3': 'o3_jinzhou',
    'no2': 'no2_jinzhou',
    'so2': 'so2_jinzhou',
    'co': 'co_jinzhou'
})

# 날짜 열을 기준으로 데이터셋 병합
merged_data = pd.merge(seoul_data, beijing_data, on='date', suffixes=('_seoul', '_beijing'))
merged_data = pd.merge(merged_data, jinzhou_data, on='date')

# 어떤 열이든 NaN 값을 포함하는 행 제거
merged_data = merged_data.dropna()

# 상관관계 행렬 계산
correlation_matrix = merged_data[['pm25_seoul', 'pm25_beijing', 'pm25_jinzhou', 
                                  'pm10_seoul', 'pm10_beijing', 'pm10_jinzhou',
                                  'o3_seoul', 'o3_beijing', 'o3_jinzhou',
                                  'no2_seoul', 'no2_beijing', 'no2_jinzhou',
                                  'so2_seoul', 'so2_beijing', 'so2_jinzhou',
                                  'co_seoul', 'co_beijing', 'co_jinzhou']].corr()

# 상관관계 행렬 시각화
plt.figure(figsize=(14, 10))
sns.heatmap(correlation_matrix, annot=True, fmt=".2f", cmap='coolwarm', vmin=-1, vmax=1)
plt.title('서울, 베이징, 진조우 대기오염물질 간 상관관계 행렬')
plt.show()

# 각 대기오염물질에 대한 산점도 그리기
pollutants = ['pm25', 'pm10', 'o3', 'no2', 'so2', 'co']

for pollutant in pollutants:
    plt.figure(figsize=(10, 6))
    plt.scatter(merged_data[f'{pollutant}_seoul'], merged_data[f'{pollutant}_beijing'], alpha=0.5, label='서울 vs 베이징')
    plt.scatter(merged_data[f'{pollutant}_seoul'], merged_data[f'{pollutant}_jinzhou'], alpha=0.5, label='서울 vs 진조우')
    plt.scatter(merged_data[f'{pollutant}_beijing'], merged_data[f'{pollutant}_jinzhou'], alpha=0.5, label='베이징 vs 진조우')
    correlation_seoul_beijing = merged_data[f'{pollutant}_seoul'].corr(merged_data[f'{pollutant}_beijing'])
    correlation_seoul_jinzhou = merged_data[f'{pollutant}_seoul'].corr(merged_data[f'{pollutant}_jinzhou'])
    correlation_beijing_jinzhou = merged_data[f'{pollutant}_beijing'].corr(merged_data[f'{pollutant}_jinzhou'])
    plt.title(f'{pollutant.upper()} 농도 간 상관관계\n서울-베이징: {correlation_seoul_beijing:.2f}, 서울-진조우: {correlation_seoul_jinzhou:.2f}, 베이징-진조우: {correlation_beijing_jinzhou:.2f}')
    plt.xlabel(f'{pollutant.upper()} 농도')
    plt.ylabel(f'{pollutant.upper()} 농도')
    plt.legend(loc='upper right')  # 범례를 우측 상단에 위치
    plt.grid(True)
    plt.show()

# 상관관계 행렬 출력
correlation_matrix