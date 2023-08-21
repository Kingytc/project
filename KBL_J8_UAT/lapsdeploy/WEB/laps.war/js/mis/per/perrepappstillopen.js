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
function doRunReport()
{
	var param = setParam();
	var code =document.forms[0].hidOrgCode.value;
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var stat =document.forms[0].hidStatus.value;
	var dt = document.forms[0].txtDate.value;
	var sdt = document.forms[0].txtSaveDate.value;
	var  orglevel= document.forms[0].sellevel.value;
	var  loantype= document.forms[0].selloantype.value;
	var  fromamt = document.forms[0].txtfromamt.value;
	var  toamt = document.forms[0].txttoamt.value;
	var orgname = document.forms[0].hidOrgName.value;
	if (param !="")
	{

		window.open(path+"action/perrunappstillopen.jsp?hidBeanId=repappstillopen&hidBeanMethod=getData&hidMethod=getRepDetails&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgCode="+code+"&hidLoanType="+loantype+"&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&orglevel="+orglevel+"&fromamt="+fromamt+"&toamt="+toamt+"&hidOrgName="+orgname,"still","scrollbars=Yes,toolbars=No,menubar=YES ,width=750 , height=550,top=10,left=10");
		//window.open(path+"action/perrunappstillopen.jsp?hidBeanId=repappstillopen&hidBeanMethod=getData&hidMethod=getRepDetails&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgCode="+code+"&hidLoanType=C&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt,"still","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	var source="/action/perrepappstillopen.jsp";
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
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname;
	window.open(purl,title,prop);
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].cmbstatus.options[0].selected =true;
	document.forms[0].txtDate.value="";
	document.forms[0].txtfromamt.value="";
	document.forms[0].txttoamt.value="";
	document.forms[0].selloantype.value="S";
}
function doClose()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].reset();
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/apprepnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

