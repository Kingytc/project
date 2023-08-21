function runrep()
{
	if(document.forms[0].sellevel.selectedIndex != 0 
	&& document.forms[0].rpselect1.selectedIndex != -1 &&
		document.forms[0].selappno.selectedIndex != -1 ) 
	{
	
	var count =0;
	var appno="";

	for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			count++;
			var c = document.forms[0].selappno.options[x].value;
			appno =appno + "'"+c+"'"+",";
					
		}
	}
	if (count > 0)
	{
		appno= appno.substring(0,appno.length-1);
	}
	count=0;
	var org="";
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			org =org + "'"+c.substring(2,c.length)+"'"+",";
					
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
	}
	var rd = document.forms[0].selopt.value;
	window.open(path+"action/comrundoc.jsp?hidBeanId=repappdoc&hidBeanMethod=getData&hidMethod=getRepDetails&&field="+rd+"&loantype=C&hidOrgCode="+org+"&hidAppno="+appno,"doc","scrollbars=Yes,toolbar=No,menubar=no,width=750,height=550,top=10,left=10");
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111',"Organisation");
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','Application Number');
		document.forms[0].selappno.focus();
		return false;
	}
}
function resetValues()
{
	document.forms[0].reset();
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].selappno.length=0;
}

function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].action=path+"action/comrepappnav.jsp";
		document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	resetData();
	//var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
    //bnkname = bnkname.substring(0,1); 
	bnkname =document.forms[0].sellevel.selectedIndex
	if(bnkname=="1")
	{
		bnkname="C";
	}
	else if(bnkname=="2")
	{
		bnkname="R";
	}
	else if(bnkname=="3")
	{	
		bnkname="D";
	}
	else if(bnkname=="4")
	{
		bnkname="A";
	}
	else if(bnkname=="5")
	{
		bnkname="B";
	}

	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}


function selectData()
{   for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			document.forms[0].selappno.options[x].selected=false;
								
		}
	}
	document.forms[0].selappno.length=0;
	if (document.forms[0].sellevel.selectedIndex != 0)  
	{
		if(document.forms[0].rpselect1.selectedIndex != -1)
		{
			if(document.forms[0].selopt.selectedIndex != 0)
			{	
				showAppno();
			}
			else
			{
				document.forms[0].selappno.length=0;
			}
		}
		else
		{
			ShowAlert('111',"Organisation");
			document.forms[0].rpselect1.focus();
			document.forms[0].selopt.selectedIndex=0;
		
			
		}
	}
	else 
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		document.forms[0].selopt.selectedIndex=0;
		
		
	}
		
}

function showAppno()
{
	
	var field = document.forms[0].selopt.options[document.forms[0].selopt.selectedIndex].value;
	var bnkcode = document.forms[0].rpselect1.options[document.forms[0].rpselect1.selectedIndex].value;
	var bnk = "'"+bnkcode.substring(2,bnkcode.length)+"'";

	document.all.ifrm.src=path+"action/iframeprimrep.jsp?hidBeanMethod=getData&hidMethod=getAppno&hidBeanId=repappdoc&loantype=C&field="+field+"&org="+bnk;

}
function resetData()
{
	document.forms[0].selappno.length=0;
	document.forms[0].selopt.selectedIndex=0;
}