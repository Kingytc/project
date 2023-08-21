
function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "StateCitySearch";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function openFolderView(varinwardno,varcbsaccno) 
{ 
	var varomnidocurl="";
	varomnidocurl=varipaddress+"?LoanAccNo="+varcbsaccno+"&Application_No="+varinwardno;
	window.open(varomnidocurl,"newWin","location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no,left=20,top=20,width=600,height=600"); 
}

function showCal(path,fname)
{
	var url = path+"action/Calendar.jsp?fname="+fname;
	var title = "Calendar";
	var prop = "scrollbars=no,width=260,height=240";	
	var xpos = (screen.width - 260) / 2;
	var ypos = (screen.height - 250) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop,"pop");
}

function doAuditTrial()
{
	var varkeyid="";
	var hid_keyid="";
	if(document.forms[0].hidPageId.value!="" || document.forms[0].hidPageId.value!=null)
	{
		if(document.forms[0].appno)
		{
			varkeyid=document.forms[0].appno.value;
		}
		else if(document.forms[0].mmrno)
		{
			varkeyid=document.forms[0].mmrno.value;
		}
		else if(document.forms[0].mon_accno)
		{
			varkeyid=document.forms[0].mon_accno.value;
		}
		else if(document.forms[0].hid_comappid)
		{
			varkeyid=document.forms[0].hid_comappid.value;
		}
		else if(document.forms[0].hidDemoId)
		{
			varkeyid=document.forms[0].hidDemoId.value;
		}
		//comapp_oldid
		else if(document.forms[0].comapp_oldid)
		{
			varkeyid=document.forms[0].comapp_oldid.value;
		}
		//comapp_id
		else if(document.forms[0].comapp_id)
		{
			varkeyid=document.forms[0].comapp_id.value;
		}
		
		else if(document.forms[0].inwardno)
		{
			varkeyid=document.forms[0].inwardno.value;
		}
		else if(document.forms[0].prd_code)
		{
			if(document.forms[0].prd_code.value!="New")
				varkeyid=eval(document.forms[0].prd_code.value);
		}
		else if(document.forms[0].hidtlrno)
		{
			varkeyid=document.forms[0].hidtlrno.value;
		}
		else if(document.forms[0].hidmastid)
		{
			varkeyid=document.forms[0].hidmastid.value;
		}
		else if(document.forms[0].hidkeyid)
		{
			varkeyid=document.forms[0].hidkeyid.value;
		}
		else if(document.forms[0].fac_id)
		{
			varkeyid=document.forms[0].fac_id.value;
		}
		else if(document.forms[0].hidsno)
		{
			varkeyid=document.forms[0].hidsno.value;
		}
		else if(document.forms[0].org_code)
		{
			varkeyid=document.forms[0].org_code.value;
		}
		else if(document.forms[0].expid)
		{
			varkeyid=document.forms[0].expid.value;
		}
		else if(document.forms[0].prdCode)
		{
			varkeyid=document.forms[0].prdCode.value;
		}
		if(document.forms[0].hidsno)
		{
			hid_keyid=document.forms[0].hidsno.value;
		}
		if(varkeyid=="")
		{
			alert('Key Id Not Available');
		}
		else
		{
			var hidpageid=document.forms[0].hidPageId.value;
			var app_name="";
			if(document.forms[0].appname)
			{
				app_name=document.forms[0].appname.value;
			}
			else if(document.forms[0].txtperapp_fname)
			{
				app_name=document.forms[0].txtperapp_fname.value;
			}
			else if(document.forms[0].hidapp_name)
			{
				app_name=document.forms[0].hidapp_name.value;
			}
			
			var varQryString = appURL+"action/audittrailreport.jsp?hidBeanGetMethod=getData&hidBeanId=audittrial&KeyId="+varkeyid+"&hidPageId="+hidpageid+"&app_name="+app_name+"&hidradId="+hid_keyid;
			var title = "AuditTrailReport";
			var prop = "scrollbars=yes,width=750,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}
	else
	{
		alert("Page Id not defined");
	}
}

function doAuditTrail()
{
	var varkeyid="";
	if(document.forms[0].hidPageId.value!="" || document.forms[0].hidPageId.value!=null)
	{
		if(document.forms[0].appno)
		{
			varkeyid=document.forms[0].appno.value;
		}
		else if(document.forms[0].hidAgentID)
		{
			varkeyid=document.forms[0].hidAgentID.value;
		}
		else if(document.forms[0].mmrno)
		{
			varkeyid=document.forms[0].mmrno.value;
		}
		else if(document.forms[0].mon_accno)
		{
			varkeyid=document.forms[0].mon_accno.value;
		}
		else if(document.forms[0].hid_comappid)
		{
			varkeyid=document.forms[0].hid_comappid.value;
		}
		else if(document.forms[0].hidDemoId)
		{
			varkeyid=document.forms[0].hidDemoId.value;
		}
		//comapp_oldid
		else if(document.forms[0].comapp_oldid)
		{
			varkeyid=document.forms[0].comapp_oldid.value;
		}
		//comapp_id
		else if(document.forms[0].comapp_id)
		{
			varkeyid=document.forms[0].comapp_id.value;
		}
		
		else if(document.forms[0].inwardno)
		{
			varkeyid=document.forms[0].inwardno.value;
		}
		else if(document.forms[0].prd_code)
		{
			if(document.forms[0].prd_code.value!="New")
				varkeyid=eval(document.forms[0].prd_code.value);
		}
		else if(document.forms[0].hidtlrno)
		{
			varkeyid=document.forms[0].hidtlrno.value;
		}
		else if(document.forms[0].hidmastid)
		{
			varkeyid=document.forms[0].hidmastid.value;
		}
		else if(document.forms[0].hidkeyid)
		{
			varkeyid=document.forms[0].hidkeyid.value;
		}
		else if(document.forms[0].hidsno)
		{
			varkeyid=document.forms[0].hidsno.value;
		}
		else if(document.forms[0].org_code)
		{
			varkeyid=document.forms[0].org_code.value;
		}
		else if(document.forms[0].expid)
		{
			varkeyid=document.forms[0].expid.value;
		}
		else if(document.forms[0].prdCode)
		{
			varkeyid=document.forms[0].prdCode.value;
		}
		if(varkeyid=="")
		{
			alert('Key Id Not Available');
		}
		else
		{
			var hidpageid=document.forms[0].hidPageId.value;
			var app_name="";
			if(document.forms[0].appname)
			{
				app_name=document.forms[0].appname.value;
			}
			else if(document.forms[0].txtperapp_fname)
			{
				app_name=document.forms[0].txtperapp_fname.value;
			}
			else if(document.forms[0].hidapp_name)
			{
				app_name=document.forms[0].hidapp_name.value;
			}
			
			var varQryString = appURL+"action/audittrailreport.jsp?hidBeanGetMethod=getData&hidBeanId=audittrial&KeyId="+varkeyid+"&hidPageId="+hidpageid+"&app_name="+app_name;
			var title = "AuditTrailReport";
			var prop = "scrollbars=yes,width=750,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}
	else
	{
		alert("Page Id not defined");
	}
}

function gotocusprofile(path, page)
{
	if(document.forms[0].hidncgtcflag && document.forms[0].hidbankscheme)
	{
		if(document.forms[0].hidbankscheme.value=="069" && document.forms[0].hidncgtcflag.value=="N")
		{
			alert("Please Fill the KBL Aarogya page");
			return;
		}
	}
	if(document.forms[0].hidCGTMSE)
	{
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage page");
				return;
			}
		}
	}
	if(document.forms[0].hidChecklist)
	{
		if(document.forms[0].hidChecklist.value=="N")
		{
			alert("Please Fill the CheckList Document");
			return;
		}
	}
	//vindhya begin
	if(document.forms[0].hidcheckenwr && document.forms[0].hidenwrbankschemecode)
	{
	if(document.forms[0].hidenwrbankschemecode.value=="074" &&  document.forms[0].hidcheckenwr.value=="N")
	{
		alert("Please Fill the eNWR Details");
		return;
	}}
	
	//vindhya end
	document.forms[0].hidBeanId.value="mastapplicant";		
	document.forms[0].hidBeanGetMethod.value="getDemographics";
	document.forms[0].action=path+"action/"+page+"?pageid=2&corp=C";
	document.forms[0].method="post";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function gotoTab(path, beanid, getmethod, page)
{
	if(document.forms[0].hidncgtcflag && document.forms[0].hidbankscheme)
	{
		if(document.forms[0].hidbankscheme.value=="069" && document.forms[0].hidncgtcflag.value=="N")
		{
			alert("Please Fill the KBL Aarogya page");
			return;
		}
	}
	if(document.forms[0].hidCGTMSE)
	{
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage page");
				return;
			}
		}
	}
	if(document.forms[0].hidChecklist)
	{
		if(document.forms[0].hidChecklist.value=="N")
		{
			alert("Please Fill the CheckList Document");
			return;
		}
	}
	//vindhya begin
	if(document.forms[0].hidcheckenwr && document.forms[0].hidenwrbankschemecode)
	{
	if(document.forms[0].hidenwrbankschemecode.value=="074" &&  document.forms[0].hidcheckenwr.value=="N")
	{
		alert("Please Fill the eNWR Details");
		return;
	}}
	
	//vindhya end
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].hidBeanId.value=beanid;		
			document.forms[0].hidBeanGetMethod.value=getmethod;
			document.forms[0].action=path+"action/"+page;	
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
			return;
		}
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].action=path+"action/"+page;	
		document.forms[0].submit();
	}
}
function gotoCommentsTab(path, beanid, getmethod, page,pageid)
{
	if(document.forms[0].hidncgtcflag && document.forms[0].hidbankscheme)
	{
		if(document.forms[0].hidbankscheme.value=="069" && document.forms[0].hidncgtcflag.value=="N")
		{
			alert("Please Fill the KBL Aarogya page");
			return;
		}
	}
	if(document.forms[0].hidCGTMSE)
	{
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage page");
				return;
			}
		}
	}
	if(document.forms[0].hidChecklist)
	{
		if(document.forms[0].hidChecklist.value=="N")
		{
			alert("Please Fill the CheckList Document");
			return;
		}
	}
	//vindhya begin
	if(document.forms[0].hidcheckenwr && document.forms[0].hidenwrbankschemecode)
	{
	if(document.forms[0].hidenwrbankschemecode.value=="074" &&  document.forms[0].hidcheckenwr.value=="N")
	{
		alert("Please Fill the eNWR Details");
		return;
	}}
	
	//vindhya end
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].hidBeanId.value=beanid;		
			document.forms[0].hidBeanGetMethod.value=getmethod;
			if(document.forms[0].hidPage)
			{
				document.forms[0].hidPage.value=pageid;
			}
			document.forms[0].action=path+"action/"+page;	
			document.forms[0].submit();
		}
		else
		{
			ShowAlert(103);
			return;
		}
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;		
		document.forms[0].hidBeanGetMethod.value=getmethod;
		document.forms[0].hidPage.value=pageid;
		document.forms[0].action=path+"action/"+page;	
		document.forms[0].submit();
	}
}


