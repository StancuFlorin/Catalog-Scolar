from django.db import models

AnOptions = (
		("2012 - 2013", "2012 - 2013"),
		("2013 - 2014", "2013 - 2014"),
		("2014 - 2015", "2014 - 2015"),
		("2015 - 2016", "2015 - 2016")
	)

StatusOptions = (
		(0, "Inceput de an Scolar"),
		(1, "Sfarsit Semestrul I"),
		(2, "Sfarsit de an Scolar")
	)

class Clase(models.Model):
	id = models.AutoField(primary_key = True)
	nume = models.CharField(max_length = 100)
	an = models.CharField(max_length = 100, choices = AnOptions)
	profesor = models.CharField(max_length = 100)
	status = models.IntegerField(choices = StatusOptions)
	descriere = models.TextField()

class Elevi(models.Model):
	id = models.AutoField(primary_key = True)
	nume = models.CharField(max_length = 100)
	prenume = models.CharField(max_length = 100)
	clasa = models.ForeignKey(Clase)

class Materii(models.Model):
	id = models.AutoField(primary_key = True)
	nume = models.CharField(max_length = 100)
	clasa = models.ForeignKey(Clase)

NoteOptions = (
		(4, "Foarte Bine"),
		(3, "Bine"),
		(2, "Suficient"),
		(1, "Insuficient")
	)

SemestreOptions = (
		(1, "Semestrul I"),
		(2, "Semestrul II")
	)

class Note(models.Model):
	id = models.AutoField(primary_key = True)
	materie = models.ForeignKey(Materii)
	semestru = models.IntegerField(choices = SemestreOptions)
	nota = models.IntegerField(choices = NoteOptions)
	elev = models.ForeignKey(Elevi)
	data = models.CharField(max_length = 100)