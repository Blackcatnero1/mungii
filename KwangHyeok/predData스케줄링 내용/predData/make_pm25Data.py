import pandas as pd
import os
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

# BASE_DIR과 MEDIA_ROOT 설정이 제대로 되어 있는지 확인
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')

def make_pm25Model(pm25_scaler):
    # 파일 경로를 MEDIA_ROOT를 사용하여 설정
    file_path = os.path.join(MEDIA_ROOT, 'KNN_totalData.csv')

    # CSV 파일 읽기
    df_KNNData = pd.read_csv(file_path)
    df_KNNData = df_KNNData.drop(['PM10'], axis=1)

    # 데이터 분리
    X = df_KNNData.drop('PM2.5', axis=1)
    y = df_KNNData['PM2.5']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # 스케일러 생성
    trainData_std_scaler = StandardScaler()
    X_train = pd.get_dummies(X_train)
    trainData_std_scaler.fit(X_train)

    X_test = pd.get_dummies(X_test)
    trainData_scaled_df = trainData_std_scaler.transform(X_train)
    testData_scaled_tdf = pm25_scaler.transform(X_test)

    # 모델링
    model = KNeighborsClassifier()
    model.fit(trainData_scaled_df, y_train)

    score=[]
    # 하이퍼 파라미터 튜닝
    for i in range(1, 143):
        knn = KNeighborsClassifier(n_neighbors=i)
        knn.fit(trainData_scaled_df, y_train)
        pred = knn.predict(testData_scaled_tdf)
        score.append(accuracy_score(y_test, pred))
    result = pd.DataFrame(
        {
            'n' : [i for i in range(1, 143)],
            'score' : score
        }
    )

    # 'score'가 가장 큰 행의 'n' 값 추출
    first_n_value = result[result['score'] == result['score'].max()]['n'].iloc[0]

    knn = KNeighborsClassifier(n_neighbors=first_n_value)
    knn.fit(trainData_scaled_df, y_train)

    return knn

def pred_pm25(pm25_scaler, pm25Model, temp_avg, tmax, tmin, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg, predOz, predNo2, predco, predso):
    # 파일 경로를 MEDIA_ROOT를 사용하여 설정
    file_path = os.path.join(MEDIA_ROOT, 'KNN_totalData.csv')

    # CSV 파일 읽기
    df_KNNData = pd.read_csv(file_path)
    df_KNNData = df_KNNData.drop(['PM10'], axis=1)
    pred_Data = df_KNNData.copy()
    pred_Data = df_KNNData.drop(['PM2.5'], axis=1)
    pred_Data.loc[-1] = [temp_avg, tmax, tmin, hum_avg, rain_avg, wind_avg, max_wind, wdeg_avg, predOz, predNo2, predco, predso]
    pred_Data.index = pred_Data.index + 1
    pred_Data.sort_index(inplace=True)
    pred_Data = pd.get_dummies(pred_Data)
    pred_Data = pred_Data.iloc[:1]

    predData_scaled = pm25_scaler.transform(pred_Data)
    
    my_pred = pm25Model.predict(predData_scaled)
    pred = int(my_pred[0])
    return pred