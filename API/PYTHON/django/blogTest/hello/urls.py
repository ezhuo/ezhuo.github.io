from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    # path('<ezhuo>', views.index2, name='index'),
    path('pdf/', views.httppdf, name='pdf'),
]
