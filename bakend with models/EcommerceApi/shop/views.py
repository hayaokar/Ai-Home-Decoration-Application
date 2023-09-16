from django.shortcuts import render
from rest_framework import generics
from .models import Product,Order, OrderItems, Category, Cart, CartItems
from .serializers import ProductSerializer,CategorySerializer, CartItemSerializer, Cartserializer, OrderSerializer
from rest_framework.response import Response
from rest_framework import permissions
from django.contrib.auth.models import User
from rest_framework.views import APIView
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from rest_framework import permissions
from rest_framework.decorators import api_view
from rest_framework.parsers import MultiPartParser, FormParser
from subprocess import run ,PIPE
import sys
from PIL import Image
import requests
import pathlib
from experta import *
# Create your views here.

class ProductCreateAPIView(generics.CreateAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    parser_classes = (MultiPartParser, FormParser)

class ProductListAPIView(generics.ListAPIView):
    queryset = Product.objects.all()
    serializer_class=ProductSerializer

class ProductDetailAPIView(generics.RetrieveAPIView):
    queryset = Product.objects.all()
    serializer_class=ProductSerializer
    

class ProductUpdateAPIView(generics.UpdateAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Product.objects.all()
    serializer_class=ProductSerializer
    def update(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Product updated successfully"})

        else:
            return Response({"message": "failed", "details": serializer.errors})


class ProductDeleteAPIView(generics.DestroyAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Product.objects.all()
    serializer_class=ProductSerializer
    lookup_field = 'pk'

    def perform_destroy(self, instance):
        return super().perform_destroy(instance)
    

class CategoryCreateAPIView(generics.CreateAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class CategrorytListAPIView(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class=CategorySerializer
    

class CategoryDeleteAPIView(generics.DestroyAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Category.objects.all()
    serializer_class=CategorySerializer
    lookup_field = 'pk'

    def perform_destroy(self, instance):
        return super().perform_destroy(instance)



    



class PoductsCategory(APIView):
    def get(self, request,pk, format=None):
        category = Category.objects.get(pk=pk)
        queryset = Product.objects.filter(category=category)
        serializer = ProductSerializer(queryset, context={"request": 
                      request}, many=True)
        return Response(serializer.data) 
    

class CartItemAPIView(generics.CreateAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = CartItemSerializer

    #def get_queryset(self):
    #    user = self.request.user
    #    queryset = CartItems.objects.filter(cart__user=user)
    #    return queryset

    def create(self, request, *args, **kwargs):
        user = request.user
        cart = get_object_or_404(Cart, user=user)
        product = get_object_or_404(Product, pk=request.data["product"])
        quantity = request.data["quantity"]
        

        try:
            cart_item = cart.cartitems_set.get(item=product)
            q = cart_item.quantity + int(quantity)
            cart_item.quantity = q
            serializer = CartItemSerializer(cart_item)
            
            cart_item.save(update_fields=["quantity"])
            cart.total_price = cart.cart_total
            cart.save()
            

        except :
            
            
            cart_item = CartItems(cart=cart, item=product,quantity=quantity)
            serializer = CartItemSerializer(cart_item)
            cart_item.save()
            cart.total_price = cart.cart_total
            cart.save()
    
        return Response(serializer.data)




class Listcart(APIView):
    def get(self, request, format=None):
        cart = Cart.objects.get(user=request.user)
        data = Cartserializer(cart,context=request.parser_context)
        return Response(data.data)

#class Listcart(generics.RetrieveAPIView):
#    queryset = Product.objects.all()
#    serializer_class=ProductSerializer


class DeleteItem(APIView):
    def delete(self, request,pk):
        cart = Cart.objects.get(user=request.user)
        item = Product.objects.get(pk=pk)
        cart_item = CartItems.objects.get(cart=cart,item=item)
        cart_item.delete()
        cart.total_price = cart.cart_total
        cart.save()
        return Response({"delete success"})



class OrderView(APIView):
    permission_classes = (permissions.IsAuthenticated,)
    def post(self,request):
        user = request.user
        cart = Cart.objects.get(user=self.request.user)
        items = cart.cartitems_set.all()
        #products = request.data['products']
        order = Order(user=user)
        order.save()
        for i in range(len(items)):
            pk = items[i].item.pk
            pr = get_object_or_404(Product,pk=pk)
            quantity = items[i].quantity
            order_item = OrderItems(order=order,item=pr,quantity=quantity)
            order_item.save()
            CartItems.objects.get(pk=items[i].pk).delete()
        

        order.total_price = cart.total_price
        cart.total_price = 0
        cart.save()
        order.save()
        return Response()


class OrdreListAPIView(generics.ListAPIView):
    permission_classes = (permissions.IsAdminUser,)
    queryset = Order.objects.all()
    serializer_class=OrderSerializer


class OrderDetailAPIView(generics.RetrieveAPIView):
    permission_classes = (permissions.IsAuthenticated,)
    queryset = Order.objects.all()
    serializer_class=OrderSerializer



class UserOrders(APIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self,request):
        user = request.user
        orders = user.orders.all()
        serializer = OrderSerializer(orders, many=True,context={"request": 
                      request})
        return Response(serializer.data)

class PoductsCount(APIView):
    permission_classes = (permissions.IsAdminUser,)
    def get(self, request, format=None):
        count = len(Product.objects.all())
        return Response(count)
    
class OrdersCount(APIView):
    permission_classes = (permissions.IsAdminUser,)
    def get(self, request, format=None):
        count = len(Order.objects.all())
        return Response(count)
    
class UsersCount(APIView):
    permission_classes = (permissions.IsAdminUser,)
    def get(self, request, format=None):
        count = len(User.objects.all())
        return Response(count)
    

class UserProfile(APIView):
    permission_classes = (permissions.IsAuthenticated,)
    def get(self,request):
        user = request.user
        return Response({"username":user.username,
                        "email":user.email,
                        "first_name":user.first_name,
                        "last_name":user.last_name})




@api_view(["POST"])
def model(request):
    
    
    arg1 = "--weight_file=D:\\senior\\trained_models\\new_train_3\\model_00150"
    arg2='--n_sequences=1'
    
    if request.data.get("n_sequence"):
        arg2=f'--n_sequences={request.data.get("n_sequence")}'
    
    

    image_file = request.FILES['image_url']
    #image = Image.open(image_file)
    image_name = image_file.name
    image_name = image_name.replace(".png", ".gif")
    #path = pathlib.PurePath(image_name).name

    arg3=f'--floor_plan_image={image_file}'



    #arg4= f'--image_name={image_file.name.replace(".png","")}'
    
    
    arg4= f'--image_name=Bedroom-12864'
    
    
    run([sys.executable,'C:\\Users\\princ\\Desktop\\master\\scripts\\generate_scenes_modified.py',arg1,arg2,arg3,arg4],shell=True,stdout=PIPE)
    
    generated_path = request.build_absolute_uri(f'/media/generated_scenes/{image_name}')
    
    return JsonResponse({'generated_image': generated_path})

product_list_view = ProductListAPIView.as_view()
product_create_view = ProductCreateAPIView.as_view()
product_detail_view = ProductDetailAPIView.as_view()
product_update_view = ProductUpdateAPIView.as_view() 
product_delete_view = ProductDeleteAPIView.as_view()

category_list_view = CategrorytListAPIView.as_view()
category_create_view = CategoryCreateAPIView.as_view()
category_delete_view = CategoryDeleteAPIView.as_view()


order_list_view = OrdreListAPIView.as_view()
order_detail_view = OrderDetailAPIView.as_view()
list_item_create_view = CartItemAPIView.as_view()
view_cart = Listcart.as_view()


