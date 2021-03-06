# Generated by Django 4.0.1 on 2022-01-06 13:57

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='File',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=256, verbose_name='Вариант шрифта')),
                ('link', models.CharField(max_length=256, verbose_name='Ссылка на шрифт')),
            ],
        ),
        migrations.CreateModel(
            name='Font',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('family', models.CharField(max_length=64, unique=True, verbose_name='Семейство шрифта')),
                ('files', models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='ml.file', verbose_name='Файл')),
            ],
        ),
        migrations.CreateModel(
            name='FontOpenPhoto',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=256, verbose_name='Семейство шрифта')),
                ('url', models.CharField(max_length=256, verbose_name='Ссылка на файл шрифта')),
            ],
            options={
                'verbose_name': ('Название определенного шрифта',),
                'verbose_name_plural': 'Названия определенных шрифтов',
            },
        ),
        migrations.CreateModel(
            name='PhotoFont',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(upload_to='upload_to/', verbose_name='Фото шрифта')),
            ],
            options={
                'verbose_name': ('Фото шрифта',),
                'verbose_name_plural': 'Фотографии шрифтов',
            },
        ),
        migrations.CreateModel(
            name='FontVariant',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=256, verbose_name='Название варианта')),
                ('font', models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='ml.font', verbose_name='Шрифт')),
            ],
        ),
    ]
