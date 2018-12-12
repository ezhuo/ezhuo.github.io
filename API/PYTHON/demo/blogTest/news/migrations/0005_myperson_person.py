# Generated by Django 2.1.3 on 2018-12-11 07:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news', '0004_memo_question'),
    ]

    operations = [
        migrations.CreateModel(
            name='Person',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=30)),
                ('last_name', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='MyPerson',
            fields=[
            ],
            options={
                'proxy': True,
                'indexes': [],
            },
            bases=('news.person',),
        ),
    ]
