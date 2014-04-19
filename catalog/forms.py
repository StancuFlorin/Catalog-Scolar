from django import forms
from django.forms import ModelForm, ModelChoiceField

from models import Clase, Materii, Elevi, Note

class ClasaForm(ModelForm):
	descriere = forms.CharField(required = False, widget = forms.Textarea)

	class Meta:
		model = Clase

class MaterieForm(ModelForm):
	class Meta:
		model = Materii
		exclude = ('clasa')

class ElevForm(ModelForm):
	class Meta:
		model = Elevi
		exclude = ('clasa')


def AdaugaNotaForm(clasa):
	class NotaForm(ModelForm):

		class MaterieSelect(ModelChoiceField):
			def label_from_instance(self, obj):
				return obj.nume

		materie = MaterieSelect(queryset = Materii.objects.filter(clasa = clasa))

		class Meta:
			model = Note
			exclude = ('elev')

	return NotaForm

class NotaForm(ModelForm):
	class Meta:
		model = Note
		exclude = ('elev')