from django.contrib import admin
from django.urls import path, include
from mise.views import *
from . import views
import oracledb as db

urlpatterns = [
    path('', views.mise, name='mise'),
    path('get_data/', views.get_data, name='get_data'), #콘솔창에서 데이터받음
    path('compare/', views.compare, name='compare'), #콘솔창에서 데이터받음
    #path('getGraphdata/', views.getGraphdata, name='getGraphdata'),
    #path('load_districts/', views.load_districts, name='load_districts'),
]
