from django.conf.urls.static import static
from django.conf import settings
from django.urls import path
from .views import PhotoViewSet, PhotoBinaryViewSet

urlpatterns = [
    path('img/', PhotoViewSet.as_view(), name='upload'),
    path('bin/', PhotoBinaryViewSet.as_view(), name='binary')
]
