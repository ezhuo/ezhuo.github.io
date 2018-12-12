from django.db import models
from django.utils import timezone
import datetime
# Create your models here.


class Article(models.Model):
    # dataSet = models.Manager()
    title = models.CharField(max_length=32, default="telst", null=True)
    # title = models.FilePathField(max_length=32, default="telst" , null=True)
    content = models.TextField(null=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "学校"
        ordering = ['-id']


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')

    def __str__(self):
        return self.question_text

    def was_published_recently(self):
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date <= now
    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        return self.choice_text


class Memo(models.Model):
    memo = models.CharField('备注', max_length=200)
    question = models.ManyToManyField(Question)