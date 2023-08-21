function showPeriod()
{
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
	var stat =document.forms[0].hidStatus.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var txtfromamt=document.forms[0].txtfromamt.value;
	var txttoamt=document.forms[0].txttoamt.value;
	var orgname = document.forms[0].hidOrgName.value;
	var prodtype=document.forms[0].selprodtype.value;
	
	if (document.forms[0].selprodtype.value == "S")
	{
		alert("Select Loan Type");
		document.forms[0].selprodtype.focus();
		return false;
	}
	else if (document.forms[0].txtDate.value == "")
	{
		alert("Enter  Period");
		document.forms[0].txtDate.focus();
		return false;
	}
	else if(txtfromamt=="")
	{
		alert("Enter From Amount");
		document.forms[0].txtfromamt.focus();
		return false;
	}
	else if(txttoamt=="")
	{
		alert("Enter  To Amount");
		document.forms[0].txttoamt.focus();
		return false;
	}
	
	if (param !="")
	{
		window.open(path+"action/comrunappstatus.jsp?hidBeanId=comrepappstatus&hidBeanMethod=getData&hidMethod=getRepDetails&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&txtfromamt="+txtfromamt+"&txttoamt="+txttoamt+"&orglevel="+orglevel+"&hidOrgName="+orgname+"&hidLoanType="+prodtype,"stat","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	var source="/action/comrepappstatus.jsp";
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
	var repname= document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].cmbstatus.options[0].selected =true;
	document.forms[0].txtDate.value="";

}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
    document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/comrepappnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	//bnkname = bnkname.substring(0,1); 
	
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
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

function callonLoad()
{

		if(report=='C')
		{
		document.all.state.style.visibility="hidden";
		document.all.state.style.position="absolute";
		}
}