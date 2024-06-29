# urls.py

from django.urls import path, include
from rest_framework import routers
from ApiOracle import views
from .views import LoginAPIView

router = routers.DefaultRouter()
router.register(r"Roles", views.RolesViewSet)
router.register(r"Login", views.LoginViewSet)

urlpatterns = [
    path("api/", include(router.urls)),
    path('api/login/', LoginAPIView.as_view()),
]
