import models, forms
import datetime
import django
import cStringIO as StringIO
import ho.pisa as pisa

from django.template import RequestContext, loader, Context
from django.http import HttpResponse, HttpResponseRedirect
from forms import AdaugaNotaForm
from django.template.loader import get_template

def render_to_pdf(template_src, context_dict, name):

	template = get_template(template_src)
	context = Context(context_dict)
	html  = template.render(context)
	result = StringIO.StringIO()

	pdf = pisa.pisaDocument(StringIO.StringIO(html.encode("ISO-8859-1")), result)

	if not pdf.err:
		response = HttpResponse(result.getvalue(), mimetype='application/pdf')
		response['Content-Disposition'] = 'attachment; filename="' + name + '.pdf"'
		return response

	return HttpResponse('We had some errors<pre>%s</pre>' % escape(html))

def exportMaterie(request):

	id = request.GET.get("id")
	sem = request.GET.get("sem")
        
	noteOptions = {
		1 : 'I',
		2 : 'S',
		3 : 'B',
		4 : 'FB'
	}

	materie = models.Materii.objects.get(id = id)
	elevi = models.Elevi.objects.filter(clasa = materie.clasa).order_by("nume")

	list = []
	for elev in elevi:
		note = models.Note.objects.filter(materie = materie, semestru = sem, elev = elev).order_by("data")
		for nota in note:
			nota.nota = noteOptions[nota.nota]
		list.append([elev, note])


	return render_to_pdf(
			'exportmaterie.html', {
				'pagesize' : 'A4',
				'note' : list,
				'materie' : materie,
				'semestru' : sem
            	},
			'Tabel Note ['+ materie.nume +']['+ materie.clasa.nume +']'
	)

def exportMedii(request):

	id = request.GET.get("id")
	sem = request.GET.get("sem")
        
	noteOptions = {
		0 : '-',
		1 : 'I',
		2 : 'S',
		3 : 'B',
		4 : 'FB'
	}

	clasa = models.Clase.objects.get(id = id)
	elevi = models.Elevi.objects.filter(clasa = clasa).order_by("nume")
	materii = models.Materii.objects.filter(clasa = clasa).order_by("nume")

	list_elevi = []
	for elev in elevi:
		suma_gen = nr_gen = 0
		list_materii = []
		for materie in materii:
			note = models.Note.objects.filter(materie = materie, elev = elev, semestru = sem)
			suma = nr = 0
			for nota in note:
				suma = suma + nota.nota
				nr = nr + 1

			if (nr != 0):
				x = int(round(suma * 1.0 / nr))
				suma_gen = suma_gen + x
				nr_gen = nr_gen + 1
				medie = noteOptions[x]
			else:
				medie = noteOptions[0]

			list_materii.append(medie)

		if (nr_gen != 0):
			x = int(round(suma_gen * 1.0 / nr_gen))
			medie = noteOptions[x]
		else:
			medie = noteOptions[0]

		list_elevi.append([elev.nume, elev.prenume, list_materii, medie])

	return render_to_pdf(
			'exportmedii.html', {
				'pagesize' : 'A4',
				'clasa' : clasa,
				'materii' : materii,
				'elevi' : list_elevi,
				'semestru' : sem
            	},
			'Tabel Medii [Semestrul '+ sem +']['+ clasa.nume +']'
	)

def exportGraficMaterie(request):

	id = request.GET.get("id")
	el = request.GET.get("elev")
	sem = request.GET.get("semestru")
        
	materie = models.Materii.objects.get(id = id)
	elev = models.Elevi.objects.get(id = el)

	import urllib
	img = "http://localhost:8000/graficmaterie?id="+ id + "&elev=" + el + "&semestru="+ sem
	urllib.urlretrieve(img, 'grafic.png')
	import Image
	im = Image.open('grafic.png')
	im.save('grafic.jpg')

	return render_to_pdf(
			'exportgraficmaterie.html', {
				'pagesize' : 'A4',
				'elev' : elev,
				'materie' : materie,
				'semestru' : sem
            	},
			'Grafic ['+ materie.nume +']['+ elev.clasa.nume +'] - ' + elev.nume + ' ' + elev.prenume
	)

