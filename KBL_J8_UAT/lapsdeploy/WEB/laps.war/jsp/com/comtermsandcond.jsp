<%/*
	Module Name:	Terms and Conditions
	Page Name:		comtermsandcond.jsp
	Descripion:		
	Created By:		Pradeep Kumar V
*/%>


<%@include file="../share/directives.jsp"%>

<%
ArrayList arrFacilityTerm = (ArrayList)hshValues.get("arrFacilityTerm");
ArrayList arrFacilityTermType = (ArrayList)hshValues.get("arrFacilityTermType");
ArrayList arrFacilityIdVal = (ArrayList)hshValues.get("arrFacilityIdVal");
ArrayList arrFacilityTermStatus = (ArrayList)hshValues.get("arrFacilityTermStatus");
ArrayList arrParentID = (ArrayList)hshValues.get("arrParentID");
ArrayList arrFacilityDoc = (ArrayList)hshValues.get("arrFacilityDoc");
ArrayList arrFacilityTermApp = (ArrayList)hshValues.get("arrFacilityTermApp");
ArrayList arrFacilityTermTypeApp = (ArrayList)hshValues.get("arrFacilityTermTypeApp");
ArrayList arrFacilityIdAppVal = (ArrayList)hshValues.get("arrFacilityIdAppVal");
ArrayList arrFacilityTermStatusapp = (ArrayList)hshValues.get("arrFacilityTermStatusapp");
ArrayList arrParentIDApp = (ArrayList)hshValues.get("arrParentIDApp");

int Appcount=0,Setuptotal=0,Totalcount=0;
if(arrFacilityTermApp!=null)
{
	Appcount =arrFacilityTermApp.size();
}
if(arrFacilityTerm!=null)
{
 Setuptotal=arrFacilityTerm.size();
}
Totalcount=Setuptotal+Appcount;

String strCatName="";
if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP"))
{
	
	strCatName="Corporate";
	
}
else if(strCategoryType.equals("OPS"))
{
	strCatName="Tertiary";
}

ArrayList arrFacilityTermMaster = (ArrayList)hshValues.get("arrFacilityTermMaster"); 

int j=0;

String strApplnHolder = Helper.correctNull((String)request.getParameter("appholder"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strGECL=Helper.correctNull((String)hshValues.get("strgeclavailable"));
//out.println("hshValues====="+hshValues);
//out.println("StrGECLTYPE=====>"+Helper.correctNull((String)hshValues.get("strgecltype")));
%>
<html>
<head>
<title>Terms and Conditions</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var flag= "<%= Helper.correctNull((String)hshValues.get("arrFacilityId")) %>";
var varGECL= "<%= Helper.correctNull((String)hshValues.get("strgeclavailable")) %>";
var varApplHolder = "<%=Helper.correctNull((String)request.getParameter("appholder"))%>";
var varGECLTYPE= "<%= Helper.correctNull((String)hshValues.get("strgecltype")) %>";
	function disableFields(one)
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=="checkbox")
			{	
				document.forms[0].elements[i].disabled=one;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
				document.forms[0].elements[i].disabled=one;		  
			} 
		}
		if(document.forms[0].btnenable.value=="Y")
		{
			document.forms[0].cmdedit.disabled=false;
		}
	}
	function setData(i)
	{
		var len = "<%=Totalcount%>";
		
		if(len>1)
		{
			if(document.forms[0].chk_status[i].checked == true)
			{
				document.forms[0].doc_chkstatus[i].value="Y";
			}
			else
			{
				document.forms[0].doc_chkstatus[i].value="N";
			}
		}
		else 
		{
			if(document.forms[0].chk_status.checked == true)
			{
				document.forms[0].doc_chkstatus.value="Y";
			}
			else
			{
				document.forms[0].doc_chkstatus.value="N";
			}
		}
		
		document.forms[0].hidcomments.value="";
		if(document.forms[0].hidterms.value=="P")
		{
			disableButton(true,true,false,false,false,true);
		}
		
		
	}


	function doNew()
	{
			if(document.forms[0].seltermid.value=="s")
		{
			alert("Select Facility");
			document.forms[0].seltermid.focus();
			return;
		}

			if((document.forms[0].seltermid.value=="0"))
			{
				if(document.forms[0].sel_prepost.value=="s")
				{
					alert("Select Type");
					document.forms[0].sel_prepost.focus();
					return;
				}
			}else
			{
				document.forms[0].sel_prepost.value='s';
				document.forms[0].sel_prepost.disabled=true;
			}
			document.forms[0].hidprepost.value=document.forms[0].sel_prepost.value;
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidtermid.value="";
		document.forms[0].txttrmdesc.value="";
		document.forms[0].txttrmdesc.readOnly=false;
		disableButton(true,true,false,false,true,true);
		document.forms[0].sel_prepost.disabled=true;
		document.forms[0].sel_req.disabled=false;
		document.forms[0].txttrmdesc.focus();
		
	}

	function doEdit()
	{
		
		
		if(document.forms[0].seltermid.value=="s")
		{
			alert("Select Facility");
			document.forms[0].seltermid.focus();
			return;
		}
		else if(document.forms[0].seltermid.value=="0" && document.forms[0].sel_prepost.value=='s')
		{
			alert("Select type");
			document.forms[0].sel_prepost.focus();
			return;
		}
		disableFields(false);
		document.forms[0].hidAction.value="select";
		document.forms[0].txttrmdesc.readOnly=true;


		if(!(document.forms[0].seltermid.value=="0"))
		{
			document.forms[0].sel_prepost.value='s';
			document.forms[0].sel_prepost.disabled=true;
		}
		
		var len = "<%=Totalcount%>";
		if(len != null)
		{
			if(len>1)
			{
				for(var i=0;i<len;i++)
				{
					if(document.forms[0].hidtermtype[i].value=="P")
					{
						if(document.forms[0].hidParentId[i].value=="0")
						{
							document.forms[0].chk_status[i].disabled = false;
							OnCheck(i);
						}else
						{
							document.forms[0].chk_status[i].disabled = true;
							OnCheck(i);
						}
						
					}else
					{
						document.forms[0].chk_status[i].disabled = true;
					}
				}
			}
			else
			{
				if(document.forms[0].chk_status)
				{
					if(document.forms[0].hidtermtype.value=="P")
					{
						if(document.forms[0].hidParentId.value=="0")
						{
							document.forms[0].chk_status.disabled = false;
						}else
						{
							document.forms[0].chk_status.disabled = true;
						}
						
					}else
					{
						document.forms[0].chk_status.disabled = true;
					}
				}
			}
		}else
		{
			if(document.forms[0].chk_status)
			{
				document.forms[0].chk_status.disabled = true;
			}
		}


		disableButton(true,true,false,false,false,true);
		document.forms[0].sel_prepost.disabled=true;
		document.forms[0].sel_req.disabled=true;
	}