function gotoTabpage(path,page)
{
	document.forms[0].action=path+"action/"+page;	
	document.forms[0].submit();
}



function callLAPSPDF(strPDFNAME)
{
	var CONTEXT_PARAM="/laps/";
	var PDF_CONTROLLER_PATTERN="pdfaction/";
	var PDF_URL = CONTEXT_PARAM+PDF_CONTROLLER_PATTERN+strPDFNAME;
	var PAGE_PROPERTIES= "scrollbars=yes,width=1015,height=800,resizable=yes,status=no,menubar=no,location=0,toolbar=no";	
	PAGE_PROPERTIES = PAGE_PROPERTIES + ",left=0,top=0";
	window.open(PDF_URL,"",PAGE_PROPERTIES);
}

function callRAMF()
{   
	alert('This is exclusive for BM to finalize rating for the proposal falling under DA of Branch');
	var request1=irburl.toLowerCase();
	if(request1!="")
	{
		var win=window.open(request1+"?UserName="+varuserid+"F"+"&userPass="+varstrIRBpassword);
	}
	else
	{
		alert("Specify IP address in Static data Master");
	}
}
function callRAM()
{
	var request1=irburl.toLowerCase();
	if(request1!="")
	{
		var win=window.open(request1+"?UserName="+varuserid+"&userPass="+varstrIRBpassword);
	}
	else
	{
		alert("Specify IP address in Static data Master");
	}
}

