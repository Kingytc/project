function callonLoad()
{
		document.forms[0].hidBeanId.value="perrepappstatus";
		if(report=='C')
		{
		document.all.state.style.visibility="hidden";
		document.all.state.style.position="absolute";
		}
		enablesectype();
}
function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
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
	
	var orgname = document.forms[0].hidOrgName.value;
	
	if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return;
	}
	if((document.forms[0].sellevel.value == "C") || (document.forms[0].sellevel.value == "R")||(document.forms[0].sellevel.value == "D")
		||(document.forms[0].sellevel.value == "CPC"))
	{
		if(document.forms[0].sel_securitytype.value=="0")
		{
			ShowAlert('111',"Security Type");
			document.forms[0].sel_securitytype.focus();
			return;
		}
	}
	if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return;
	}
	window.open(path+"action/per_securityvaluationreportdisp.jsp?hidBeanId=perrepappstatus&hidBeanMethod=getData&hidMethod=getSecValuatinReport&hidOrgCode="+code+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&sel_securitytype="+document.forms[0].sel_securitytype.value+"&hidsectype="+document.forms[0].hidsectype.value,"stat","scrollbars=Yes,toolbars=No,menubar=yes ,width=1200 , height=600,top=10,left=10");
	
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
function enablesectype()
{
	var bnkLevel=document.forms[0].sellevel.value;
	if(bnkLevel=="C" || bnkLevel=="R" ||bnkLevel=="CPC" || bnkLevel=="D")
	{
		document.all.idsec1.style.display="inline";	
		document.all.idsec2.style.display="inline";	
	}
	else
	{
		document.all.idsec1.style.display="none";	
		document.all.idsec2.style.display="none";
	}

}