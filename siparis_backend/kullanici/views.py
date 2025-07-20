from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from .serializers import KayitSerializer
from .models import CustomUser

class KayitView(APIView):
    def post(self, request):
        serializer = KayitSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"mesaj": "Kayıt başarılı!"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class GirisView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(username=username, password=password)
        if user:
            return Response({
                "mesaj": "Giriş başarılı!",
                "kullanici": {
                    "username": user.username,
                    "role": user.role,
                }
            }, status=status.HTTP_200_OK)
        return Response({"mesaj": "Geçersiz bilgiler"}, status=status.HTTP_401_UNAUTHORIZED)
    

from rest_framework.permissions import BasePermission
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import get_user_model

User = get_user_model()

# Özel yetki sınıfı
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import BasePermission
from rest_framework.response import Response
from .models import CustomUser

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import BasePermission
from rest_framework.response import Response
from .models import CustomUser

class IsYoneticiUser(BasePermission):
    def has_permission(self, request, view):
        return bool(
            request.user and 
            request.user.is_authenticated and 
            request.user.role == 'yonetici'
        )

@api_view(['GET'])
@permission_classes([IsYoneticiUser])
def kullanici_listesi(request):
    users = CustomUser.objects.all()
    data = [{
        'id': user.id,
        'username': user.username,
        'role': user.role,
        'is_active': user.is_active
    } for user in users]
    return Response(data)