//For Enabiling the sub terms & conditions 
	function OnCheck(val)
	{
		var len = "<%=Totalcount%>";
		if(len>1)
		{
			var Parentcode=document.forms[0].doc_code[val].value;
			var Uncheckflag="True";
	
			if(len != null)
			{
				for(var i=0;i<len;i++)
				{
					if(document.forms[0].chk_status[val].checked)
					{
						
						if(document.forms[0].hidtermtype[i].value=="P")
						{
							if(document.forms[0].hidParentId[i].value==Parentcode)
							{
								document.forms[0].chk_status[i].disabled = false;
							}
						}else
						{
							document.forms[0].chk_status[i].disabled = true;
						}
					}else
					{
						if(document.forms[0].hidtermtype[i].value=="P" && document.forms[0].hidParentId[i].value==Parentcode)
						{
							document.forms[0].chk_status[i].disabled = false;
							if(document.forms[0].chk_status[i].checked)
							{
								Uncheckflag="false";
							}else
							{
								if(document.forms[0].hidtermtype[i].value=="P" && document.forms[0].hidParentId[i].value==Parentcode)
								{
									document.forms[0].chk_status[i].disabled = true;
								}
							}
						}
					}
					
				}
				if(Uncheckflag=="false")
				{
					alert("Uncheck all the Sub Terms and Conditions before Unchecking the Main Terms and Conditions");
					document.forms[0].chk_status[val].checked="checked";	
				}
			}
			else
			{
				document.forms[0].chk_status.disabled = true;
			}
		}
	}
