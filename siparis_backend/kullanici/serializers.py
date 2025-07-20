from rest_framework import serializers
from .models import CustomUser

class KayitSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username', 'password', 'role']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            username=validated_data['username'],
            password=validated_data['password'],
            is_active=False  # Kayıt olan kullanıcı giriş yapamasın
        )
        return user
