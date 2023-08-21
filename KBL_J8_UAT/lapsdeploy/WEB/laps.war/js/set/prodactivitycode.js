function callOnLoad()
{
	disableFields(true);
	disableCommandButtons(true,false,true,true,false,true);
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(false,true,false,false,true,false);
}
function doSave()
{
	var strAppend = "";
	for(i=0;i<document.forms[0].sel_ActivityCodeChosen.length;i++)
	{
		strAppend = strAppend + document.forms[0].sel_ActivityCodeChosen.options[i].value+"~";
	}
	if(strAppend=='')
	{
		alert("Select the Activity Codes");
		return;
	}
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;	
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidActivityCodeChosen.value = strAppend;
	document.forms[0].hidBeanMethod.value="updatePrdAcitivityCodeData";
	document.forms[0].hidBeanGetMethod.value="getPrdAcitivityCodeData";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidSourceUrl.value="/action/prodactivitycode.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getPrdAcitivityCodeData";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].action=appURL+"action/prodactivitycode.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{	
	var prdcode=document.forms[0].hidmoduletype.value;
	if(ConfirmMsg(100))
	{
		if (prdcode=="c"||prdcode=="a")
		{
			document.forms[0].action=appURL+"action/comfacilityhome.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/setsearchproducts.jsp";
			document.forms[0].submit();
		}
	}
}
function disableFields(binaryVal)
{
	document.forms[0].sel_ActivityCode.disabled=binaryVal;
	document.forms[0].sel_ActivityCodeChosen.disabled=binaryVal;
}
function disableCommandButtons(binary1,binary2,binary3,binary4,binary5,binary6)
{
	document.forms[0].cmdMove.disabled = binary1;
	document.forms[0].cmdedit.disabled = binary2;
	document.forms[0].cmdsave.disabled = binary3;
	document.forms[0].cmdcancel.disabled = binary4;
	document.forms[0].cmdclose.disabled = binary5;
	document.forms[0].cmdRemove.disabled = binary6;
}
function selectedProduct()
{
	var bool ="false";
	var sel=document.forms[0].sel_ActivityCode;
	var seld=document.forms[0].sel_ActivityCodeChosen;
	if(sel.selectedIndex!=-1)
	{
		var count=0;
		for(var k=0;k<sel.length;k++)
		{
			if(sel.options[k].selected)
			{
				count++;
			}
			else{
				continue;
			}
		}
		if(count<5000)
		{
		for(var k=0;k<sel.length;k++)
		{
			if(sel.options[k].selected)
			{	
				var value2=sel.options[k].value;
				var text1=sel.options[k].text;
				count++;
				
				for(var j=0;j<seld.options.length;j++)
				{
					bool ="false";
					if(value2==seld[j].value)
					{	bool = "true";
						break;
					}
					else
					{	continue;
					}
				}
				if(bool=="false")
				{	seld.options[j]=new Option(text1,value2);
				}
			}
		}
		}else{
			alert("You can't move the Activity  more than 5000 at a time");
		}
		sel.selectedIndex=-1;
	}
}
function checkRemove()
{
	if(document.forms[0].sel_ActivityCodeChosen.length > 0)
	{
		if( document.forms[0].sel_ActivityCodeChosen.selectedIndex != -1)
		{			removeSelected();
		}
	}
}
function removeSelected()
{
	for(var i=document.forms[0].sel_ActivityCodeChosen.length-1;i>=0;i--)
	{
		if(document.forms[0].sel_ActivityCodeChosen.options[i].selected==true)
		{
			document.forms[0].sel_ActivityCodeChosen.options[document.forms[0].sel_ActivityCodeChosen.selectedIndex] = null;
		}
	}
}
function sortSelect(selectToSort) 
{
    var arrOptions = [];
    for (var i = 0; i < selectToSort.options.length; i++)  
    { 	arrOptions[i] = [];
        arrOptions[i][0] = selectToSort.options[i].text;
        arrOptions[i][1] = selectToSort.options[i].value;
        arrOptions[i][2] = selectToSort.options[i].selected;
    }
    arrOptions.sort();
    for (var i = 0; i < selectToSort.options.length; i++)  
    {   selectToSort.options[i].value = arrOptions[i][1];
        selectToSort.options[i].text = arrOptions[i][0];
        selectToSort.options[i].selected = arrOptions[i][2];
    }
}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{	document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		if(val=="existing")
		{			ShowAlert(144);
		}
	}
}