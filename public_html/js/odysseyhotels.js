/**
 * @author guru
 */

 $(document).ready(function() {

/*	$(document).bind('contextmenu', function(e) {
		return false
	});
*/

	var baseprefix = $('body').attr('baseprefix');
	 
	$("#hotels").hide();
	$("#places").hide();
	$("#otheroptions").hide();
	
	var current = 'defaulthotel';
	
	$("#tabs a").click(function() {
		var clicked = $(this).attr("title");
		if (clicked == current) {
			return false;
		}
		else {
			$("a[title=" + current + "]").parent("li").removeClass("selected");
			$("#" + current).hide();
			$("a[title=" + clicked + "]").parent("li").addClass("selected");
			$("#" + clicked).show();
			current = clicked;
			return false;
		}
	});

	var currentHotelId = $('#frameslideshow').attr('thishotel');
	var totalSlideCount = $('#frameslideshow').attr('maxhotelimages')

	$('#frameslideshow').cycle({ 
		fx:      'fade', 
		timeout:  6000,
		before:   onBefore,
		after:    onAfter
	}); 
 
	function onBefore(curr, next, opts) { 
		// on the first pass, addSlide is undefined (plugin hasn't yet created the fn); 
		// when we're finshed adding slides we'll null it out again

		if (!opts.addSlide) 
			return; 

		// on Before arguments: 
		//  curr == DOM element for the slide that is currently being displayed 
		//  next == DOM element for the slide that is about to be displayed 
		//  opts == slideshow options 

		var currentImageNum = parseInt($(next).attr('imgsrno'));  

		if (currentImageNum == totalSlideCount) { 
            // final slide in our slide slideshow is about to be displayed 
			// so there are no more to fetch 
            opts.addSlide = null; 
			return; 
		} 

		// add our next slide 
		var imgfile = 'hotel_' + (currentHotelId) + '_large_' + (currentImageNum+1) + '.jpg';
		var imgtag = '<img src="' + baseprefix + 'images/hotel/' + imgfile + '" width="560" height="340" alt="" title="" imgsrno="' + (currentImageNum+1) + '" imgfile="' + imgfile + '" />'; 
		opts.addSlide(imgtag); 
    };
	
	function onAfter(curr, next, opts) { 
	
		var imgobj = $(this);
		var imgfile = imgobj.attr('imgfile');
		$.getJSON(baseprefix + 'getimg_attr/' + imgfile, function(data) {
			imgobj.attr('alt', data.alt);
			imgobj.attr('title', data.title);
		});
    };

	$("a#showmoreopts").click(function() {
		$("#otheroptions").toggle('slow');
		return false;
	});

})


$(document.body).unload(function() {
	if (GBrowserIsCompatible()) {
		GUnload();
	}
})
