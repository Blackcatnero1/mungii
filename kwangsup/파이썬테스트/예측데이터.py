import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score
import random

# 데이터 불러오기
beijing = pd.read_csv('D:\\FILE\\베이징.csv')
seoul = pd.read_csv('D:\\FILE\\서울.csv')
jinzhou = pd.read_csv('D:\\FILE\\진조우.csv')

# 날짜 열을 datetime 형식으로 변환
beijing['date'] = pd.to_datetime(beijing['date'], errors='coerce')
seoul['date'] = pd.to_datetime(seoul['date'], errors='coerce')
jinzhou['date'] = pd.to_datetime(jinzhou['date'], errors='coerce')

# 숫자 데이터만 추출하고 비어있는 값을 NaN으로 대체하는 함수
def preprocess(df):
    numeric_df = df.drop(columns=['date']).apply(pd.to_numeric, errors='coerce')
    numeric_df.replace(' ', np.nan, inplace=True)
    numeric_df.fillna(numeric_df.mean(), inplace=True)
    # 컬럼명 소문자로 변환
    numeric_df.columns = map(str.lower, numeric_df.columns)
    return numeric_df

# 각 도시의 데이터프레임을 숫자로 변환하여 처리
beijing_numeric = preprocess(beijing)
seoul_numeric = preprocess(seoul)
jinzhou_numeric = preprocess(jinzhou)

# 각 도시의 PM2.5와 PM10의 상관관계 분석
plt.figure(figsize=(12, 8))
sns.heatmap(beijing_numeric.corr(), annot=True, cmap='coolwarm')
plt.title('Correlation Matrix for Beijing')
plt.show()

plt.figure(figsize=(12, 8))
sns.heatmap(seoul_numeric.corr(), annot=True, cmap='coolwarm')
plt.title('Correlation Matrix for Seoul')
plt.show()

plt.figure(figsize=(12, 8))
sns.heatmap(jinzhou_numeric.corr(), annot=True, cmap='coolwarm')
plt.title('Correlation Matrix for Jinzhou')
plt.show()

# 서울과 다른 도시들의 데이터 병합
corr_beijing_seoul = pd.merge(beijing_numeric, seoul_numeric, left_index=True, right_index=True, suffixes=('_beijing', '_seoul'))
corr_jinzhou_seoul = pd.merge(jinzhou_numeric, seoul_numeric, left_index=True, right_index=True, suffixes=('_jinzhou', '_seoul'))

# PM2.5 예측 모델
X_pm25 = corr_beijing_seoul[[' pm25_beijing', ' pm10_beijing']]
y_pm25 = corr_beijing_seoul[' pm25_seoul']

# PM10 예측 모델
X_pm10 = corr_beijing_seoul[[' pm25_beijing', ' pm10_beijing']]
y_pm10 = corr_beijing_seoul[' pm10_seoul']

# 데이터 준비
def prepare_data(X, y):
    X.replace(' ', np.nan, inplace=True)
    X.fillna(X.astype(float).mean(), inplace=True)
    y.replace(' ', np.nan, inplace=True)
    y.fillna(y.astype(float).mean(), inplace=True)
    return X.astype(float), y.astype(float)

X_pm25, y_pm25 = prepare_data(X_pm25, y_pm25)
X_pm10, y_pm10 = prepare_data(X_pm10, y_pm10)

# 데이터 분할
X_train_pm25, X_test_pm25, y_train_pm25, y_test_pm25 = train_test_split(X_pm25, y_pm25, test_size=0.2, random_state=42)
X_train_pm10, X_test_pm10, y_train_pm10, y_test_pm10 = train_test_split(X_pm10, y_pm10, test_size=0.2, random_state=42)

# 모델 생성 및 학습
model_pm25 = LinearRegression()
model_pm25.fit(X_train_pm25, y_train_pm25)

model_pm10 = LinearRegression()
model_pm10.fit(X_train_pm10, y_train_pm10)

# 예측
y_pred_pm25 = model_pm25.predict(X_test_pm25)
y_pred_pm10 = model_pm10.predict(X_test_pm10)

# 성능 평가
print(f"\nPM2.5 Prediction Model Performance:")
print(f"Mean Squared Error: {mean_squared_error(y_test_pm25, y_pred_pm25)}")
print(f"R^2 Score: {r2_score(y_test_pm25, y_pred_pm25)}")

print(f"\nPM10 Prediction Model Performance:")
print(f"Mean Squared Error: {mean_squared_error(y_test_pm10, y_pred_pm10)}")
print(f"R^2 Score: {r2_score(y_test_pm10, y_pred_pm10)}")

# 예측 결과 시각화
plt.figure(figsize=(14, 6))
plt.plot(y_test_pm25.values, label='Actual PM2.5')
plt.plot(y_pred_pm25, label='Predicted PM2.5')
plt.legend()
plt.xlabel('Index')
plt.ylabel('PM2.5')
plt.title('Actual vs Predicted PM2.5')
plt.grid(True)
plt.show()

plt.figure(figsize=(14, 6))
plt.plot(y_test_pm10.values, label='Actual PM10')
plt.plot(y_pred_pm10, label='Predicted PM10')
plt.legend()
plt.xlabel('Index')
plt.ylabel('PM10')
plt.title('Actual vs Predicted PM10')
plt.grid(True)
plt.show()

# 미래 예측
future_beijing = pd.DataFrame({
    'date': pd.date_range(start='2024-06-22', end='2024-06-30'),
    ' pm25_beijing': [random.randint(50, 150) for _ in range(9)],
    ' pm10_beijing': [random.randint(30, 100) for _ in range(9)]
})

future_jinzhou = pd.DataFrame({
    'date': pd.date_range(start='2024-06-22', end='2024-06-30'),
    ' pm25_jinzhou': [random.randint(40, 130) for _ in range(9)],
    ' pm10_jinzhou': [random.randint(25, 90) for _ in range(9)]
})

future_data = pd.merge(future_beijing, future_jinzhou, on='date')

future_X_pm25 = future_data[[' pm25_beijing', ' pm10_beijing']]
future_X_pm10 = future_data[[' pm25_beijing', ' pm10_beijing']]

future_pred_pm25 = model_pm25.predict(future_X_pm25)
future_pred_pm10 = model_pm10.predict(future_X_pm10)

future_data['Predicted_PM25'] = future_pred_pm25
future_data['Predicted_PM10'] = future_pred_pm10

print("\nFuture PM2.5 and PM10 predictions for Seoul (2024.06.22 ~ 2024.06.30):")
print(future_data[['date', 'Predicted_PM25', 'Predicted_PM10']])
