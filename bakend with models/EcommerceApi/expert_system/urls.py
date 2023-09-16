from django.urls import path
from .views import *


urlpatterns = [
  #path("get-details",UserDetailAPI.as_view()),
  path('get_room/',get_room),
  path('get_u_budget/',get_u_budget),
  path('get_space/',get_space),
  path('get_sun1/',get_sun1),
  path('get_color1/',get_color1),
  path('get_color2/',get_color2),
  path('get_color3/',get_color3),
  path('get_sun2/',get_sun2),
  path('get_color4/',get_color4),
  path('get_color5/',get_color5),
  path('get_color6/',get_color6),


  path('get_color6/',get_color6),
  path('get_your_budget/',get_your_budget),
  path('get_space1/',get_space1),
  path('get_room_type1/',get_room_type1),
  path('get_age1/',get_age1),
  path('get_num1/',get_num1),
  path('get_special1_1/',get_special1_1),
  path('get_play1/',get_play1),
  path('get_play2/',get_play2),
  path('get_special2_1/',get_special2_1),
  path('get_play3/',get_play3),
  path('get_play4/',get_play4),
  path('get_num2/',get_num2),
  path('get_special3_1/',get_special3_1),
  path('get_play5/',get_play5),
  path('get_play6/',get_play6),
  path('get_special3_2/',get_special3_2),
  path('get_play7/',get_play7),
  path('get_play8/',get_play8),
  path('get_age2_1/',get_age2_1),
  path('get_num2_1/',get_num2_1),
  path('get_color21/',get_color21),
  path('get_color22/',get_color22),
  path('get_num2_2/',get_num2_2),
  path('get_color31/',get_color31),
  path('get_color32/',get_color32),

  

]
