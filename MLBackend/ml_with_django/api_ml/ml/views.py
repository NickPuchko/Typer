import base64
from io import BytesIO
from PIL import Image
import pathlib
from .fontLink import getFontLink

from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser, JSONParser, FileUploadParser
from rest_framework.response import Response
from rest_framework import status
from .models import PhotoFont
from .serializers import FontPhotoSerializer, FontPhotoBinarySerializer
from .ml_module import det_fonts


# Create your views here.

class PhotoViewSet(APIView):
    parser_classes = (MultiPartParser, FormParser,)

    def post(self, request, *args, **kwargs):
        file_serializer = FontPhotoSerializer(data=request.data)
        print(request.data)
        if file_serializer.is_valid():
            file_serializer.save()
            # det_fonts.detFonts
            place = file_serializer.data['file']
            place = 'D:/Python_prog/api_for_font/ml_with_django/api_ml' + place
            answer = det_fonts.detFonts(place)
            print(answer)
            finalAnswer = {
                'family': answer
            }
            return Response(finalAnswer, status=status.HTTP_201_CREATED)
        else:
            print(file_serializer.data)
            return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class PhotoBinaryViewSet(APIView):
    parser_classes = (MultiPartParser, JSONParser,)

    def post(self, request, *args, **kwargs):
        file_serializer = FontPhotoBinarySerializer(data=request.data)

        if file_serializer.is_valid():
            # file_serializer.save()
            # det_fonts.detFonts
            print(file_serializer.data['file'])
            base64_img = file_serializer.data['file']
            base64_img_bytes = base64_img.encode('utf-8')

            with open("imageToSave.png", "wb") as file_to_save:
                decoded_image_data = base64.decodebytes(base64_img_bytes)
                file_to_save.write(decoded_image_data)
            answer = det_fonts.detFonts("imageToSave.png")
            try:
                linkFont = getFontLink.get_link('fontLink/data.json', answer)
            except BaseException:
                linkFont = "File for this font do not find!"
            finalAnswer = {
                'family': answer,
                'link': linkFont
            }

            return Response(finalAnswer, status=status.HTTP_201_CREATED)
        else:
            print(file_serializer.data)
            return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