//End

	function doSave()
	{
		if(document.forms[0].hidAction.value=="select"){
			for(var i=0;i<document.forms[0].chk_status.length;i++)
			{
				if(document.forms[0].chk_status[i].checked==true)
				{
					if(document.forms[0].sel_DocUpload[i].value=='S'){
						alert("Select Supporting Document Upload required");
						document.forms[0].sel_DocUpload[i].focus();
						return;
					}
					document.forms[0].doc_chkstatus[i].value="Y";
				}
				if(document.forms[0].chk_status[i].checked==false)
				{
					document.forms[0].sel_DocUpload[i].value='S';
				}
			}
		}
		else
		{
			if(trimtxt(document.forms[0].txttrmdesc.value)=="")
			{
				alert("Enter Terms Description");
				document.forms[0].txttrmdesc.focus();
				return false;
			}
			else if(document.forms[0].sel_req.value=="")
			{
				alert("Select Whether supporting document Required");
				document.forms[0].sel_req.focus();
				return;
			}
		}

		document.forms[0].cmdsave.disabled = true;
		document.forms[0].sel_prepost.disabled=false;
		document.forms[0].seltermid.disabled=false;
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanMethod.value="updateComFacilityTermData";
		document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
		document.forms[0].action=appURL+"controllerservlet";
		
		if (flag=="0^0")
		{	
			document.forms[0].general.value="general";
			document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
		}
		else
		{
			document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
		}

		document.forms[0].method="post";
		document.forms[0].submit();
	}
	function putData(i,j,size,varflag)
	{
		if(i==0 && j==0 && size==1)
		{
			if(varflag=="P")
			{
				if(!confirm("Do you want to modify the Master or System terms and conditions?"))
				{
					document.forms[0].rad_edit.checked=false;
					return;
				}
			}
		}
		else
		{
			if(varflag=="P")
			{
				if(!confirm("Do you want to modify the Master or System terms and conditions?"))
				{
					document.forms[0].rad_edit[i].checked=false;
					return;
				}
			}
		}
		if(i==0 && j==0 && size==1)
		{
			document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
			//document.forms[0].doc_code.value=j;
			document.forms[0].hidtermid.value=document.forms[0].doc_code.value;
			document.forms[0].hidterms.value=document.forms[0].hidtermtype.value;
			document.forms[0].hiddoctype.value=document.forms[0].sel_DocUpload.options[document.forms[0].sel_DocUpload.selectedIndex].value;
			document.forms[0].sel_req.value=document.forms[0].sel_DocUpload.options[document.forms[0].sel_DocUpload.selectedIndex].value;
			if(document.forms[0].sel_req.value=="0")
				document.forms[0].sel_req.value="s";
			document.forms[0].hidAction.value="change";
			if(document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].readFlag.value.toUpperCase()=="W")
			{
				disableButton(true,true,false,false,false,true);
				document.forms[0].txttrmdesc.readOnly=false;
				document.forms[0].sel_req.disabled=false;
			}
		}
		else
		{
			document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
			//document.forms[0].doc_code.value=j;
			document.forms[0].hidtermid.value=document.forms[0].doc_code[i].value;
			document.forms[0].hidterms.value=document.forms[0].hidtermtype[i].value;
			document.forms[0].hiddoctype.value=document.forms[0].sel_DocUpload[i].options[document.forms[0].sel_DocUpload[i].selectedIndex].value;
			document.forms[0].sel_req.value=document.forms[0].sel_DocUpload[i].options[document.forms[0].sel_DocUpload[i].selectedIndex].value;
			if(document.forms[0].sel_req.value=="0")
				document.forms[0].sel_req.value="s";
			document.forms[0].hidAction.value="change";
			if(document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].readFlag.value.toUpperCase()=="W")
			{
				disableButton(true,true,false,false,false,true);
				document.forms[0].txttrmdesc.readOnly=false;
				document.forms[0].sel_req.disabled=false;
			}
		}
		document.forms[0].sel_prepost.disabled=true;
		document.forms[0].seltermid.disabled=true;
			
	}

	function loadData()
	{
		if(document.forms[0].seltermid.value=="s")
		{
			alert("Select Facility");
			document.forms[0].seltermid.focus();
			return;
		}
		if((document.forms[0].seltermid.value=="0"))
		{
			if(document.forms[0].sel_prepost.value=="s")
			{
				alert("Select Type");
				document.forms[0].sel_prepost.disabled=false;
				document.forms[0].sel_prepost.focus();
				return;
			}
			
		}else
		{
			document.forms[0].sel_prepost.value='s';
			document.forms[0].sel_prepost.value=true;	
		}
		
		if(document.forms[0].seltermid.value=="0^0")
		{
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].action=appURL+"action/comtermsandcond.jsp?hidBeanGetMethod=getComFacilityTermData&appStatus="+document.forms[0].appstatus.value;
			document.forms[0].general.value="general";
	
			document.forms[0].method="post";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].action=appURL+"action/comtermsandcond.jsp?hidBeanGetMethod=getComFacilityTermData&appStatus="+document.forms[0].appstatus.value;
			document.forms[0].method="post";
			document.forms[0].submit();

		}


	}

	function callDocuments()
	{
		document.forms[0].action=appURL+"action/comfacilitydocuments.jsp?hidComDocType=a";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	
		
	
	function doDelete()
	{
		if(document.forms[0].hidtermid.value=="")
		{
		alert("Select Terms to delete");
		return false;
		}

		var varID=document.forms[0].hidtermid.value;
		if(varGECL=="Y" && (varID=="3203"||varID=="3204"||varID=="3205"||varID=="3206"||varID=="3207"||varID=="1665"||varID=="3208"||varID=="3209"||
				varID=="3210"||varID=="3211"||varID=="1666"||varID=="1671"||varID=="1683"||varID=="1702"||varID=="3212"||varID=="1712"||varID=="3213"||
				varID=="3214"||varID=="3256"||varID=="3257"||varID=="3258"||varID=="3259"||varID=="3260" ||varID=="3261" ||varID=="3262" ))
		{
			alert("You cannot delete.Mandatory Terms for GECL.");
			return;
			
		}
		if(trimtxt(document.forms[0].hidcomments.value)=="")
		{
			var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
			var title1 = "";
			var prop = "scrollbars=no,width=600,height=450,menubar=no";
			var xpos = 20;
			var ypos = 20;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(url,title1,prop);
			
		}
		else
		{
			if(ConfirmMsg(101))
			{
				document.forms[0].sel_prepost.disabled=false;
				document.forms[0].seltermid.disabled=false;
				document.forms[0].hidAction.value="delete";
				document.forms[0].hidBeanId.value="apptermscond";
				document.forms[0].hidBeanMethod.value="updateComFacilityTermData";
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
				if (flag=="0^0")
				{	
					document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
					document.forms[0].general.value="general";
		
				}
				else
				{
					document.forms[0].hidSourceUrl.value="/action/comtermsandcond.jsp";
				}
	
				document.forms[0].method="post";
				document.forms[0].submit();
			}
		}
	}
	function disableButton(b1,b2,b3,b4,b5,b6)
	{
		document.forms[0].cmdnew.disabled = b1;
		document.forms[0].cmdedit.disabled = b2;
		document.forms[0].cmdsave.disabled = b3;
		document.forms[0].cmdcancel.disabled = b4;
		document.forms[0].cmddelete.disabled = b5;
		document.forms[0].cmdclose.disabled = b6;

	}

	function doCancel()
	{
		if(ConfirmMsg(100))
	 	{
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
			if (flag=="0^0")	
			{
				document.forms[0].action=appURL+"action/comtermsandcond.jsp";
				document.forms[0].general.value="general";
			}
			else
				document.forms[0].action=appURL+"action/comtermsandcond.jsp";
			document.forms[0].method="post";
			document.forms[0].submit();
	 	}
	}

	function deleteTerms()
	{
	if(document.forms[0].seltermid.selectedIndex==0)
		{
			alert("Select Facilities");
			return;
		}
		var url;
	var appno = document.forms[0].appno.value;
	var seltermid = document.forms[0].seltermid.value;
	var seltermvalue = document.forms[0].seltermid.options[document.forms[0].seltermid.selectedIndex].text;
	if (flag=="0^0")			
				 url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Corporate&seltermid="+seltermid+"&seltermvalue="+seltermvalue+"&general=general";
			else
				 url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Corporate&seltermid="+seltermid+"&seltermvalue="+seltermvalue;
	
	var title1 = "Terms";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
  	}

	function setSelect()
	{

		disableFields(true);
		document.forms[0].seltermid.disabled=false;
		if(document.forms[0].appstatus.value!="Open/Pending")
		{
		//	disableButton(true,true,true,true,true,false);			

		}
		else
		{
		//	disableButton(false,false,true,true,true,false);	
		}
		if("<%=Helper.correctNull((String)hshValues.get("arrFacilityId"))%>"=="")
		{
			document.forms[0].seltermid.value="s";
		}
		else
		{
		document.forms[0].seltermid.value="<%=(String)hshValues.get("arrFacilityId")%>";
		}
		/*if(document.forms[0].chk_status)
		{
			document.forms[0].cmdedit.disabled=false;
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
		}*/

		if("<%=Helper.correctNull((String)hshValues.get("strPrePost"))%>"==""||"<%=Helper.correctNull((String)hshValues.get("strPrePost"))%>"=="0")
		{
			document.forms[0].sel_prepost.value="s";
			document.forms[0].sel_prepost.disabled=true;
		}
		else
		{
			document.forms[0].sel_prepost.value="<%=Helper.correctNull((String)hshValues.get("strPrePost"))%>";
		}
		if(document.forms[0].seltermid.value=="0")
		{
			document.forms[0].sel_prepost.disabled=false;
		}
		
		<%  if(arrFacilityDoc!=null && arrFacilityDoc.size()>0)
		  {
			  for(int i=0;i<arrFacilityDoc.size();i++)
			  {
				  String doc=Helper.correctNull((String) arrFacilityDoc.get(i));
				  if(arrFacilityDoc.size()==1)
				  {
					  if(doc.equalsIgnoreCase("Y")){%>
				  		document.forms[0].sel_DocUpload.value='Y';
				 	 <%}else if(doc.equalsIgnoreCase("N")){%>
				 		 document.forms[0].sel_DocUpload.value='N';
					  <%}else{%>
				  		document.forms[0].sel_DocUpload.value='S';
						<%}
				  }
				  else
				  {
				 	if(doc.equalsIgnoreCase("Y")){%>
			  		document.forms[0].sel_DocUpload[<%=i%>].value='Y';
			 		 <%}else if(doc.equalsIgnoreCase("N")){%>
			 		 document.forms[0].sel_DocUpload[<%=i%>].value='N';
				 	 <%}else{%>
			  		document.forms[0].sel_DocUpload[<%=i%>].value='S';
					<%}
				 }
				}
		}%>
				
		if(document.forms[0].hidNonPoolFlag.value=="Y")
		{
			disableButton(true,true,true,true,true,false);		
		}
	}

function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propoother.htm";
  var title = "TermsAndConditions";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
function ChkGECL(varID,obj)
{
	if(varGECL=="Y" && obj.checked==false && (varID=="3203"||varID=="3204"||varID=="3205"||varID=="3206"||varID=="3207"||varID=="1665"||varID=="3208"||varID=="3209"||
			varID=="3210"||varID=="3211"||varID=="1666"||varID=="1671"||varID=="1683"||varID=="1702"||varID=="3212"||varID=="1712"||varID=="3213"||varID=="3214"||varID=="3256"
				||varID=="3257"||varID=="3258"||varID=="3259"||varID=="3260" ||varID=="3261" ||varID=="3262" ))
	{
		alert("Mandatory Terms for GECL.");
		obj.checked=true;
		return;
		
	}
}

</script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="setSelect()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frm1" method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="12" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
 
  <%if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("STL") || strCategoryType.equalsIgnoreCase("ADC") || strCategoryType.equalsIgnoreCase("OPS")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="9" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <%}else { %>
  
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="9" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
  </table>
  <%} %>
  
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		 <td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; T&amp;C / Sec. Documents -&gt; Terms and Conditions</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE"))
		{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Terms and Conditions</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Terms and Conditions</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; Terms and Conditions</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("OPS")){ %>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Terms and Conditions</td>
	</tr>
	<%}else{ %>
    <tr> 
	    <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; T&amp;C / Sec. Documents -&gt; Terms and Conditions</td>
    </tr>
    
    <%} %>
  </table>
       <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
