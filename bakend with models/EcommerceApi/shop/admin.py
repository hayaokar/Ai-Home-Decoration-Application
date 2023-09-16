
from django.contrib import admin


from . models import Product,Category,Order, OrderItems,Cart,CartItems
# Register your models here.

admin.site.register(Product)
admin.site.register(Category)
admin.site.register(Order)
admin.site.register(OrderItems)
admin.site.register(Cart)
admin.site.register(CartItems)
