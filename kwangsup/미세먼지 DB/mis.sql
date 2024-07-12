-- kpred 테이블(대기질데이터)
CREATE TABLE kpred (
    kdate DATE,
    city VARCHAR2(20),
    PM10 VARCHAR2(10),
    PM25 VARCHAR2(10),
    O3 VARCHAR2(10),
    NO2 VARCHAR2(10),
    SO2 VARCHAR2(10),
    CO VARCHAR2(10)
);

-- kpreddata 테이블(2024년 예측치)
CREATE TABLE kpreddata (
    kdate DATE,
    pm25_beijing VARCHAR2(30 CHAR),
    pm10_beijing VARCHAR2(30 CHAR),
    no2_beijing VARCHAR2(30 CHAR),
    so2_beijing VARCHAR2(30 CHAR),
    o3_beijing VARCHAR2(30 CHAR),
    co_beijing VARCHAR2(30 CHAR),
    actual_pm25 VARCHAR2(30 CHAR),
    actual_pm10 VARCHAR2(30 CHAR),
    actual_no2 VARCHAR2(30 CHAR),
    actual_so2 VARCHAR2(30 CHAR),
    actual_o3 VARCHAR2(30 CHAR),
    actual_co VARCHAR2(30 CHAR),
    predicted_pm25 VARCHAR2(30 CHAR),
    predicted_pm10 VARCHAR2(30 CHAR),
    predicted_no2 VARCHAR2(30 CHAR),
    predicted_so2 VARCHAR2(30 CHAR),
    predicted_o3 VARCHAR2(30 CHAR),
    predicted_co VARCHAR2(30 CHAR),
    city VARCHAR2(30)
);
