from django.urls import path
from . import views

app_name = 'news'

urlpatterns = [
    path('', views.index, name='index'),
    path('/', views.index, name='index'),

    # path('index2/', views.index2, name='index2'),
    # path('<int:question_id>/', views.detail, name='detail'),
    # path('<int:question_id>/results/', views.results, name='results'),
    # path('<int:question_id>/vote/', views.vote, name='vote'),

    path('index2/', views.IndexView.as_view(), name='index'),
    path('<int:pk>/', views.DetailView.as_view(), name='detail'),
    path('<int:pk>/results/', views.ResultsView.as_view(), name='results'),
    path('<int:question_id>/vote/', views.vote, name='vote'),

    path(route='art/<int:id>', view=views.page, name='art'),
    path('edit/<int:id>', views.edit, name='edit'),
    path('save', views.save, name='save'),
    path('delete/<int:id>', views.delete, name='delete'),
]