function callFlowtype1(tab,page)
{
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getDataRatio";
	document.forms[0].action = appUrl+"action/comassesmethod1.jsp?pagefrom1="+tab+"&page="+page;
	document.forms[0].submit();
}

function showProgress(div) 
{
		
	try
	{
		if(parent.mainFrame.document.getElementById(div))
		{
			parent.mainFrame.document.getElementById(div).style.display = 'block';
		}
		
		
	}
	catch(e)
	{
		//console.log("error mi"+e);
	}
}
function hideProgress(div) {
	try
	{
 		if(parent.mainFrame.document.getElementById(div)!=null)
		{
			parent.mainFrame.document.getElementById(div).style.display = 'none';
		}
	}
	catch(e)
	{
		//console.log("error 11");
	}

}
// $(function(){
// 	setTimeout(function(){
	
// 	 $('table').each(function(){
//         if($(this).css('display')  == 'block') 
// 	{
// 		$(this).css('display', 'table');
		
// 	}
// 	});
// 	$('tr').each(function(){
		
// 	if($(this).css('display')  ==  'block')
// 	{
// 		$(this).css('display', 'table-row');
		
// 	}
// });
//  $('td').each(function(){
	
// 	if($(this).css('display')  == 'block')
// 	{
// 		$(this).css('display', 'table-cell');
		
// 	}
// });	
// },1000);

// $('select, input').change(function(){
// 	$('table').each(function(){
//         if($(this).css('display')  == 'block') 
// 	{
// 		$(this).css('display', 'table');
		
// 	}
// 	});
// 	$('tr').each(function(){	
// 	if($(this).css('display')  ==  'block')
// 	{
// 		$(this).css('display', 'table-row');
		
// 	}
// });
//  $('td').each(function(){	
// 	if($(this).css('display')  == 'block')
// 	{
// 		$(this).css('display', 'table-cell');	
// 	}
// });
// });
// });
