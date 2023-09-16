from rest_framework import serializers
from .models import Product,Order,OrderItems, Category,CartItems,Cart
from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
#serializers help with validation and returning data
class ProductSerializer(serializers.ModelSerializer):
    #image_url = serializers.SerializerMethodField('get_image_url')
    class Meta:
        model = Product
        fields = [
            'id',
            'name',
            'description',
            'price',
            'image_url',
            'category',
        ]
    #def get_image_url(self, obj):
    #    if obj.image_url:
    #        request = self.context.get("request")
    #        return request.build_absolute_uri(obj.image_url.url)


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
            model = Category
            fields = [
                'id',
                'name',
                'description',
                'image_url',
            ]
            read_only_fields = ('id',)


class CartItemSerializer(serializers.ModelSerializer):
    products = ProductSerializer(source='item',required=False)
    #cart_total = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = CartItems
        fields = [ "item", "quantity","products"]

    
    
class Cartserializer(serializers.ModelSerializer):
    cart_items = CartItemSerializer(source='cartitems_set', many=True,)
    #total_pric = serializers.SerializerMethodField(read_only=True)
    class Meta:
        model = Cart
        fields = [
            
            'cart_items',
            'total_price'
        ]
    #def get_total_pric(self,obj):
    #    return obj.cart_total
   

class OrderItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer(source='item',required=False)
    #cart_total = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = OrderItems
        fields = [ "item", "quantity","product"]

    
class OrderSerializer(serializers.ModelSerializer):

    #order_total = serializers.CharField(read_only=True)
    order_items = OrderItemSerializer(source='orderitems_set', many=True)
    user_name = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Order
        fields = [
            'id',
            'user_name',
            'date',
            'order_items',
            'total_price'
        ]
        read_only_fields = ('id',)
    def get_user_name(self,obj):
        try:
            return User.objects.get(pk=obj.user.id).username
        except:
            return None






