<script>
	var currentHotelId = $('#minislideshow').attr('thishotel');
	var totalSlideCount = $('#minislideshow').attr('maxhotelimages')

	$('#minislideshow').cycle({ 
		fx:      'fade', 
		timeout:  5000,
		before:   miniOnBefore 
	}); 
 
	function miniOnBefore(curr, next, opts) { 
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

		var imgName = '<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_' + (currentHotelId) + '_large_' + (currentImageNum+1) + '.jpg" width="400" height="240" alt="' + (currentImageNum+1) + '" />'; 

		// add our next slide 
        opts.addSlide(imgName); 
    };
</script>
<style>
	#minislideshow {
		height: 240px;
		width: 400px;
		overflow: hidden;
	}
	h3.inset {
		padding: 8px 0 24px 0;
		border-top: 1px solid #ddcdae;
		background: url('images/hr-bg-tan.gif') center bottom no-repeat;
		text-align: center;
		margin-bottom: 0px;
	}

</style>
<h3 class="inset"><!-- TMPL_VAR NAME=HOTELNAME --></h3>
<div id="minislideshow" thishotel="<!-- TMPL_VAR NAME=HOTELID -->" maxhotelimages="<!-- TMPL_VAR NAME=NUMIMAGES -->">
	<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_1.jpg" width="400" height="240" alt="1" />
	<img src="<!-- TMPL_VAR NAME=BASEPREFIX -->images/hotel/hotel_<!-- TMPL_VAR NAME=HOTELID -->_large_2.jpg" width="400" height="240" alt="2" />
</div>
<hr class="space" />
<!-- TMPL_VAR NAME=HOTELDESCRIPTION -->
