import pandas as pd
import os
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

# BASE_DIR과 MEDIA_ROOT 설정이 제대로 되어 있는지 확인
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')

def make_standScaler():
    # 파일 경로를 MEDIA_ROOT를 사용하여 설정
    file_path = os.path.join(MEDIA_ROOT, 'df_totalData.csv')
    df_totalData = pd.read_csv(file_path)
    df = df_totalData.drop(columns=['오 존', '이산화질소', '일산화탄소', '아황산가스'])

    sc = StandardScaler()
    sc.fit(df)
    return sc

def make_pm10testScaler():
    file_path = os.path.join(MEDIA_ROOT, 'KNN_totalData.csv')
    df_KNNData = pd.read_csv(file_path)
    df_KNNData = df_KNNData.drop(['PM2.5'], axis=1)

    # 데이터 분리
    X = df_KNNData.drop('PM10', axis=1)
    y = df_KNNData['PM10']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    pm10_scaler = StandardScaler()
    X_test = pd.get_dummies(X_test)
    pm10_scaler.fit(X_test)

    return pm10_scaler

def make_pm25testScaler():
    file_path = os.path.join(MEDIA_ROOT, 'KNN_totalData.csv')
    df_KNNData = pd.read_csv(file_path)
    df_KNNData = df_KNNData.drop(['PM10'], axis=1)

    # 데이터 분리
    X = df_KNNData.drop('PM2.5', axis=1)
    y = df_KNNData['PM2.5']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    pm25_scaler = StandardScaler()
    X_test = pd.get_dummies(X_test)
    pm25_scaler.fit(X_test)

    return pm25_scaler

