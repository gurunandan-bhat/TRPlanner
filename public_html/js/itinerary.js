/**
 * @author guru
 */

 $(document).ready(function() {

	var currentItinId = $('#frameslideshow').attr('thisitin');
	var totalSlideCount = $('#frameslideshow').attr('maxitinimages');
	var itintype = $('#frameslideshow').attr('itintype');
	var itintypedir = $('#frameslideshow').attr('itintypedir');
	
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

		var imgName = '<img src="/images/' + itintypedir + '/' + itintype + '_'  + (currentItinId) + '_' + (currentImageNum+1) + '.jpg" width="560" height="340" alt="' + (currentImageNum+1) + '" />'; 

		// add our next slide 
		var imgfile = itintype + '_'  + (currentItinId) + '_' + (currentImageNum+1) + '.jpg';
		var imgtag = '<img src="/images/' + itintypedir + '/' + imgfile + '" width="560" height="340" alt="" title="" imgsrno="' + (currentImageNum+1) + '" imgfile="' + imgfile + '" />'; 
		opts.addSlide(imgtag); 
    };

	function onAfter(curr, next, opts) { 
	
		var imgobj = $(this);
		var imgfile = imgobj.attr('imgfile');
		$.getJSON('/getimg_attr/' + imgfile, function(data) {
			imgobj.attr('alt', data.alt);
			imgobj.attr('title', data.title);
		});
    };
})
