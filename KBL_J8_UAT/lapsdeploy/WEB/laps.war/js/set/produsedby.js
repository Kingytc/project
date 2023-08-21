	function setButtons()
	{
		document.prdusedfrm.cmdedit.disabled = false;
		document.prdusedfrm.cmdsave.disabled = true;
		document.prdusedfrm.cmdcancel.disabled = true;
		document.prdusedfrm.cmdclose.disabled = false;
		disableAll();
	}

	function disableAll()
	{
		for(i=0;i<document.prdusedfrm.radioOrg.length;i++)
		{
			document.prdusedfrm.radioOrg[i].disabled = true;
		}
		document.prdusedfrm.selInsti.disabled = true;
		document.prdusedfrm.seldInsti.disabled = true;
	}

	function disableFields()
	{
		for(i=0;i<document.prdusedfrm.radioOrg.length;i++)
		{
			document.prdusedfrm.radioOrg[i].disabled = false;
		}
		document.prdusedfrm.selInsti.disabled = false;
		document.prdusedfrm.seldInsti.disabled = false;
	}

	function setOptions(lvl)
	{
		document.prdusedfrm.selInsti.options.length = 0;
		document.prdusedfrm.seldInsti.options.length = 0;
		if(lvl == 'null')
			lvl = 'C';
		
		if(lvl == 'C')
		{
			document.prdusedfrm.radioOrg[0].checked = true;	
			var i=0;
			for(j=0;j<arrNames.length;j++)
				{
				var value = arrNames[j];
				if( value.substring(0,1) == 'C')
					{
					document.prdusedfrm.selInsti.options[i] = new Option(value.substring(1,value.length),arrKeys[j]);
					i++;
					}
				}
			}
			else if(lvl == 'R')
				{
				document.prdusedfrm.radioOrg[1].checked = true;
				i=0;
				for(j=0;j<arrNames.length;j++)
					{
					var value = arrNames[j];
					if( value.substring(0,1) == 'R')
						{
						document.prdusedfrm.selInsti.options[i] = new Option(value.substring(1,value.length),arrKeys[j]);
						i++;
						}
					}
				}
			else if(lvl == 'D')
				{
				document.prdusedfrm.radioOrg[2].checked = true;
				i=0;
				for(j=0;j<arrNames.length;j++)
					{
					var value = arrNames[j];
					if( value.substring(0,1) == 'D')
						{
						document.prdusedfrm.selInsti.options[i] = new Option(value.substring(1,value.length),arrKeys[j]);
						i++;
						}
					}
				}
		else if(lvl == 'A')
		{
			document.prdusedfrm.radioOrg[3].checked = true;
			i=0;
			for(j=0;j<arrNames.length;j++)
			{
				var value = arrNames[j];
				if( value.substring(0,1) == 'A')
				{
					document.prdusedfrm.selInsti.options[i] = new Option(value.substring(1,value.length),arrKeys[j]);
					i++;
				}
			}
		}
		else if(lvl == 'B')
		{
			document.prdusedfrm.radioOrg[4].checked = true;
			i=0;
			for(j=0;j<arrNames.length;j++)
			{
				var value = arrNames[j];
				if( value.substring(0,1) == 'B')
				{
					document.prdusedfrm.selInsti.options[i] = new Option(value.substring(1,value.length),arrKeys[j]);
					i++;
				}
			}
		}
	}

function selectedProduct()
{
	if(document.prdusedfrm.selInsti.selectedIndex != -1)
	{
		var s = document.prdusedfrm.selInsti.options[document.prdusedfrm.selInsti.selectedIndex].value;
	
		var s1 = document.prdusedfrm.selInsti.options[document.prdusedfrm.selInsti.selectedIndex].text;

		var s2 = document.prdusedfrm.seldInsti.length;
		var s3 = true;

		for(var i=0;i<s2;i++)
		{
			var s4= document.prdusedfrm.seldInsti.options[i].value;
			if( s == s4 )
			{
				s3 = false;
				break;
			}
		}
		if(s3)
		{
			document.prdusedfrm.seldInsti.disabled = false;
			newopt = new Option(s1,s);			
			document.prdusedfrm.seldInsti.options[document.prdusedfrm.seldInsti.length] = newopt;
		}
	}
}

function checkRemove()
{
	if(document.prdusedfrm.seldInsti.length > 0)
	{
		if( document.prdusedfrm.seldInsti.selectedIndex != -1)
		{
			removeSelected();
		}
	}
	else
	{
		document.prdusedfrm.seldInsti.disabled = true;
	}
}
 
function removeSelected()
{
	document.prdusedfrm.seldInsti.options[document.prdusedfrm.seldInsti.selectedIndex] = null;
}
	
function doEdit()
{
	document.prdusedfrm.hidAction.value="UPDATE";
	disableFields();
	document.prdusedfrm.cmdedit.disabled = true;
	document.prdusedfrm.cmdsave.disabled = false;
	document.prdusedfrm.cmdcancel.disabled = false;
	document.prdusedfrm.cmdclose.disabled = true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		setData();
	}
}

function doSave()
{
	var str = "";
	for(i=0;i<document.prdusedfrm.seldInsti.length;i++)
	{
		str = str + document.prdusedfrm.seldInsti.options[i].value+";";
	}
	
	if(str=='')
	{
		alert("Select the organisation");
	}
	else
	{
		var seldInsti1="";
		var k=0;
		var len1 = document.forms[0].seldInsti.length;	
		for(i=0;i<len1;i++)
		{		
			 if(k!=0)
			 {
			 	seldInsti1 =seldInsti1+", ";
			 }
			 seldInsti1 = seldInsti1 + document.forms[0].seldInsti.options[i].text; 
		 	 k++;
		}
		document.forms[0].seldInsti1.value=seldInsti1;
	
		document.prdusedfrm.hidSeldInsti.value = str;
		for(i=0;i<document.prdusedfrm.elements.length;i++)
		{
			document.prdusedfrm.elements[i].disabled = false;	
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.prdusedfrm.hidBeanId.value="setusedby";
		document.prdusedfrm.hidBeanMethod.value="updateData";
		document.prdusedfrm.hidBeanGetMethod.value="getData";
		document.prdusedfrm.hidSourceUrl.value="/action/produsedby.jsp";
		document.prdusedfrm.hidAction.value="INSERT";
		document.prdusedfrm.submit();
	}
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		document.forms[0].submit();
	}
}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}