from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import RegisterSerializer,UserSerializer
from rest_framework import generics
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from rest_framework.status import (
    HTTP_400_BAD_REQUEST,
    HTTP_404_NOT_FOUND,
    HTTP_200_OK
)
# Create your views here.

class RegisterUserAPIView(generics.CreateAPIView):
  permission_classes = (AllowAny,)
  serializer_class = RegisterSerializer

class LoginView(APIView):
    
    permission_classes = (AllowAny,)

    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")
        if username is None or password is None:
            return Response({'error': 'Please provide both username and password'},
                            status=HTTP_400_BAD_REQUEST)       
        user = authenticate(request, username=username, password=password)

        
        
        if not user:
            return Response({'error': 'Invalid Credentials'},
                            status=HTTP_404_NOT_FOUND)
        if user.is_superuser:
            type ="admin"
        else:
            type ="normal"
        token, _ = Token.objects.get_or_create(user=user)
        return Response({'token': token.key,'type':type},
                        status=HTTP_200_OK)
    
class LogoutView(APIView):
    permission_classes = (IsAuthenticated,)
    def get(self, request):
        request.user.auth_token.delete()
        return Response('User Logged out successfully')
        

class UsersListAPIView(generics.ListAPIView):
    permission_classes = (IsAdminUser,)
    queryset = User.objects.all()
    serializer_class=UserSerializer

class UserUpdateAPIView(generics.UpdateAPIView):
    permission_classes = (IsAuthenticated,)
    queryset = User.objects.all()
    serializer_class=UserSerializer
    def update(self, request, *args, **kwargs):
        instance = request.user
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "user updated successfully"})

        else:
            return Response({"message": "failed", "details": serializer.errors})