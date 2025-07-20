from django.urls import path
from .views import KayitView, GirisView
from .views import kullanici_listesi

urlpatterns = [
    path("kayit/", KayitView.as_view(), name="kayit"),
    path("giris/", GirisView.as_view(), name="giris"),
    path("kullanici_listesi/",kullanici_listesi),
]