def graficMaterie(request):

	id = request.GET.get("id")
	el = request.GET.get("elev")
	sem = request.GET.get("semestru")

	noteOptions = ['', 'I', 'S', 'B', 'FB', '']

	materie = models.Materii.objects.get(id = id)
	elev = models.Elevi.objects.get(id = el)
	note = models.Note.objects.filter(materie = materie, elev = elev, semestru = sem).order_by("-data")

	from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas
	from matplotlib.figure import Figure
	from matplotlib.dates import DateFormatter

	x = []
	y = []
	for nota in note:
		y.append(nota.nota)
		pythondate = datetime.datetime.strptime(nota.data, "%Y-%m-%d").date()
		x.append(pythondate)

	fig = Figure()
	ax = fig.add_subplot(111)
	fig.patch.set_facecolor('white')
	ax.yaxis.grid(color = 'gray', linestyle = 'dashed')

	ax.plot_date(x, y, '-o')
	ax.xaxis.set_major_formatter(DateFormatter('%d-%m-%Y'))

	ax.set_yticks([0, 1, 2, 3, 4, 5])
	ax.set_yticklabels(noteOptions)

	ax.set_ylabel("Calificative")
	ax.set_xlabel("Perioada")

	fig.autofmt_xdate()
	canvas = FigureCanvas(fig)
	response = django.http.HttpResponse(content_type='image/png')
	canvas.print_png(response)
	return response


def index(request):

	list = models.Clase.objects.all().order_by("-an")

	t = loader.get_template("index.html")
	c = RequestContext(request, { "title" : "Prima Pagin&#259;", "clase" : list })
	return HttpResponse(t.render(c))

def addClasa(request):

	title = "Adaug&#259; o Clas&#259; Nou&#259;"

	if request.method == 'POST':

		form = forms.ClasaForm(request.POST)

		if form.is_valid():
			clasa = models.Clase()
			clasa.nume = form.cleaned_data['nume']
			clasa.descriere = form.cleaned_data['descriere']
			clasa.an = form.cleaned_data['an']
			clasa.profesor = form.cleaned_data['profesor']
			clasa.status = form.cleaned_data['status']
			clasa.save()

			return HttpResponseRedirect("veziclasa?id=" + str(clasa.id))

		else:

			t = loader.get_template("addclasa.html")
			c = RequestContext(request, { 'form' : form, 'title' : title })
			return HttpResponse(t.render(c))

	else :

		form = forms.ClasaForm()
		t = loader.get_template("addclasa.html")
		c = RequestContext(request, { 'form' : form, 'title' : title })
		return HttpResponse(t.render(c))

def editClasa(request):

	if request.method == 'POST':

		clasa = request.session.get("clasa")
		form = forms.ClasaForm(request.POST)

		if form.is_valid():
			clasa.nume = form.cleaned_data['nume']
			clasa.profesor = form.cleaned_data['profesor']
			clasa.an = form.cleaned_data['an']
			clasa.descriere = form.cleaned_data['descriere']
			clasa.status = form.cleaned_data['status']

			clasa.save()

			return HttpResponseRedirect("veziclasa?id=" + str(clasa.id))

		else:

			t = loader.get_template("editclasa.html")
			c = RequestContext(request, { 'form' : form, 'clasa' : clasa })
			return HttpResponse(t.render(c))

	else:

		id = request.GET.get("id")
		clasa = models.Clase.objects.get(id = id)
		form = forms.ClasaForm(instance = clasa)
		request.session['clasa'] = clasa

		t = loader.get_template("editclasa.html")
		c = RequestContext(request, { "form" : form, 'clasa' : clasa })
		return HttpResponse(t.render(c))

def viewClasa(request):

	id = request.GET.get("id")
	clasa = models.Clase.objects.get(id = id)
	materii = models.Materii.objects.filter(clasa = clasa).order_by("nume")
	elevi = models.Elevi.objects.filter(clasa = clasa).order_by("nume")

	StatusOptions = {
		0 : "Inceput de an Scolar",
		1 : "Sfarsit Semestrul I",
		2 : "Sfarsit de an Scolar"
	}

	status = StatusOptions[clasa.status]

	t = loader.get_template("viewclasa.html")
	c = RequestContext(request, { 
		"clasa" : clasa, 
		'title' : clasa.nume, 
		'materii' : materii, 
		'elevi' : elevi, 
		'status' : status 
	})
	return HttpResponse(t.render(c))

def viewMaterie(request):

	noteOptions = {
		1 : 'I',
		2 : 'S',
		3 : 'B',
		4 : 'FB'
	}

	StatusOptions = {
		0 : "Inceput de an Scolar",
		1 : "Sfarsit Semestrul I",
		2 : "Sfarsit de an Scolar"
	}

	id = request.GET.get("id")
	materie = models.Materii.objects.get(id = id)
	elevi = models.Elevi.objects.filter(clasa = materie.clasa).order_by("nume")

	status = StatusOptions[materie.clasa.status]

	list1 = []
	for elev in elevi:
		note = models.Note.objects.filter(elev = elev, semestru = 1, materie = materie).order_by("data")
		for nota in note:
			nota.nota = noteOptions[nota.nota]
		list1.append([elev, note])

	list2 = []
	for elev in elevi:
		note = models.Note.objects.filter(elev = elev, semestru = 2, materie = materie).order_by("data")
		for nota in note:
			nota.nota = noteOptions[nota.nota]
		list2.append([elev, note])

	t = loader.get_template("viewmaterie.html")
	c = RequestContext(request, { "materie" : materie, "note1" : list1, "note2" : list2, "status" : status })
	return HttpResponse(t.render(c))

