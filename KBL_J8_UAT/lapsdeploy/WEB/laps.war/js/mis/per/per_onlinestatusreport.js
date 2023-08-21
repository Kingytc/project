function showPeriod()
{
	document.forms[0].txtDate.value="";
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=400,height=400";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var stat =document.forms[0].hidStatus.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var fromdt=document.forms[0].txtFromDate.value;
	var todt=document.forms[0].txtToDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var orgname = document.forms[0].hidOrgName.value;
	var loantype = "";
	
	for(var i=0;i<document.forms[0].selprodtype.options.length;i++)
	{
		if(document.forms[0].selprodtype.options[i].selected)
		{
			loantype = loantype + document.forms[0].selprodtype.options[i].value+"@";
		}
	}
	
	if (param !="")
	{
		window.open(path+"action/per_onlineReportDisp.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getOnlineReport&hidStatus="+stat+"&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&loantype="+loantype,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=950 , height=550,top=10,left=10");
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
	var source="/action/perrepappstatus.jsp";
	var repname=document.forms[0].repname.value;
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var stat =document.forms[0].hidStatus.value;
	//var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	//var txtfromamt=document.forms[0].txtfromamt.value;
	//var txttoamt=document.forms[0].txttoamt.value;
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
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].cmbstatus.selectedIndex != 0  
		&& document.forms[0].rpselect1.selectedIndex != -1 
		&& document.forms[0].selprodtype.selectedIndex != 0) 
	{

	var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
		

	for (i=0;i<document.forms[0].rpselect2.length;i++)
        {
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}		
        }
	

		if(count == 0)
		{
			for(i=0;i<7;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
   count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				if(report!='C')
				{
				c = c.substring(2,c.length);
				}
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
				
		
   
    param =orgcode+";"+org+";"+stat+";";
	
		 count =0;
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
		if(document.forms[0].cmbstatus.value=='A')
		{
		dbfields =dbfields + "Approved By,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		dbfields =dbfields + "Rejected By,";
		}
		else if(document.forms[0].cmbstatus.value=='P')
		{
		dbfields =dbfields + "Pending with,";
		}
		
		if(document.forms[0].cmbstatus.value=='A')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='R')
		{
		opfields =opfields + "usr_fname,";
		}
		else if(document.forms[0].cmbstatus.value=='P')
		{
		opfields =opfields + "usr_fname as createdby,";
		}
					
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	param +=opfields+";";
	param +=dbfields;
	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidStatus.value =stat;	
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
	else if(document.forms[0].selprodtype.selectedIndex == 0)
	{
		ShowAlert('111','Loan Type');
		document.forms[0].selprodtype.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
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
	var repname= document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].selprodtype.value ='S';
	document.forms[0].cmbstatus.value ='';
	//document.forms[0].cmbstatus.options[0].selected =true;
	//document.forms[0].selprodtype.value="";

}

function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/repnav.jsp";
	document.forms[0].submit();
	}
}
	function LoadValues()
{
	var varval= document.forms[0].sellevel.value;
	if(varval=='S/C')
	{
	   document.all.state.style.visibility="visible";
	   document.all.state.style.position="relative";   
	   document.forms[0].rpselect1.selectedIndex =-1;
	   LoadcityValues();
	}
	else 
	{
		document.forms[0].sel_state.value = 0;
		document.all.ifrm.src=path+"action/iframecity.jsp?hidBeanMethod=getData&hidMethod=getStateCityNames&hidBeanId=repappper&hidOption_name="+varval+"&hidval=B";
		document.forms[0].rpselect1.style.width="200";
		document.all.state.style.visibility="hidden";
		document.all.state.style.position="absolute";
	}
}

function LoadcityValues()
{
	var state_name = document.forms[0].sel_state.options[document.forms[0].sel_state.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframecity.jsp?hidBeanMethod=getData&hidMethod=getStateCityNames&hidBeanId=repappper&hidstate_name="+state_name;
	document.forms[0].rpselect1.style.width="200";
}

function doExportExcel() {
	
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var stat =document.forms[0].hidStatus.value;
	var orglevel=document.forms[0].sellevel.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var orgname = document.forms[0].hidOrgName.value;
	var loantype = "";
	
	for(var i=0;i<document.forms[0].selprodtype.options.length;i++)
	{
		if(document.forms[0].selprodtype.options[i].selected)
		{
			loantype = loantype + document.forms[0].selprodtype.options[i].value+"@";
		}
	}
		
	if (param !="") {
		//document.forms[0].action= path+ "action/OnlineStatusReport.xls?hidBeanId=excelfunction&hidBeanGetMethod=doExportOnlineReport&hidStatus="+stat+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&loantype="+loantype;
		document.forms[0].action= path+ "action/OnlineStatusReport.xls?hidBeanId=excelfunction&hidBeanGetMethod=doExportOnlineReport&hidOpFields="+outf+"&hidSelFields="+dbf+"&orglevel="+orglevel+"&loantype="+loantype;
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
		
}

function callonLoad()
{
		//document.forms[0].hidBeanId.value="perrepappstatus";
}

function callCalender(cmdname) {
	showCal(appURL, cmdname);
}