<%if(!strCategoryType.equalsIgnoreCase("SRE"))
{
	%>   
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center"> 
                  <td width="15%" class="sub_tab_active">Terms and Conditions</td>
<!--                  <td width="15%" class="sub_tab_inactive"><a href="#" onclick="javascript:callDocuments()">Documents</a></td>-->
                  </tr>
              </table>
        </td>
    </tr>
  </table>
 <%}} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
          <tr> 
            <td valign="top"> 
               <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr>
                              <td width="29%" align="center">Select Facilities</td>
                              <td width="71%"><select name="seltermid" onChange="loadData()">
							  <option value='s'>-- Select --</option>
							  <option value='0'>General</option>
							  <option value='99'>Others</option>
							  <option value='97'>Specific Conditions</option>
							  <option value='98'>Instructions to Branch</option>
							  <lapschoice:comtermscond /> 
							  </select></td>
                            </tr>
                            <tr class="dataGridColor">
                              <td width="29%" align="center">Select Type</td>
                              <td width="71%">
                                <select name="sel_prepost" onChange="loadData()">
                                  <option value='s' selected><-- Select --></option>
                                  <option value='pre'>Pre-disbursal</option>
								  <option value='post'>Post-disbursement</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="29%" align="center">Add Terms and Conditions</td>
                              <td width="71%"><input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100" readonly="readOnly" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                              </td>
                            </tr>
                            <tr id="iddoc"> 
                              <td width="29%">Whether Supporting Document Upload required?</td>
                              <td width="71%"> 
                                <select name="sel_req">
                                 <option value='' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                <td colspan="2">
                  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
				    <tr> 
				      <td> 
				        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				          <tr valign="top">
				            <td width="0">
				               <lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				            </td>
				          </tr>
				          <tr>
				          <td width="0" align="center">
				                <input type="button" name="cmdadd2" value="Deleted Terms" style="font-weight:bold;font-size=10;width:150" onClick="deleteTerms()" class="buttonStyle">
				            </td>
				            </tr>
				        </table>
				      </td>
				    </tr>
				  </table>
                
                </td>
                </tr>
                
                
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
                      <%int parentavail = 0;
						String check1=Helper.correctNull((String)hshValues.get("arrFacilityId"));
							if (check1.equals("0^0"))
							{
						%>
                      <tr> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" colspan="4" width="82%">General Terms and Conditions For all Facility</td>
                        <td width="15%" align="center">Supporting Document Upload required ?</td>
                      </tr>
                      <%
							}
							else if(check1.equals(""))
							{
									
							}

							else
							{
							%>
                      <tr class="dataheader"> 
                        <td align="center" width="5%">&nbsp;</td>
                        <td align="center" colspan="3" width="82%">Terms and Conditions for this Facility</td>
                         <td width="5%" align="center">Print&nbsp;</td>
                        <td width="15%" align="center">Supporting Document Upload required ?</td>
                      </tr>
                      <%
							}
							String prevSno="";
							String currParentId="";
							String termsno = "";
							String docsupport="";
							boolean booflag=true;
							boolean subflag=true;
					  if(arrFacilityTerm!=null && arrFacilityTerm.size()>0)
					  {
					  j=arrFacilityTerm.size();
					  for(int i=0;i<arrFacilityTerm.size();i++)
					  {
						  termsno = Helper.correctNull((String) arrFacilityIdVal.get(i));
							currParentId=Helper.correctNull((String) arrParentID.get(i));
							 docsupport=Helper.correctNull((String) arrFacilityDoc.get(i));
							if(currParentId.equalsIgnoreCase("0") && subflag==true )
							{
								booflag=true;
							}
							if(booflag)
							{
								prevSno=Helper.correctNull((String) arrFacilityIdVal.get(i));
								booflag=false;
							}
					  %>
					  <%if(currParentId.equalsIgnoreCase("0"))
						{
						  subflag=true;
							 %>
                      <tr class="datagrid"> 
                        <td align="center"> 
						  <input type="hidden" name="hiddoccode" value="">
						  <%if(strUserId.equalsIgnoreCase(strApplnHolder))
							  {%>
						  <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i)%>,<%=i%>,<%=arrFacilityTerm.size()%>,'P')">
						  <%}else{ %>
						  <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i)%>,<%=i%>,<%=arrFacilityTerm.size()%>,'P')" disabled="disabled">
						  <%}%>
						</td>
                        <td align="center" colspan="3"> 
                          <div align="justify"><%=arrFacilityTerm.get(i)%></div>
                        </td>
                        <%
                        String strCheck=Helper.correctNull((String)arrFacilityIdVal.get(i));
                       
                        String StrGECLTYPE=Helper.correctNull((String)hshValues.get("strgecltype"));
                       // out.println("StrGECLTYPE====="+StrGECLTYPE);
                       // out.println("strCheck====="+strCheck);
                         boolean bflag=false;
                        if(strGECL.equalsIgnoreCase("Y") && (strCheck.equalsIgnoreCase("3203")||strCheck.equalsIgnoreCase("3204")||
                        		(StrGECLTYPE.equalsIgnoreCase("GECL1")&& strCheck.equalsIgnoreCase("3205")&&(!Helper.correctNull((String) session.getAttribute("strAppType")).equalsIgnoreCase("S")))
                        		||(StrGECLTYPE.equalsIgnoreCase("GECL1")&& strCheck.equalsIgnoreCase("3259")&&(Helper.correctNull((String) session.getAttribute("strAppType")).equalsIgnoreCase("S")))
                        		||strCheck.equalsIgnoreCase("3206")||strCheck.equalsIgnoreCase("3207")||strCheck.equalsIgnoreCase("1665")||strCheck.equalsIgnoreCase("3208")||strCheck.equalsIgnoreCase("3209")||
                    			strCheck.equalsIgnoreCase("3210")||strCheck.equalsIgnoreCase("3211")||strCheck.equalsIgnoreCase("1666")||strCheck.equalsIgnoreCase("1671")
                    			||strCheck.equalsIgnoreCase("1683")||strCheck.equalsIgnoreCase("1702")||strCheck.equalsIgnoreCase("3212")
                    			||strCheck.equalsIgnoreCase("1712")||strCheck.equalsIgnoreCase("3213")||strCheck.equalsIgnoreCase("3214")||(StrGECLTYPE.equalsIgnoreCase("GECL2")&&strCheck.equalsIgnoreCase("3256"))||(StrGECLTYPE.equalsIgnoreCase("GECL3")&& strCheck.equalsIgnoreCase("3257"))||(StrGECLTYPE.equalsIgnoreCase("GECL4")&& strCheck.equalsIgnoreCase("3258"))
                    					||(StrGECLTYPE.equalsIgnoreCase("GECL -1 extension") && strCheck.equalsIgnoreCase("3260"))||
                    					(StrGECLTYPE.equalsIgnoreCase("GECL -2 extension") && strCheck.equalsIgnoreCase("3261"))||
                    					(StrGECLTYPE.equalsIgnoreCase("GECL -3 extension") && strCheck.equalsIgnoreCase("3262"))
                    			))
                        {
                        	bflag=true;
                        	
                        }
                        %>
                         <td align="center"> <input type=hidden name=doc_code value="<%=arrFacilityIdVal.get(i)%>">
                          <input type="checkbox" name="chk_status" style="border-style:none" value="Y" <%if(((Helper.correctNull((String)arrFacilityTermStatus.get(i))).equalsIgnoreCase("Y"))||bflag)
								  {%> checked<%} %> onClick="setData(<%=i%>);OnCheck(<%=i%>);ChkGECL('<%=arrFacilityIdVal.get(i)%>',this);">
                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatus.get(i))%>">
                          <input type="hidden" name="hidsno" style="border-style:none" value="">
                          <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTerm.get(i)%>">
                          <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermType.get(i)%>">
                          <input type="hidden" name="hidParentId" style="border-style:none" value="<%=arrParentID.get(i)%>">
                        </td>
                        <td align="center">
                        <select name="sel_DocUpload" onChange="">
                                  <option value='S' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                        </td>
                        
                      </tr>
                      <%}
					  if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
						{parentavail = parentavail+1;
					  %>
						  <tr> 
	                       
	                        <td>&nbsp;<input type=hidden name=doc_code value="<%=arrFacilityIdVal.get(i)%>"></td>
	                        <td width="3%">
                         <input type="hidden" name="hiddoccode" value="">
						  <%if(strUserId.equalsIgnoreCase(strApplnHolder))
							  {%>
						  <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=i%>,<%=i%>,<%=arrFacilityTerm.size()%>,'P')">
						  <%}else{ %>
						  <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=i%>,<%=i%>,<%=arrFacilityTerm.size()%>,'P')" disabled="disabled">
						  <%}%>
						</td> 
	                          
	                          
	                          <%
                        String strCheck=Helper.correctNull((String)arrFacilityIdVal.get(i));
                        boolean bflag=false;

                        String StrGECLTYPE=Helper.correctNull((String)hshValues.get("strgecltype"));
                        //out.println("StrGECLTYPE=====>"+Helper.correctNull((String)hshValues.get("strgecltype")));
                        if(strGECL.equalsIgnoreCase("Y") && (strCheck.equalsIgnoreCase("3203")||strCheck.equalsIgnoreCase("3204")||
                        		(StrGECLTYPE.equalsIgnoreCase("GECL1")&& strCheck.equalsIgnoreCase("3205")&&(!Helper.correctNull((String) session.getAttribute("strAppType")).equalsIgnoreCase("S")))
                        		||(StrGECLTYPE.equalsIgnoreCase("GECL1")&& strCheck.equalsIgnoreCase("3259")&&(Helper.correctNull((String) session.getAttribute("strAppType")).equalsIgnoreCase("S")))
                        		||strCheck.equalsIgnoreCase("3206")||strCheck.equalsIgnoreCase("3207")||strCheck.equalsIgnoreCase("1665")||strCheck.equalsIgnoreCase("3208")||strCheck.equalsIgnoreCase("3209")||
                    			strCheck.equalsIgnoreCase("3210")||strCheck.equalsIgnoreCase("3211")||strCheck.equalsIgnoreCase("1666")||strCheck.equalsIgnoreCase("1671")
                    			||strCheck.equalsIgnoreCase("1683")||strCheck.equalsIgnoreCase("1702")||strCheck.equalsIgnoreCase("3212")
                    			||strCheck.equalsIgnoreCase("1712")||strCheck.equalsIgnoreCase("3213")||strCheck.equalsIgnoreCase("3214")||(StrGECLTYPE.equalsIgnoreCase("GECL2")&&strCheck.equalsIgnoreCase("3256"))||(StrGECLTYPE.equalsIgnoreCase("GECL3")&& strCheck.equalsIgnoreCase("3257"))||(StrGECLTYPE.equalsIgnoreCase("GECL4")&& strCheck.equalsIgnoreCase("3258"))
                        	||(StrGECLTYPE.equalsIgnoreCase("GECL -1 extension") && strCheck.equalsIgnoreCase("3260"))||
                        	(StrGECLTYPE.equalsIgnoreCase("GECL -2 extension") && strCheck.equalsIgnoreCase("3261"))||
                        	(StrGECLTYPE.equalsIgnoreCase("GECL -3 extension") && strCheck.equalsIgnoreCase("3262"))))
                        {
                        	bflag=true;
                        }
                        %>
	                        <td align="left" colspan="2"> 
	                          <div align="justify"><%=arrFacilityTerm.get(i)%></div>
	                        </td>
	                        <td align="center"><input type="checkbox" name="chk_status" style="border-style:none" value="Y" <%if(((Helper.correctNull((String)arrFacilityTermStatus.get(i))).equalsIgnoreCase("Y"))||bflag)
									  {%> checked<%} %> onClick="setData(<%=i%>);ChkGECL('<%=arrFacilityIdVal.get(i)%>',this);">
	                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatus.get(i))%>">
	                          <input type="hidden" name="hidsno" style="border-style:none" value="">
	                          <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTerm.get(i)%>">
	                          <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermType.get(i)%>">
	                          <input type="hidden" name="hidParentId" style="border-style:none" value="<%=arrParentID.get(i)%>">
	                          </td>
	                        <td align="center">
                        <select name="sel_DocUpload" onChange="">
                                  <option value='S' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                        </td>
                        
	                      </tr>
					  
                      <%}
					  }
					  }
					  else
					  {
					  %>
                      <%
					  }%>
					  
