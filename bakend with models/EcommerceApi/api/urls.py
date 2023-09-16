from django.urls import path
from .views import RegisterUserAPIView, LoginView, LogoutView, UsersListAPIView, UserUpdateAPIView


urlpatterns = [
  #path("get-details",UserDetailAPI.as_view()),
  path('register/',RegisterUserAPIView.as_view()),
  path('login/',LoginView.as_view()),
  path('logout/',LogoutView.as_view()),

  path('get-users/',UsersListAPIView.as_view()),
  path('user/update/',UserUpdateAPIView.as_view())

]
