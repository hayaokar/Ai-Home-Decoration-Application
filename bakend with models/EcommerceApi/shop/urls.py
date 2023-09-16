from django.urls import path
from . import views


urlpatterns = [
    path("products/",views.product_list_view),
    path("products/create/",views.product_create_view),
    path("products/<int:pk>/",views.product_detail_view),
    path("products/<int:pk>/update/",views.product_update_view),
    path("products/<int:pk>/delete/",views.product_delete_view),

    path("categories/",views.category_list_view),
    path("categories/create/",views.category_create_view),
    path("categories/<int:pk>/delete/",views.category_delete_view),
    path("products/category/<int:pk>/",views.PoductsCategory.as_view()),

    path("add-to-cart/",views.list_item_create_view),
    path("delete-item-cart/<int:pk>/",views.DeleteItem.as_view()),
    path("view-cart/",views.view_cart),

    path('create-order/', views.OrderView.as_view()),
    path('orders/',views.order_list_view),
    path('orders/<int:pk>/',views.order_detail_view),
    path('orders/user/',views.UserOrders.as_view()),



    path('count-product/',views.PoductsCount.as_view()),
    path('count-orders/',views.OrdersCount.as_view()),
    path('count-users/',views.UsersCount.as_view()),

    path('get-profile/',views.UserProfile.as_view()),

    path('model/',views.model),
     
    
]
