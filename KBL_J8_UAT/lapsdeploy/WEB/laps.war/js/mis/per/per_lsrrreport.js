function callonLoad()
{
		document.forms[0].hidBeanId.value="perrepappstatus";
		if(report=='C')
		{
		document.all.state.style.visibility="hidden";
		document.all.state.style.position="absolute";
		}
}
function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}
function enabledept()
{
	var reportType = document.forms[0].report.value;
	if(reportType=="ADHOC")
	{
		document.all.hiddesignaion1.style.visibility="hidden";
		document.all.hiddesignaion1.style.position="absolute";
		
		document.all.hiddept1.style.visibility="hidden";
		document.all.hiddept1.style.position="absolute";
		
		document.all.hiddept.style.visibility="hidden";
		document.all.hiddept.style.position="absolute";
		
		document.all.hiddesignaion.style.visibility="hidden";
		document.all.hiddesignaion.style.position="absolute";
	}
	else{
		var orglevel = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	if(orglevel=="C")
	{
		document.all.hiddept.style.visibility="visible";
		document.all.hiddept.style.position="relative";
		document.all.hiddept1.style.visibility="visible";
		document.all.hiddept1.style.position="relative";
	}else{
		document.all.hiddept.style.visibility="hidden";
		document.all.hiddept.style.position="absolute";
		document.all.hiddept1.style.visibility="hidden";
		document.all.hiddept1.style.position="absolute";
	}
	if(orglevel!="A" && orglevel!="")
	{
		document.all.hiddesignaion.style.visibility="visible";
		document.all.hiddesignaion.style.position="relative";
		document.all.hiddesignaion1.style.visibility="visible";
		document.all.hiddesignaion1.style.position="relative";
	}else{
		document.all.hiddesignaion.style.visibility="hidden";
		document.all.hiddesignaion.style.position="absolute";
		document.all.hiddesignaion1.style.visibility="hidden";
		document.all.hiddesignaion1.style.position="absolute";
	}
	
	var varsancdept="";
	if(orglevel=="R")
	{
		varsancdept="006";
	}
	else if(orglevel=="C")
	{
		if(document.forms[0].seldepartment.value=="S")
		{
			alert("Select Department");
			document.forms[0].seldepartment.focus();
			return;
		}
		if(document.forms[0].seldepartment.value=="001")
			varsancdept="008";
		else if(document.forms[0].seldepartment.value=="002")
			varsancdept="010";
		else if(document.forms[0].seldepartment.value=="009")
			varsancdept="013";
		else if(document.forms[0].seldepartment.value=="010")
			varsancdept="014";
		else
			varsancdept="000";
	}
	else if(orglevel=="CPC")
		varsancdept="011";
	else if(orglevel=="A")
		varsancdept="007";
	else if(orglevel=="D")
		varsancdept="012";
	document.all.ifrmsancauthority.src=appURL+"action/iframedesignauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept;
	
	}

}
function showPeriod()
{
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
	var code =document.forms[0].hidOrgCode.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var fromdt=document.forms[0].txtFromDate.value;
	var todt=document.forms[0].txtToDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var orgname = document.forms[0].hidOrgName.value;
	var vardepartment=document.forms[0].seldepartment.value;
	var vardesignation=document.forms[0].seldesignaion.value;
	var reportType = document.forms[0].report.value;
	
	if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return;
	}
	if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return;
	}
	if(document.forms[0].txtFromDate.value=="")
	{
		ShowAlert('111','From Date');
		document.forms[0].txtFromDate.focus();
		return;
	}
	if(document.forms[0].txtToDate.value=="")
	{
		ShowAlert('111','To Date');
		document.forms[0].txtToDate.focus();
		return;
	}
	if(orglevel=="C"&&reportType!="ADHOC")
	{
		if(document.forms[0].seldepartment.value=="S")
		{
			ShowAlert('111','Department');
			document.forms[0].seldepartment.focus();
			return;
		}
	}
	if(orglevel!="A" && reportType!="ADHOC")
	{
		if(document.forms[0].seldesignaion.value=="S")
		{
			ShowAlert('111','Designation');
			document.forms[0].seldesignaion.focus();
			return;
		}
	}
	if(reportType!="ADHOC")
	{
		window.open(path+"action/per_LsrrReportDisp.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getLsrrReport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&seldepartment="+vardepartment+"&seldesignation="+vardesignation,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=900 , height=600,top=10,left=10");
	}
	else
	{
		window.open(path+"action/custdetrun.jsp?hidBeanId=perrepapptrack&hidBeanGetMethod=getData&hidMethod=getadhocreport&txtFromDate="+fromdt+"&txtToDate="+todt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&reportType="+reportType,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=900 , height=600,top=10,left=10");
	}
	
}
function setParam()
{
	var orgcode="";
	var orgname="";
	var count=0;
	var org="";
	var org_name="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&&	document.forms[0].rpselect1.selectedIndex != -1) 
	{
		var fromdt =document.forms[0].txtFromDate.value;
		var todt =document.forms[0].txtToDate.value;
		
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
	
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOrgName.value =org_name;	
	}
	return;
}
function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].txtFromDate.value="";
	document.forms[0].txtToDate.value="";
	document.forms[0].seldepartment.value="S";
	document.forms[0].seldesignaion.value="S";

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
function callCalender(cmdname) {
		showCal(appURL, cmdname);
}