from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'CatalogScolar.views.home', name='home'),
    # url(r'^CatalogScolar/', include('CatalogScolar.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),

    url(r'^$', 'catalog.views.index'),
    url(r'^adaugaclasa$', 'catalog.views.addClasa'),
    url(r'^veziclasa$', 'catalog.views.viewClasa'),
    url(r'^adaugamaterie$', 'catalog.views.addMaterie'),
    url(r'^adaugaelev$', 'catalog.views.addElev'),
    url(r'^vezielev$', 'catalog.views.viewElev'),
    url(r'^adauganota$', 'catalog.views.addNota'),
    url(r'^modificaclasa$', 'catalog.views.editClasa'),
    url(r'^stergenota$', 'catalog.views.deleteNota'),
    url(r'^modificaelev$', 'catalog.views.editElev'),
    url(r'^stergeelev$', 'catalog.views.deleteElev'),
    url(r'^graficmaterie$', 'catalog.views.graficMaterie'),
    url(r'^exportgraficmaterie$', 'catalog.views.exportGraficMaterie'),
    url(r'^vezimaterie$', 'catalog.views.viewMaterie'),
    url(r'^modificamaterie$', 'catalog.views.editMaterie'),
    url(r'^exportamaterie$', 'catalog.views.exportMaterie'),
    url(r'^exportamedii$', 'catalog.views.exportMedii'),
)
