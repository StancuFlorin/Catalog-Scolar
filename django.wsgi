import os, sys
sys.path.append('/home/florin/Projects/CatalogScolar')
os.environ['DJANGO_SETTINGS_MODULE'] = 'CatalogScolar.settings'
import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()