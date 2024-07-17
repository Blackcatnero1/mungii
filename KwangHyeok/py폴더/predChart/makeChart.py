import pandas as pd
import plotly.graph_objects as go
import os

# BASE_DIR과 MEDIA_ROOT 설정이 제대로 되어 있는지 확인
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIA_ROOT = os.path.join(BASE_DIR, 'predDataSet')

def makeKnn_Chart():
    # 데이터프레임으로 변환
    csv_path = os.path.join(MEDIA_ROOT, 'predKNN_Chart.csv')
    df = pd.read_csv(csv_path)
    # 실제 값(trace1)과 예측 값(trace2)을 시각화
    trace1 = go.Scatter(
        x=df.index,
        y=df['실제'],
        mode='lines+markers',
        name='Real',
        marker=dict(size=10),
        zorder=2  # zorder 설정 (높을수록 위에 그려짐)
    )

    trace2 = go.Scatter(
        x=df.index,
        y=df['예측'],
        mode='lines+markers',
        name='Pred',
        marker=dict(size=10),
        zorder=1  # zorder 설정
    )

    # 레이아웃 설정
    layout = go.Layout(
        title='Real vs Predicted Values(적중률 : 84%)',
        xaxis=dict(
            title='Index',
            tickmode='linear',
            dtick=100,  # X축을 100 단위로 설정
            range=[0, 100],  # 초기 줌 설정
            rangeslider=dict(
                visible=True  # 가로 슬라이드바 활성화
            )
        ),
        yaxis=dict(title='Value')
    )

    # Figure 생성
    fig = go.Figure(data=[trace1, trace2], layout=layout)
    plot_tag = fig.to_html(full_html=False)
    
    return plot_tag