def viewElev(request):

	noteOptions = {
			0 : 'X', 
			1 : 'I',
			2 : 'S',
			3 : 'B',
			4 : 'FB'
		}

	id = request.GET.get("id")
	elev = models.Elevi.objects.get(id = id)
	title = elev.nume + " " + elev.prenume

	materii = models.Materii.objects.filter(clasa = elev.clasa).order_by("nume")
	list1 = []
	list2 = []
	nr_materii = 0;
	suma_medie1 = 0;
	suma_medie2 = 0;

	for materie in materii:

		note = models.Note.objects.filter(materie = materie, semestru = 1, elev = elev).order_by("data")
		suma = 0;
		nr = 0
		for nota in note:
			suma = suma + nota.nota
			nr = nr + 1
			nota.nota = noteOptions[nota.nota]
		
		if (nr != 0):
			x = int(round(suma * 1.0 / nr))
			medie = noteOptions[x]
			suma_medie1 = suma_medie1 + x
			nr_materii = nr_materii + 1
		else:
			medie = noteOptions[0]

		list1.append([materie, note, medie])

		note = models.Note.objects.filter(materie = materie, semestru = 2, elev = elev).order_by("data")
		suma = 0;
		nr = 0
		for nota in note:
			suma = suma + nota.nota
			nr = nr + 1
			nota.nota = noteOptions[nota.nota]
		
		if (nr != 0):
			x = int(round(suma * 1.0 / nr))
			medie = noteOptions[x]
			suma_medie2 = suma_medie2 + x
		else:
			medie = noteOptions[0]

		list2.append([materie, note, medie])

	if (nr_materii != 0):
		x1 = int(round(suma_medie1 * 1.0 / nr_materii))
		medie_sem1 = noteOptions[x1]
		x2 = int(round(suma_medie2 * 1.0 / nr_materii))
		medie_sem2 = noteOptions[x2]
		medie_an = noteOptions[int(round((x1 + x2) * 1.0 / 2))]
	else:
		medie_sem1 = noteOptions[0]
		medie_sem2 = noteOptions[0]
		medie_an = noteOptions[0]

	t = loader.get_template("viewelev.html")
	c = RequestContext(request, { 
			'elev' : elev,
			'title' : title,
			'semestrul1' : list1,
			'semestrul2' : list2,
			'medie1' : medie_sem1,
			'medie2' : medie_sem2,
			'mediean' : medie_an
		})
	return HttpResponse(t.render(c))

def deleteNota(request):

	noteOptions = { 
			1 : 'I',
			2 : 'S',
			3 : 'B',
			4 : 'FB'
		}

	title = "&#350;tergere Not&#259;"
	id = request.GET.get("id")
	nota = models.Note.objects.get(id = id)
	nota.nota = noteOptions[nota.nota]

	sigur = request.GET.get("sigur")

	if (sigur == 'da'):

		delete = models.Note.objects.get(id = id).delete()
		return HttpResponseRedirect("vezielev?id=" + str(nota.elev.id))

	elif (sigur == 'nu'):

		return HttpResponseRedirect("vezielev?id=" + str(nota.elev.id))

	else:

		t = loader.get_template("deletenota.html")
		c = RequestContext(request, { 'title' : title, 'nota' : nota })
		return HttpResponse(t.render(c))


def addMaterie(request):

	title = "Adaug&#259; o Materie"

	if request.method == 'POST':

		form = forms.MaterieForm(request.POST)
		clasa = request.session.get("clasa")

		if form.is_valid():
			materie = models.Materii()
			materie.nume = form.cleaned_data['nume']
			materie.clasa = clasa
			materie.save()

			return HttpResponseRedirect("veziclasa?id=" + str(clasa.id))

		else:

			t = loader.get_template("addmaterie.html")
			c = RequestContext(request, { 'form' : form, 'title' : title, 'clasa' : clasa })
			return HttpResponse(t.render(c))

	else :

		id = request.GET.get("id")
		clasa = models.Clase.objects.get(id = id)

		form = forms.MaterieForm()
		request.session['clasa'] = clasa

		t = loader.get_template("addmaterie.html")
		c = RequestContext(request, { 'form' : form, 'title' : title, 'clasa' : clasa })
		return HttpResponse(t.render(c))

