function callAdd()
{
	document.forms[0].txtloan_cname.value="";
	document.forms[0].prinfullname.selectedIndex=0;
	document.forms[0].printype.selectedIndex=0;
	document.forms[0].hidCoDemoId.value="";
	document.forms[0].hidAction.value="add";
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
		
}
function callCoAppIDHelp()
{
	if(document.forms[0].printype.value=="S")
	{
		alert("Select Applicant Type");
		return;
	}
	if(document.forms[0].prinfullname.value=="new" && document.forms[0].readFlag.value.toUpperCase()=="W" && document.forms[0].strappstatus.value=='op')
	{
		var value1=document.forms[0].hidapplicantid.value;	
		var apptype = document.forms[0].printype.value;
		var	varQryString = appURL+"action/ops_demographichelp.jsp?appid="+value1;
		var title = "ApplicantIDHelp";
		var prop = "scrollbars=no,width=500,height=430";	
		var xpos = (screen.width - 450) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
	}
}

function doSave()
{
	var id = document.forms[0].hidCoDemoId.value;
	var name= document.forms[0].txtloan_cname.value;
	if(trimtxt(document.forms[0].txtloan_cname.value)=="")
	{
		alert("Select Name of the person");
		return;
	}
	
	if(document.forms[0].hidCoDemoId.value!="")
	{
		
	    document.forms[0].hidVal.value="add";
	    var subIndex=0;
	    var str_type="";
		for(var i=0;i<document.forms[0].printype.options.length;i++)
		{
			if(i < 5)
					subIndex=1;
			else
				subIndex=2;
			if(document.forms[0].printype.options[i].selected)
			{				
				str_type=str_type+document.forms[0].printype.options[i].value.substring(0,subIndex)+"@";
			}		

		}
		document.forms[0].hidprintype.value=str_type;
	    
		if(document.forms[0].hidprintype.value=="")
		{
			alert("Select Proprietor / Partner / Director Type");
			return;
		}
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordFlag;	
		document.forms[0].hidBeanGetMethod.value="updateOpsdemograph";
		document.forms[0].hidBeanId.value="ssidemographics";
		document.forms[0].action=appURL+"action/ops_demographics.jsp";	
		document.forms[0].submit();
	}		
}

function displayData()
{		
	
	if(document.forms[0].prinfullname.selectedIndex>1)
	{
	    document.forms[0].hidVal.value = "select";
		document.forms[0].hidBeanId.value="ssidemographics";		
		document.forms[0].hidBeanGetMethod.value="getOpsdemograph";
		document.forms[0].hidSourceUrl.value="/action/ops_demographics.jsp";
    	document.forms[0].submit();
	}
	else
	{
		makeNull();
	}
}
function makeNull()
{
	document.forms[0].txtloan_cname.value="";
	document.forms[0].printype.value="";
	document.forms[0].txt_din.value="";
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmddelete.disabled=true;
	}
}
function doDelete()
{
var val1=document.forms[0].prinfullname.value;
if(val1=="")
{
	alert('Select Proprietor / Partner / Director ');
	document.forms[0].prinfullname.focus();
	return;
}
	if(ConfirmMsg(101))
	 {
    //If Co-applicant/guarantor is attached in credit report,cannot delete before deatach     
		if((document.forms[0].applevel.value=="S") && (document.forms[0].hidCreditIDCheck.value=="Y")) 
		{
			alert("Please detach the Co-applicant/Guarantor in credit report");
			return;
		}		
		document.forms[0].hidVal.value="delete"
		document.forms[0].hidBeanGetMethod.value="updateOpsdemograph";
		document.forms[0].hidBeanId.value="ssidemographics";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].action=appURL+"action/ops_demographics.jsp";	
		document.forms[0].submit();
	 }		
}
function doCancel()
{
if(ConfirmMsg(102))
		{
    document.forms[0].hidVal.value="cancel";
	document.forms[0].hidBeanGetMethod.value="getOpsdemograph";
	document.forms[0].hidBeanId.value="ssidemographics";
	document.forms[0].action=appURL+"action/ops_demographics.jsp";
	document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{	
	if (document.forms[0].prinfullname.value !="0" && document.forms[0].prinfullname.value !="new")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page+"?hidDemoId="+prom_id;
		document.forms[0].submit();
	}
	else
	{
		alert("Select name ");
	}
}
