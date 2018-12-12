from django.contrib import admin
from . import models
# Register your models here.


class ChoiceInline(admin.TabularInline):
    model = models.Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
    list_display = ('question_text', 'pub_date', 'was_published_recently')
    list_filter = ['pub_date']
    search_fields = ['question_text']
    fieldsets = [
        ('主题', {'fields': ['question_text']}),
        ('时间', {'fields': ['pub_date']}),
    ]
    inlines = [ChoiceInline]


admin.site.register(models.Article)
admin.site.register(models.Question, QuestionAdmin)
admin.site.register(models.Choice)
