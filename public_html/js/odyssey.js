/**
 * @author guru
 */

 $(document).ready(function() {

	var baseprefix = $('body').attr('baseprefix');

	$("#hotels").hide();
	$("#places").hide();
	$("#otheroptions").hide();
	$("#hotels div.detail").hide();
	$("tr.summarydetail").hide();
	$("tr.summaryrow").click(function() {
		$("tr.summarydetail").hide();
		$(this).next("tr").toggle();
	});

	$('p.toggler a').click(function() {
		$(this).parent('p').prev('div.brief').toggle();
		$(this).parent('p').next('div.detail').toggle();
		return false;
	});
	
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

	var currentCityId = $('#slideshow').attr('thiscity');
	var totalSlideCount = $('#slideshow').attr('maxcityimages')

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

		var imgName = '<img src="' + baseprefix + 'images/city_' + (currentCityId) + '_large_' + (currentImageNum+1) + '.jpg" width="580" height="340" alt="' + (currentImageNum+1) + '" />'; 

		// add our next slide 
        opts.addSlide(imgName); 
    };
	
	$("a#showmoreopts").click(function() {
		$("#otheroptions").toggle('slow');
		return false;
	});
	
	$('p.hoteldetail a').click(function() {
		$(this).parents('div.overview').siblings('div.accommodation').toggle('slow');
		return false;
	});

	$('select#keyword').change(function() {
		var nlink = this.value;
		if (nlink == 0) {
			return false;
		}
		window.location = nlink;
	});
})
