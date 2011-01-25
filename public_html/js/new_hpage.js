/**
 * @author guru
 */

 $(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');
	var totalSlideCount = $('#slideshow').attr('maxhomeimages');
	
	$('#slideshow').cycle({ 
		fx:      'fade', 
		timeout:  5000,
		before:   onBefore 
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

		var currentImageNum = parseInt(next.alt);  

		if (currentImageNum == totalSlideCount) { 
            // final slide in our slide slideshow is about to be displayed 
			// so there are no more to fetch 
            opts.addSlide = null; 
			return; 
		} 

		var imgName = '<img src="' + baseprefix + 'images/home/hp_' + (currentImageNum+1) + '.jpg" width="560" height="325" alt="' + (currentImageNum+1) + '" />'; 

		// add our next slide 
        opts.addSlide(imgName); 
    };
})
