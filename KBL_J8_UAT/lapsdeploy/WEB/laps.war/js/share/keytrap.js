document.onkeydown = function()
{
	if(window.event && window.event.keyCode == 8) 
    {
		// Capture and remap F5
		window.event.keyCode = 606;
  	}
	//if(window.event && window.event.keyCode == 606) 
    // {  New action for F5
		//return false; 
        // Must return false or the browser will refresh anyway
	//}
	if(window.event && window.event.keyCode == 116) 
    { // Capture and remap F5
		window.event.keyCode = 505;
  	}
	if(window.event && window.event.keyCode == 505) 
    { // New action for F5
		return false; 
    	// Must return false or the browser will refresh anyway
	}
	/*if((window.event && window.event.keyCode==78) || (window.event && window.event.keyCode==110))
	{
		// New Action for Ctrl+N
		if(window.event && window.event.ctrlKey)
		{
			// Must return false or the browser will open new window
			window.event.returnValue = false;
			window.event.keyCode = 0;
		}
		 return false;
	}
	
	if((window.event && window.event.keyCode==84) || (window.event && window.event.keyCode==116))
	{
		// New Action for Ctrl+T
		if(window.event && window.event.ctrlKey)
		{
			// Must return false or the browser will open new Tab
			window.event.returnValue = false;
			window.event.keyCode = 0;
		}
		 return false;
	}*/
}

