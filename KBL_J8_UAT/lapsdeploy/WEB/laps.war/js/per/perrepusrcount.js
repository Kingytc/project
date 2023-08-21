function showPeriod()
{
	document.forms[0].txtDate.value="";
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function doRunReport()
{
	if(document.forms[0].selstatus.value == 'S')
		{
		ShowAlert('111',"Loan Type");
		document.forms[0].selstatus.focus();
		return true;
		} 
		
	if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
		
	var param = setParam();
	var code =document.forms[0].hidOrgCode.value;
	var appno= document.forms[0].hidAppno.value;
	var stat =document.forms[0].hidStatus.value;
	var dt =document.forms[0].txtDate.value;
	var orglevel =document.forms[0].sellevel.value;
	var orgname = document.forms[0].hidOrgName.value;
	var status = document.forms[0].selstatus.value;
	document.forms[0].method="post";
	window.open(path+"action/repusrcount.jsp?hidBeanId=repapptrack&hidBeanMethod=getData&hidMethod=getUserCount&txtDate="+dt+"&hidAppno="+appno+"&hidOrgCode="+code+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&hidstatus="+status,+"track","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
//	window.open(path+"action/perrunapptrack.jsp?hidBeanId=repapptrack&hidBeanMethod=getData&hidMethod=getUserDetails&txtDate="+dt+"&hidStatus="+stat+"&hidAppno="+appno+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf,"track","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
		
//	window.open(path+"action/repusrcount.jsp?hidBeanId=repapptrack&hidBeanMethod=getData&hidMethod=getUserCount&hidAppno="+appno+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+"track","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");	

		
	
}

function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	var usrid =userid;
	var beanid ="repData";
	var action="Insert";
	var source="/action/repapptrack.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var org="";
	var count=0;
	var appno="";
	param="";
	var org_name="";
	
	//if (document.forms[0].txtDate.value == "")
	//{
	//	document.forms[0].txtDate.value="All";
	//}
      var dt =document.forms[0].txtDate.value;
     
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].selappno.selectedIndex != -1
	    && document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
		
//		if(count < 6)

	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   var stat ="";
    count =0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			count++;
			var c = document.forms[0].rpselect1.options[x].value;
			c = c.substring(2,c.length);
			org =org + "'"+c+"'"+",";
			c = document.forms[0].rpselect1.options[x].text;
		    org_name =org_name + " , " + c ;				
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		org_name= org_name.substring(2,org_name.length);
	}
	 
    count =0;
	for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			count++;
			var n = document.forms[0].selappno.options[x].value;
			appno =appno + "'"+n+"'"+",";
					
		}
	}
	/*
	if (count > 10)
	{
		ShowAlert('111',"only 10 users");
	
		for(x=0;x<document.forms[0].selappno.length;x++)
		{
			if (document.forms[0].selappno[x].selected)
			{
				document.forms[0].selappno[x].selected = false;													
			}
		}
	
		document.forms[0].selappno.focus();
		return false;
	
	}
	*/
	if (count > 0)
	{
		appno= appno.substring(0,appno.length-1);
	}
	param =orgcode+";"+org+";"+appno+";";

	
	param +=opfields+";";
	param +=dbfields+";"+stat;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value=org; 
	document.forms[0].hidAppno.value=appno; 
	document.forms[0].hidOrgName.value =org_name;		
//	document.forms[0].hidOpFields.value =opfields;	
//	document.forms[0].hidStatus.value =stat;	
//	document.forms[0].hidSelFields.value =dbfields;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	/*else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}*/
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','User');
		document.forms[0].selappno.focus();
		return false;
	}
	return param;
}

function browse()
{
	var user=userid;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var repname=document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtDate.value ="";
	document.forms[0].selstatus.value="S";
	resetno();
}

function resetno()
{
	for(i=0;i<document.forms[0].selappno.length;i++)
	{
		document.forms[0].selappno.options[i].selected =false;
		document.forms[0].selappno.options[i].text = "";
		document.forms[0].selappno.options[i].value = "";
	}
	document.forms[0].selappno.length =0;
	document.forms[0].rpselect1.selectedIndex =-1;
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
	
	document.forms[0].reset();
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action = path+"action/apprepnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	resetno();
//		document.forms[0].cmbstatus.selectedIndex=0;
		var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function refreshAppno()
{

	var appno ="";
	count =0;
	var org="";
	 var stat ="";
	/*if(document.forms[0].rpselect1.selectedIndex != -1
		&& document.forms[0].cmbstatus.selectedIndex != 0)
	{*/
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + "'"+c+"'"+",";
						
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
    	}
 //var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;		
	document.all.ifrm.src=path+"action/iframeperusertrack.jsp?hidBeanMethod=getData&hidMethod=getUsers&hidBeanId=perrepapptrack&hidStatus="+stat+"&hidOrgCode="+org;
		
		
	//}
	
	/*else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
			ShowAlert('111','Organisation');
			document.forms[0].rpselect1.focus();
			return false;
	}
	else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		document.forms[0].rpselect1.selectedIndex=-1;
		return false;
	}*/
}
function resetData()
{
	document.forms[0].rpselect1.selectedIndex=-1;
	document.forms[0].selappno.length=0;
}