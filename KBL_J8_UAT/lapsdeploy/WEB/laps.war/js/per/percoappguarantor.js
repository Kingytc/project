function disablefields()
{
	if(document.forms[0].seltype.value=="c")
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
	}
	else
	{
		document.forms[0].sel_incomeeligibility.disabled=true;
		document.forms[0].sel_incomeeligibility.value="1";
	}
}
function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callCoAppIDHelp()
{
	if(document.forms[0].hideditflag.value=="Y")
	{
		if(document.forms[0].seltype.value=="S")
		{
			alert("Select Applicant Type");
			return;
		}
		if(document.forms[0].cmdnew.disabled=true)
		{
			var value1=document.forms[0].hidapplicantid.value;	
			var apptype = document.forms[0].seltype.value;
			var	varQryString = appURL+"action/perapplicantidhelp.jsp?apptype="+apptype+"&appid="+value1;
			var title = "ApplicantIDHelp";
			var prop = "scrollbars=no,width=500,height=500";	
			var xpos = (screen.width - 400) / 2;
			var ypos = (screen.height - 300) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(varQryString,title,prop);
		}
	}
}
function doSave()
{
	var len=document.forms[0].appid.length;
	var id = document.forms[0].hidCoDemoId.value;
	var name= document.forms[0].txtloan_cname.value;
	var rel= document.forms[0].txtrelation.value;
	var bool = false;	
	if(name == "")
	{
		alert("Select CoApplicant/Guarantor Name");
		return;
	}	
	if(rel == "")
	{
		alert("Select Relationship with tha Applicant");
		return;
	}	
	if(len==null && id==document.forms[0].appid.value)
	{
		alert("Selected Customer is already attached for this Application");
		document.forms[0].hidCoDemoId.value="";
		bool = true;
		return;
	}
	else
	{
		for(i=0;i<len;i++)
		{
			if(id==document.forms[0].appid[i].value)
			{
				alert("Selected Customer is already attached for this Application");
				document.forms[0].hidCoDemoId.value="";
				bool = true;
				break;
			}
		}			
	}		
	if(document.forms[0].hidCoDemoId.value!="")
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";		
		document.forms[0].submit();
	}		
}
function callCheck()
{
	if(document.forms[0].txtloan_cname.value!="")
	{
		document.all.ifrcoapp.src = appURL+"action/iframecoappgurantor.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getCoAppGuarantorCheck&hidid="+document.forms[0].hidCoDemoId.value;
	}	
}
function checkadd()
{
	document.forms[0].cmdnew.disabled=true;
	document.forms[0].cmdsave.disabled=false;
}
function doDelete()
{
	if(confirm("Do you want to delete the Applicant ?"))
	{
	//If Co-applicant/guarantor is attached in credit report,cannot delete before deatach  
		if((document.forms[0].applevel.value=="S") && (document.forms[0].hidCreditIDCheck.value=="Y")) 
		{
			alert("Please detach the Joint Applicant/Co-Obligant/Guarantor in credit report");
			return;
		}
		document.forms[0].seltype.disabled=false;
		document.forms[0].sel_incomeeligibility.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="updateCoAppGuarantor";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
	}
}
function doNew()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].seltype.disabled=false;
	document.forms[0].txtrelation.disabled=false;
	document.forms[0].sel_relation_type.disabled=false;
	document.forms[0].seltype.value="S";
	document.forms[0].txtloan_cname.value="";
	document.forms[0].hidAction.value="insert";
	disabledButtons(true,false,false,true,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=true;
		}
	}
	document.forms[0].sel_incomeeligibility.disabled=false;
}
function disabledButtons(a,b,c,d,e,f)
{
	document.forms[0].cmdnew.disabled=a;
	document.forms[0].cmdsave.disabled=b;
	document.forms[0].cmdcancel.disabled=c;
	document.forms[0].cmddelete.disabled=d;
	document.forms[0].cmdclose.disabled=e;
	document.forms[0].cmdcomments.disabled=f;
}
function selApplicant(creditcheck)
{
	var len=document.forms[0].appid.length;
	if(len==null)
	{
		document.forms[0].hidCoDemoId.value=document.forms[0].appid.value;
		document.forms[0].seltype.value=document.forms[0].coapptype.value;
		document.forms[0].txtloan_cname.value=document.forms[0].coappname.value;
		document.forms[0].txtrelation.value=document.forms[0].corelation.value;
		document.forms[0].sel_incomeeligibility.value=document.forms[0].txt_includeincome.value;
		document.forms[0].hidCreditIDCheck.value=creditcheck;		
	}
	else
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].appid[i].checked==true)
			{
				document.forms[0].hidCoDemoId.value=document.forms[0].appid[i].value;
				document.forms[0].seltype.value=document.forms[0].coapptype[i].value;
				document.forms[0].txtloan_cname.value=document.forms[0].coappname[i].value;
				document.forms[0].txtrelation.value=document.forms[0].corelation[i].value;
				document.forms[0].sel_incomeeligibility.value=document.forms[0].txt_includeincome[i].value;
				document.forms[0].hidCreditIDCheck.value=creditcheck;
				break;
			}
		}
	}
	if(document.forms[0].btnenable.value=="Y")
	{
		disabledButtons(false,true,false,false,true,false);
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/percoappguarantor.jsp";
		document.forms[0].submit();
	}
}
function onloading()
{
	if(document.forms[0].txtloan_cname.value!="")
	{
		document.forms[0].cmdcheck.disabled=false;
	}
	else
	{
		document.forms[0].cmdcheck.disabled=true;
	}
	if(document.forms[0].seltype.value=="S")
	{
		document.forms[0].sel_incomeeligibility.disabled=true;
	}
	else
	{
		document.forms[0].sel_incomeeligibility.disabled=false;
	}
	
	if(document.forms[0].btnenable.value=="Y")
	{
		disabledButtons(false,true,true,true,false,true);
	}
	else
	{		
		disabledButtons(true,true,true,true,false,true);
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}
function doComments()
{
	var hidAppNo = document.forms[0].hidAppNo.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=no,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage;
	window.open(url,"Comments",prop);
}
function disableIncludeIncome()
{
	if(document.forms[0].seltype.value=="c")
	{
		if(varjointappincome=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}
	else if(document.forms[0].seltype.value=="g")
	{
		if(varobligantincome=="1" || varguarantorincome=="1")
		{
			document.forms[0].sel_incomeeligibility.disabled=true;
			document.forms[0].sel_incomeeligibility.value="1";
		}
		else
		{
			document.forms[0].sel_incomeeligibility.disabled=false;
		}
	}
}
function doFreeze()
{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanMethod.value="getFreezeData";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/percoappguarantor.jsp";	
		document.forms[0].submit();
}
function doMaxCheck()
{
	if((varInccount>=varEligInccount) && (varPrdType=="pM"))
	{
		alert("You cannot add any applicant's income for assessment since you have reached the limit");
		document.forms[0].sel_incomeeligibility.value="1";
	}
}