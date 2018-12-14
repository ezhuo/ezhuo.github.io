from django.shortcuts import render
from django.http import HttpResponse
from django.http import FileResponse
from reportlab.pdfgen import canvas
import io

# Create your views here.


def index(req):
    return HttpResponse('hello')


def index2(req, ezhuo):
    return HttpResponse(ezhuo)


def httppdf(request):
        # Create a file-like buffer to receive PDF data.
    buffer = io.BytesIO()

    # Create the PDF object, using the buffer as its "file."
    p = canvas.Canvas(buffer)

    # Draw things on the PDF. Here's where the PDF generation happens.
    # See the ReportLab documentation for the full list of functionality.
    p.drawString(100, 100, "Hello wdffdsafdsorld跟从国.")

    # Close the PDF object cleanly, and we're done.
    p.showPage()
    p.save()

    # FileResponse sets the Content-Disposition header so that browsers
    # present the option to save the file.
    return FileResponse(buffer, as_attachment=True, filename='hello.pdf')
