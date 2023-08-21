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
	var orglevel =  document.forms[0].sellevel.value;
	var varLoanType=document.forms[0].selprodtype.value;
	if (document.forms[0].selprodtype.value == "S")
	{
		alert("Select Loan Type");
		document.forms[0].selprodtype.focus();
		return false;
	}
	if (param !="")
	{
	document.forms[0].method="post";
 window.open(path+"action/comrunapptrack.jsp?&hidBeanId=comrepapptrack&hidBeanMethod=getData&hidMethod=getRepDetails&txtDate="+dt+"&hidStatus="+stat+"&hidAppno="+appno+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgName="+orgname+"&orglevel="+orglevel+"&hidLoanType="+varLoanType,"track","scrollbars=Yes,toolbars=No,menubar=no,width=750,height=550,top=10,left=10");
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
	var source="/action/comrepapptrack.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
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

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
		document.forms[0].cmbstatus.selectedIndex=0;
	resetno();
}
function winClose()
{
	

	if (ConfirmMsg("100"))
	{
	path = path+"action/comrepappnav.jsp";
	document.forms[0].reset();
    document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action= path;
	document.forms[0].submit();
	}
}
function resetno()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	for(i=0;i<document.forms[0].selappno.length;i++)
	{
		document.forms[0].selappno.options[i].selected =false;
		document.forms[0].selappno.options[i].text = "";
		document.forms[0].selappno.options[i].value = "";
	}
	document.forms[0].selappno.length =0;
}
function selectValues()
{
	resetno();
	document.forms[0].cmbstatus.selectedIndex=0;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
//alert(document.forms[0].sellevel.selectedIndex)
//	alert(bnkname)
//    bnkname = bnkname.substring(0,1); 
	//bnkname =document.forms[0].sellevel.selectedIndex
	//if(bnkname=="1")
	//{
	//	bnkname="C";
//	}
//	else if(bnkname=="2")
//	{
//		bnkname="R";
//	}
//	else if(bnkname=="3")
//	{	
//		bnkname="D";
//	}
//	else if(bnkname=="4")
//	{
//		bnkname="A";
//	}
//	else if(bnkname=="5")
//	{
//		bnkname="B";
//	}


	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;

}

function refreshAppno()
{
	var appno ="";
	count =0;
	var org="";
	var varLoanType=document.forms[0].selprodtype.value;
	if(document.forms[0].rpselect1.selectedIndex != -1
		&& document.forms[0].cmbstatus.selectedIndex != 0 
		&& document.forms[0].selprodtype.value != "S")
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
	var orglevel=document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframecomapptrack.jsp?hidBeanMethod=getData&hidMethod=getAppno&hidBeanId=comrepapptrack&hidStatus="+stat+"&hidOrgCode="+org+"&hidorglevel="+orglevel+"&hidLoanType="+varLoanType;
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
	else if (document.forms[0].selprodtype.value == "S")
	{
		alert("Select Loan Type");
		document.forms[0].selprodtype.focus();
		return false;
	}

}
function resetData()
{
	document.forms[0].rpselect1.selectedIndex=-1;
	document.forms[0].selappno.length=0;
}