</table>
<br><br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">

				<% check1=Helper.correctNull((String)hshValues.get("arrFacilityId"));
							if (check1.equals("0^0"))
							{
						

					  %>
                      <tr> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" colspan="3" width="82%">General Terms and Conditions For this Specific Borrower</td>
                        <td width="15%" align="center">Supporting Document Upload required ?</td>
                      </tr>
                      <%
							}
							else if(check1.equals(""))
							{
									
							}

							else
							{
							%>
					
                      <tr class="dataheader"> 
                       <td align="center" width="8%">&nbsp;</td>
                        <td align="center" width="63%" colspan="2">Terms and Conditions For this Specific Borrower</td>
                         <td width="5%" align="center">Print&nbsp;</td>
                        <td align="center" width="12%">Supporting Document Upload required ?</td>
                      </tr>
                      <%
							}
							

					  if(arrFacilityTermApp!=null)
					  {
					  
					  for(int i=0;i<arrFacilityTermApp.size();i++)
					  {
						  currParentId=Helper.correctNull((String) arrParentIDApp.get(i));
						  if(currParentId.equalsIgnoreCase("0"))
						  {
					  %>
                      <tr class="datagrid"> 
                      <td align="center" width="5%"> 
                          <input type="hidden" name="hiddoccode" value="">
                          <%if(strUserId.equalsIgnoreCase(strApplnHolder))
                        	  {%>
                          <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i+j)%>,<%=i%>,<%=arrFacilityTermApp.size()%>,'A')">
                          <%}else{ %>
                          <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i+j)%>,<%=i%>,<%=arrFacilityTermApp.size()%>,'A')" disabled="disabled">
                          <%}%>
                        </td>
                        
                        <td align="center" colspan="2"> 
                          <div align="justify"><%=arrFacilityTermApp.get(i)%></div>
                        </td>
                        <td align="center"> 
                          <input type="hidden" name=doc_code value="<%=arrFacilityIdAppVal.get(i)%>">
                          <input type="checkbox" name="chk_status" style="border-style:none" <%
						    if((Helper.correctNull((String)arrFacilityTermStatusapp.get(i))).equalsIgnoreCase("Y"))
								  {%> checked<%} %>>
                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatusapp.get(i))%>">
                          <input type="hidden" name="hidsno" style="border-style:none" value="">
                        <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTermApp.get(i)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermTypeApp.get(i)%>">
                        <input type="hidden" name="hidParentId" style="border-style:none" value="">
                        <input type="hidden" name="hid_docUpload" style="border-style:none" value="<%=arrFacilityDoc.get(i)%>">
                        </td>
                        <td align="center">
                        <select name="sel_DocUpload" onChange="">
                                  <option value='S' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                        </td>
                        
                      </tr>
                      <%}else{ %>
                      
                      <tr class="datagrid"> 
                      <td>&nbsp;</td>
                      <td align="center" width="3%"> 
                          <input type="hidden" name="hiddoccode" value="">
                          <%if(strUserId.equalsIgnoreCase(strApplnHolder))
                        	  {%>
                          <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i+j)%>,<%=i%>,<%=arrFacilityTermApp.size()%>,'A')">
                          <%}else{ %>
                          <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i+j)%>,<%=i%>,<%=arrFacilityTermApp.size()%>,'A')" disabled="disabled">
                          <%}%>
                        </td>
                        
                        <td align="center" colspan="1"> 
                          <div align="justify"><%=arrFacilityTermApp.get(i)%></div>
                        </td>
                        <td align="center"> 
                          <input type="hidden" name=doc_code value="<%=arrFacilityIdAppVal.get(i)%>">
                          <input type="checkbox" name="chk_status" style="border-style:none" <%
						    if((Helper.correctNull((String)arrFacilityTermStatusapp.get(i))).equalsIgnoreCase("Y"))
								  {%> checked<%} %>>
                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatusapp.get(i))%>">
                          <input type="hidden" name="hidsno" style="border-style:none" value="">
                        <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTermApp.get(i)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermTypeApp.get(i)%>">
                        <input type="hidden" name="hidParentId" style="border-style:none" value="">
                        <input type="hidden" name="hid_docUpload" style="border-style:none" value="<%=arrFacilityDoc.get(i)%>">
                        </td>
                        <td align="center">
                        <select name="sel_DocUpload" onChange="">
                                  <option value='S' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                        </td>
                        
                      </tr>
                      
                      <%} %>
                      <%
					  }
					  }
					  else
					  {
					  %>
                      <%
					  }
					  %>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>

<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input TYPE="hidden" name="hidcomments">

  <input type="hidden" name="general">
<input type="hidden" name="rdtermid">
<input type="hidden" name="hidLoanType">
  <input type="hidden" name="cattype" value="<%=strCategoryType%>">
  <input type="hidden" name="hidprepost">
  <input type="hidden" name="hiddoctype">
</form>
</body>

</html>
