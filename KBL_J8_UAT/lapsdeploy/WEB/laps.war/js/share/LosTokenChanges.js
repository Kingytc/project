function openWindowUsingFormForLogin(params,varQryString,prop,title)
{
	var form = document.createElement("form");
	form.setAttribute("method", "post");
	form.setAttribute("action", varQryString);
	form.setAttribute("target", title);
	//params["hidTypeMap"]=retType();
	//params["hidType2Map"]=retType2();
	params["action"]=varQryString;
	var elementresponse=params;
	 for (var i in params)
	 {
	   if (params.hasOwnProperty(i))
	   {
	     var input = document.createElement('input');
	     input.type = 'hidden';
	     input.name = i;
	     input.value = params[i];
	     form.appendChild(input);
	   }
	 }
	 var JSONinputs=document.createElement('input');
	 JSONinputs.type = 'hidden';
	 JSONinputs.name = 'hidJsonMap';
	 JSONinputs.id = 'hidJsonMap';
	 //JSONinputs.value = commonFuncForTest(elementresponse);
     //form.appendChild(JSONinputs);
	
	 document.body.appendChild(form);
	 window.open("", title, prop);
	 form.submit();
	 document.body.removeChild(form);
}