def addElev(request):

	title = "Adaug&#259; un Elev"

	if request.method == 'POST':

		form = forms.ElevForm(request.POST)
		clasa = request.session.get("clasa")

		if form.is_valid():
			elev = models.Elevi()
			elev.nume = form.cleaned_data['nume']
			elev.prenume = form.cleaned_data['prenume']
			elev.clasa = clasa
			elev.save()

			return HttpResponseRedirect("veziclasa?id=" + str(clasa.id))

		else:

			t = loader.get_template("addelev.html")
			c = RequestContext(request, { 'form' : form, 'title' : title, 'clasa' : clasa })
			return HttpResponse(t.render(c))

	else :

		id = request.GET.get("id")
		clasa = models.Clase.objects.get(id = id)

		form = forms.ElevForm()
		request.session['clasa'] = clasa

		t = loader.get_template("addelev.html")
		c = RequestContext(request, { 'form' : form, 'title' : title, 'clasa' : clasa })
		return HttpResponse(t.render(c))

def editMaterie(request):

	if request.method == 'POST':

		materie = request.session.get("materie")
		form = forms.MaterieForm(request.POST)

		if form.is_valid():
			materie.nume = form.cleaned_data['nume']
			materie.save()

			return HttpResponseRedirect("vezimaterie?id=" + str(materie.id))

		else:

			t = loader.get_template("editmaterie.html")
			c = RequestContext(request, { 'form' : form, 'materie' : materie })
			return HttpResponse(t.render(c))

	else:

		id = request.GET.get("id")
		materie = models.Materii.objects.get(id = id)
		form = forms.MaterieForm(instance = materie)
		request.session['materie'] = materie

		t = loader.get_template("editmaterie.html")
		c = RequestContext(request, { "form" : form, 'materie' : materie })
		return HttpResponse(t.render(c))

def editElev(request):

	if request.method == 'POST':

		elev = request.session.get("elev")
		form = forms.ElevForm(request.POST)

		if form.is_valid():
			elev.nume = form.cleaned_data['nume']
			elev.prenume = form.cleaned_data['prenume']
			elev.save()

			return HttpResponseRedirect("vezielev?id=" + str(elev.id))

		else:

			t = loader.get_template("editelev.html")
			c = RequestContext(request, { 'form' : form, 'elev' : elev })
			return HttpResponse(t.render(c))

	else:

		id = request.GET.get("id")
		elev = models.Elevi.objects.get(id = id)
		form = forms.ElevForm(instance = elev)
		request.session['elev'] = elev

		t = loader.get_template("editelev.html")
		c = RequestContext(request, { "form" : form, 'elev' : elev })
		return HttpResponse(t.render(c))

def deleteElev(request):

	title = "&#350;tergere Elev"
	id = request.GET.get("id")
	elev = models.Elevi.objects.get(id = id)

	sigur = request.GET.get("sigur")

	if (sigur == 'da'):

		delete = models.Note.objects.filter(elev = elev).delete()
		delete = models.Elevi.objects.get(id = id).delete()
		return HttpResponseRedirect("veziclasa?id=" + str(elev.clasa.id))

	elif (sigur == 'nu'):

		return HttpResponseRedirect("vezielev?id=" + str(elev.id))

	else:

		t = loader.get_template("deleteelev.html")
		c = RequestContext(request, { 'title' : title, 'elev' : elev })
		return HttpResponse(t.render(c))

def addNota(request):

	title = "Adaug&#259; o Not&#259;"

	if request.method == 'POST':

		form = forms.NotaForm(request.POST)
		elev = request.session.get("elev")

		if form.is_valid():
			nota = models.Note()
			nota.nota = form.cleaned_data['nota']
			nota.materie = form.cleaned_data['materie']
			nota.semestru = form.cleaned_data['semestru']

			jsdate = form.cleaned_data['data']
			pythondate = datetime.datetime.strptime(jsdate, "%d/%m/%Y").date()
			nota.data = pythondate

			nota.elev = elev
			nota.save()

			return HttpResponseRedirect("vezielev?id=" + str(elev.id))

		else:

			t = loader.get_template("addnota.html")
			c = RequestContext(request, { 'form' : form, 'title' : title, 'elev' : elev })
			return HttpResponse(t.render(c))

	else :

		id = request.GET.get("id")
		elev = models.Elevi.objects.get(id = id)

		form = AdaugaNotaForm(elev.clasa)
		request.session['elev'] = elev

		t = loader.get_template("addnota.html")
		c = RequestContext(request, { 'form' : form, 'title' : title, 'elev' : elev })
		return HttpResponse(t.render(c))