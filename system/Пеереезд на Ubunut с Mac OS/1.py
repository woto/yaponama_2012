import urllib2, pdb
opener = urllib2.build_opener(urllib2.HTTPHandler)
request = urllib2.Request('http://kaprika.ru:7379/SET/logo', data=open("../work/result.jpg").read())
#request.add_header('Content-Type', 'image/jpeg')
request.get_method = lambda: 'PUT'
url = opener.open(request)
pdb.set_trace()
