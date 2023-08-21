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

function runrep()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var appno= document.forms[0].hidAppno.value;
	var dt =document.forms[0].txtDate.value;
	var stat =document.forms[0].hidStatus.value;
	var orgname = document.forms[0].hidOrgName.value;
	//var dt =document.forms[0].txtDate.value;
	if (param !="")
	{
	document.forms[0].method="post";
	window.open(path+"action/opsrunapptrack.jsp?hidBeanId=opsreport&hidBeanMethod=getData&hidMethod=getOpsAppTracking&txtDate="+dt+"&hidStatus="+stat+"&hidAppno="+appno+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgName="+orgname,"track","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
	}
		
	
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
		purl =path+"action/savereport1.jsp?BeanId="+beanid+"&Action="+action;
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
	
	if (document.forms[0].txtDate.value == "")
	{
		document.forms[0].txtDate.value="All";
	}
      var dt =document.forms[0].txtDate.value;
      

      
      
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].cmbstatus.selectedIndex != 0  
	&& document.forms[0].selappno.selectedIndex != -1 &&
	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
		
	for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }


		if(count == 0)
		{

			for(i=0;i<6;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}

	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
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
			org_name =org_name + "," + c ;			
		}
	}
	if (count > 0)
	{
		org= org.substring(0,org.length-1);
		org_name= org_name.substring(1,org_name.length);
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
	if (count > 10)
	{
		
		ShowAlert('111',"only 10 Application Numbers");
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
	if (count > 0)
	{
		appno= appno.substring(0,appno.length-1);
	}
	//param =orgcode+";"+org+";"+appno+";";
      param =orgcode+";"+org+";"+stat+";"+dt+";"+appno+";";
      for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
					count++;
					if(document.forms[0].rpselect2.options[x].text=='Date')
					{
						if(document.forms[0].cmbstatus.value=='A')
						{
						dbfields =dbfields + "Approved Date,";
						}
						else if(document.forms[0].cmbstatus.value=='R')
						{
						dbfields =dbfields + "Rejected Date,";
						}
						else if(document.forms[0].cmbstatus.value=='P')
						{
						dbfields =dbfields;
						}
					}
					
					else if(document.forms[0].rpselect2.options[x].text=='Branch')
					{
					    if(document.forms[0].sellevel.value!='A')
						{
						dbfields =dbfields + "Branch,";
						}
						else if(document.forms[0].sellevel.value=='A')
						{
						dbfields =dbfields;
						}
					}
					else
					{
					dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
					}
					opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
			}
		}
	//for(x=0;x<document.forms[0].rpselect2.length;x++)
	//{
	//	if (document.forms[0].rpselect2[x].selected)
	//	{
		//		count++;
		//		opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
		//		dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
	//	}
	//}

	if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields+";"+stat;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value=org; 
	document.forms[0].hidAppno.value=appno; 
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidStatus.value =stat;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','Application Number');
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
	purl =path+"action/browserreport1.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].cmbstatus.selectedIndex=0;
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

function nav()
{
	if (ConfirmMsg("100"))
	{
	
	document.forms[0].reset();
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action = path+"action/tertiary_report.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	resetno();
		document.forms[0].cmbstatus.selectedIndex=0;
		var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function refreshAppno()
{
	var appno ="";
	count =0;
	var org="";
	var varprodtype="";
	
	if(document.forms[0].rpselect1.selectedIndex != -1
		&& document.forms[0].cmbstatus.selectedIndex != 0)
	{
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
	 var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;		
		document.all.ifrm.src=path+"action/iframeopsapptrack.jsp?hidBeanMethod=getData&hidMethod=getOpsAppno&hidBeanId=opsreport&hidStatus="+stat+"&hidOrgCode="+org+"&prodtype="+varprodtype;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
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
	}

}
function resetData()
{
	document.forms[0].rpselect1.selectedIndex=-1;
	document.forms[0].selappno.length=0;
}