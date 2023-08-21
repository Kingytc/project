
PLT_DisplayFormat = "Loading Time of this Particular Page is %%S%% milli seconds.";
PLT_BackColor = "palegreen";
PLT_ForeColor = "navy";
PLT_FontPix = "13";
PLT_FontFamily = "Trebuchet MS";
PLT_DisplayElementID = "display_here";

if (typeof(PLT_BackColor)=="undefined")
	  PLT_BackColor = "white";
	if (typeof(PLT_ForeColor)=="undefined")
	  PLT_ForeColor= "black";
	if (typeof(PLT_DisplayFormat)=="undefined")
	  PLT_DisplayFormat = "Loading Time of this Particular Page is %%S%% milli seconds.";
	if (typeof(PLT_FontPix)=="undefined")
	  PLT_FontPix = "16";
	if (typeof(PLT_DisplayElementID)=="undefined")
	  PLT_DisplayElementID = "";

	dt=new Date();
	document.onreadystatechange=function() {
	  if (document.readyState=="complete") {
	    if ((PLT_Span=document.getElementById(PLT_DisplayElementID)) == null) {
	      //document.body.insertBefore(document.createElement("br"));
	      PLT_Span = document.body.insertBefore(document.createElement("span"));
	    }
	    PLT_DisplayFormat = PLT_DisplayFormat.replace(/%%S%%/g, ((new Date() - dt)));
	   // PLT_Span.style.Color = PLT_ForeColor;
	   // PLT_Span.style.backgroundColor = PLT_BackColor;
	    PLT_Span.style.fontFamily = PLT_FontFamily;
	    PLT_Span.style.fontSize = PLT_FontPix + "px";
	    PLT_Span.innerText = PLT_DisplayFormat;
	    //alert("PLT_DisplayFormat==>"+PLT_DisplayFormat);
		//document.forms[0].hidpageloadtime.value=PLT_DisplayFormat;
	  }
	}