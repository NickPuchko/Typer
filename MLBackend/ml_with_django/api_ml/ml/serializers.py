from rest_framework import serializers
from .models import PhotoFont, PhotoFontBinary


class FontPhotoSerializer(serializers.ModelSerializer):
    class Meta:
        model = PhotoFont
        fields = ('file',)

class FontPhotoBinarySerializer(serializers.ModelSerializer):
    class Meta:
        model = PhotoFontBinary
        fields = ('file',)
