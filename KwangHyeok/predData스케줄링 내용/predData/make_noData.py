import pandas as pd
import os
from sklearn.model_selection import train_test_split
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
import time

# BASE_DIR과 MEDIA_ROOT 설정이 제대로 되어 있는지 확인
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')

def make_noModel(sc):
    # 파일 경로를 MEDIA_ROOT를 사용하여 설정
    file_path = os.path.join(MEDIA_ROOT, 'df_totalData.csv')
    # CSV 파일 읽기
    df_totalData = pd.read_csv(file_path)
    
    no_df = df_totalData.drop(columns=['오 존', '일산화탄소', '아황산가스'])
    X = no_df.drop(['이산화질소'], axis=1)
    y = no_df['이산화질소']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=42)

    X_train = sc.transform(X_train)
    X_test = sc.transform(X_test)

    # 모델
    no_model = Sequential()
    # 첫번째 은닉층
    no_model.add(
        Dense(
            64, 
            activation='relu',
            input_shape=(X_train.shape[1], )
        )
    )
    # 중간 은닉층
    no_model.add(
        Dense(
            64, 
            activation='relu'
        )
    )
    # 출력층
    no_model.add(
        Dense(
            1 # 회귀분석의 경우 출력층의 activation 함수는 필요하지 않는다.
        )
    )

    # 모델
    no_model = Sequential(
        [
            Dense(
                64, 
                activation='relu',
                input_shape=(X_train.shape[1], )
            ),
            Dense(
                64,
                activation='relu'
            ),
            Dense(
                1
            )
        ]
    )

    # 모델 설정
    no_model.compile(
        optimizer='adam',
        loss='mean_squared_error',
        metrics=['mae']
    )

    startTime = time.time()
    history = no_model.fit(
        X_train, y_train, epochs=100, validation_split=0.2, verbose=1
    )
    print('학습시간 : {0:.3f}'.format(time.time() - startTime))
    return no_model

def pred_no(sc, no_model, temp_avg, temp_max, temp_min, hum_avg, rain_avg, wind_avg, wind_max, wdeg_avg):
    dic = {
        '평균기온(℃)': temp_avg, 
        '최고기온(℃)': temp_max, 
        '최저기온(℃)': temp_min, 
        '평균습도(%rh)': hum_avg, 
        '강수량(mm)': rain_avg, 
        '평균풍속(m/s)': wind_avg, 
        '최대풍속(m/s)': wind_max, 
        '최대풍속풍향(deg)': wdeg_avg
    }
    if dic.get('최대풍속풍향(deg)') == '북동풍':
        dic['최대풍속풍향(deg)'] = 45
    elif dic.get('최대풍속풍향(deg)') == '동풍':
        dic['최대풍속풍향(deg)'] = 90
    elif dic.get('최대풍속풍향(deg)') == '남동풍':
        dic['최대풍속풍향(deg)'] = 135
    elif dic.get('최대풍속풍향(deg)') == '남풍':
        dic['최대풍속풍향(deg)'] = 180
    elif dic.get('최대풍속풍향(deg)') == '남서풍':
        dic['최대풍속풍향(deg)'] = 225
    elif dic.get('최대풍속풍향(deg)') == '서풍':
        dic['최대풍속풍향(deg)'] = 270
    elif dic.get('최대풍속풍향(deg)') == '북서풍':
        dic['최대풍속풍향(deg)'] = 315
    elif dic.get('최대풍속풍향(deg)') == '북풍':
        dic['최대풍속풍향(deg)'] = 360

    # 새로운 데이터를 데이터프레임으로 변환
    df_new = pd.DataFrame([dic])

    # 새로운 데이터를 스케일러를 사용하여 변환
    array = sc.transform(df_new)

    # 오존 예측값 반환
    pred1 = no_model.predict(array)
    pred2 = pred1.reshape(-1,)
    no_pred = round(pred2[0], 3)

    return no_pred