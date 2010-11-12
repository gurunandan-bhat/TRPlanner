var so = new SWFObject("../maps/ammap.swf", "ammap", "100%", "100%", "8", "#ffffff");
so.addVariable("path", "../maps/");
so.addVariable("data_file", escape("maps/ammap_data.xml"));
so.addVariable("settings_file", escape("maps/ammap_settings.xml"));		
so.addVariable("preloader_color", "#ffffff");
so.write("flashmap");
