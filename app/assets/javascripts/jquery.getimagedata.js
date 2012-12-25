/*
 *
 *  jQuery $.getImageData Plugin 0.3
 *  http://www.maxnov.com/getimagedata
 *  
 *  Written by Max Novakovic (http://www.maxnov.com/)
 *  Date: Thu Jan 13 2011
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  
 *  Copyright 2011, Max Novakovic
 *  Dual licensed under the MIT or GPL Version 2 licenses.
 *  http://www.maxnov.com/getimagedata/#license
 * 
 */

(function( $ ){

	// jQuery getImageData Plugin
	$.getImageData = function(args) {
	
		var regex_url_test = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
	
		// If a URL has been specified
		if(args.url) {
		
			// Ensure no problems when using http or http
			var is_secure = location.protocol === "https:";
			var server_url = "";
		
			// If url specified and is a url + if server is secure when image or user page is
			if(args.server && regex_url_test.test(args.server) && (args.server.indexOf('https:') && (is_secure || args.url.indexOf('https:')))) {
				server_url = args.server;
			} else server_url = "//img-to-json.appspot.com/";
		
			server_url += "?callback=?";
		
			// Using jquery-jsonp (http://code.google.com/p/jquery-jsonp/) for the request
			// so that errors can be handled
			$.jsonp({	
				url: server_url,
				data: { url: escape(args.url) },
				dataType: 'jsonp',
				timeout: 10000,
				// It worked!
				success: function(data, status) {
			
					// Create new, empty image
					var return_image = new Image();
				
					// When the image has loaded
					$(return_image).load(function(){
					
						// Set image dimensions
						this.width = data.width;
						this.height = data.height;
					
						// Return the image
						if(typeof(args.success) == typeof(Function)) {
							args.success(this);
						}
					
					// Put the base64 encoded image into the src to start the load
					}).attr('src', data.data);
				
			  },
				// Something went wrong.. 
				error: function(xhr, text_status){
					// Return the error(s)
					if(typeof(args.error) == typeof(Function)) {
						args.error(xhr, text_status);
					}
				}
			});
		
		// No URL specified so error
		} else {
			if(typeof(args.error) == typeof(Function)) {
				args.error(null, "no_url");
			}
		}
	};

})(jQuery);
