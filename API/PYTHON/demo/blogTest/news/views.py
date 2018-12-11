from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.core.exceptions import ObjectDoesNotExist
from django.urls import reverse
from django.views import generic

# Create your views here.

from . import models
from .models import Question, Choice


def index(request):
    res = models.Article.objects.all()
    return render(request, 'news/index.html', {'art': res})
    # return HttpResponse("hello news")


class IndexView(generic.ListView):
    template_name = 'news/index.html'
    context_object_name = 'latest_question_list'

    def get_queryset(self):
        """Return the last five published questions."""
        return Question.objects.order_by('-pub_date')[:5]


class DetailView(generic.DetailView):
    model = Question
    template_name = 'news/detail.html'


class ResultsView(generic.DetailView):
    model = Question
    template_name = 'news/results.html'


def index2(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    output = ', '.join([q.question_text for q in latest_question_list])
    return HttpResponse("list: {out}".format(out=output))


def detail(request, question_id):
    # try:
    #     question = Question.objects.get(pk=question_id)
    # except Question.DoesNotExist:
    #     raise Http404("Question does not exist")
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'news/detail.html', {'question': question})


def results(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'news/results.html', {'question': question})


def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form.
        return render(request, 'news/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('news:results', args=(question.id,)))


def page(request, id):
    res = models.Article.objects.get(pk=id)
    return render(request, 'news/page.html', {'art': res})


def edit(req, id):
    try:
        res = models.Article.objects.get(pk=id)
    except ObjectDoesNotExist:
        res = {'title': '', 'content': ''}
    return render(req, 'news/edit.html', {'art': res})


def save(req):
    ds = models.Article.objects
    print(ds)
    id = req.POST.get('id', '')
    if id.strip() == '':
        id = '0'
    id = int(id)
    print(id)

    data = {}
    data['title'] = req.POST.get('title')
    data['content'] = req.POST.get('content')
    if id < 1:
        p = models.Article()
        p.title = data['title']
        p.content = data['title']
        p.save()
        # models.Article.objects.create(**data)
    else:
        res = models.Article.objects.get(pk=id)
        res.title = data['title']
        res.content = data['content']
        idx = res.save()
        print('idx=', idx, res)

    return index(req)


def delete(req, id):
    res = models.Article.objects.get(pk=id)
    res.delete()
    return index(req)
