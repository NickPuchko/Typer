from django.db import models


# Create your models here.
class File(models.Model):
    title = models.CharField('Вариант шрифта', max_length=256)
    link = models.CharField('Ссылка на шрифт', max_length=256)


class Font(models.Model):
    family = models.CharField('Семейство шрифта', unique=True, max_length=64)
    files = models.ForeignKey(File, verbose_name='Файл', on_delete=models.CASCADE, default=None, null=True)


class FontVariant(models.Model):
    title = models.CharField('Название варианта', max_length=256)
    font = models.ForeignKey(Font, verbose_name='Шрифт', on_delete=models.CASCADE, default=None, null=True)


class PhotoFont(models.Model):
    file = models.FileField(verbose_name='Фото шрифта', upload_to='upload_to/')

    class Meta:
        verbose_name = 'Фото шрифта',
        verbose_name_plural = 'Фотографии шрифтов'


class FontOpenPhoto(models.Model):
    title = models.CharField('Семейство шрифта', max_length=256)
    url = models.CharField('Ссылка на файл шрифта', max_length=256)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = 'Название определенного шрифта',
        verbose_name_plural = 'Названия определенных шрифтов'


class PhotoFontBinary(models.Model):
    file = models.TextField(verbose_name='Фото в бинарном виде')

    class Meta:
        verbose_name = 'Фото в бинарном виде',
        verbose_name_plural = 'Фотографии в бинарных видах'
