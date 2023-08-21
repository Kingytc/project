<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }

 ArrayList vec = null;
 int vecsize=0;

 if (hshValues != null)
 {
   vec = (ArrayList)hshValues.get("vecVal");
 }
if(vec!=null)
{
	vecsize =vec.size();
	
}
%>
<html>
<head>
<title>Raw Materials / Input</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				if (document.forms[0].elements[i].name=="material")
				{
					document.forms[0].elements[i].readOnly=true;		
				}
				else
				{
					document.forms[0].elements[i].readOnly=val;		  
				}	  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);

}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSupply";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawsupply.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
		var flag=validate();
		
		if(flag )
		{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSupply";
		document.forms[0].hidBeanGetMethod.value="getSupplyData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawsupply.jsp";
		document.forms[0].submit();
		}
		else
		{
			alert("Enter values in Imported/Indigenous Supplier Column");
		}
		
		
}
function  validate()
{ 
	var flag;
	for (m=0;m<8;m++)
	{
	if(document.forms[0].supplier[m].value != "" ) 
				return true;
		else
				flag= false;
	
	}

return flag;

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getSupplyData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawsupply.jsp";
		document.forms[0].submit();
	 }
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}


 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdsave.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	    	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
		  document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
	
	
  }

var strvalue="corp_prodrawmat_import.htm";
function doHelp()     
{
  var hlpvar = appURL+"phlp/corp_prodrawmat_import.htm";
  var title = "SupplyOfRawmaterials";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal"> <table width="100%"border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td> <jsp:include page="../share/applurllinkscom.jsp" flush="true"> <jsp:param name="pageid" value="4" /> 
<jsp:param name="cattype" value="<%=strCategoryType%>" /> <jsp:param name="ssitype" value="<%=strSSIType%>" /> 
</jsp:include> </td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; 
Products -&gt; Raw Materials -&gt; Supp. of Raw Materials - Imported</td></tr> </table><span style="display:none"><lapschoice:borrowertype /></span> 
<lapschoice:application/> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td> <table border="0" cellspacing="2" cellpadding="3" class="outertable" WIDTH="70%"> 
<tr align="center"> <td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comactivities.jsp','compro','getActivity')">Activities</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comproduction.jsp','combanking','getProductData')">About 
Prod.</a></b></td><td width="10%" class="sub_tab_active"><b>Raw Materials</b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')">Manf.Process</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')">Govt.Policy</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('comtransport.jsp','combanking','getTransData')">Transportation</a></b></td><td width="10%" class="sub_tab_inactive"><b><a href="#" onclick="javascript:callLink('commarketing.jsp','combanking','getSegmentData')">Marketing</a></b></td></tr> 
</table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
<tr> <td colspan="2"> <table border="0" cellspacing="2" cellpadding="3" class="outertable" WIDTH="80%"> 
<tr align="center"> <td width="10%" class="sub_tab_inactive" NOWRAP><b><a href="#" onclick="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')">Raw 
Materials</a></b></td><td width="10%" class="sub_tab_inactive" NOWRAP><b><a href="#" onclick="javascript:callLink('comrawmaterialsmajor.jsp','compro','getRawMajorData')">Other 
Inputs</a></b></td><td width="15%" class="sub_tab_active" NOWRAP><b>Supp.of Raw 
Materials- Imported</b></td><td width="15%" class="sub_tab_inactive" NOWRAP><b><a href="#" onclick="javascript:callLink('comrawsupplyindi.jsp','compro','getSupplyIndiData')" >Supp.of 
Raw Materials - Indigenous</a></b></td><td width="10%" class="sub_tab_inactive" NOWRAP><b><a href="#" onclick="javascript:callLink('comotherdetails.jsp','combanking','getOtherData')" >Other 
Details</a></b></td><td width="10%" class="sub_tab_inactive" NOWRAP><b><a href="#" onclick="javascript:callLink('comotherdetailssubst.jsp','compro','getOtherSubstData')" >Substitutes</a></b></td></tr> 
</table></td></tr> <tr> <td colspan="2"> <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable"> 
<tr class="dataheader"> <td width="4%">S.No</td><td align="center" width="15%">Materials 
Supplied</td><td align="center" colspan="2">Details of Suppliers of Major raw 
materials and other inputs</td><td width="16%" align="center">Credit period extended</td></tr> 
<tr class="dataheader"> <td width="4%" align="center">&nbsp;</td><td width="15%" align="center"><b>Imported</b></td><td width="37%" align="center"><b>Name 
of the Supplier</b></td><td width="28%" align="center"><b>Location</b></td><td width="16%" align="center">&nbsp;</td></tr> 
<%
					ArrayList g1=null;
					
					 for (int l=0;l<vecsize;l++)
					 {
						
							
							int colSize=0;
						 
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)vec.get(l);

							if(g1!=null)
							{
							   colSize = g1.size();

							   
       						}
						 }
						
					
					
					
						 if(colSize>0)	
						  {
						
			 %> <tr> <td width="4%" align="center"><%=l+1%></td><td align="center" width="15%"> 
<input type="text" name="material" size="15" value="<%=Helper.correctNull((String)g1.get(0))%>" maxlength="99" onKeyPress="notAllowSplChar1(this)"> 
<input type="hidden" name="material" > </td><td align="center" width="37%"> <textarea name="supplier" cols="35" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)" ><%=Helper.correctNull((String)g1.get(2))%></textarea> 
<input type="hidden" name="supplier" > </td><td align="center" width="28%"> <textarea name="location" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String)g1.get(3))%></textarea> 
<input type="hidden" name="location" > </td><td width="16%" align="center"> <textarea name="credit" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"><%=Helper.correctNull((String)g1.get(5))%></textarea> 
<input type="hidden" name="credit" > <input type="hidden" name="type" size="15" value="imported" > 
<input type="hidden" name="type" size="15" value="imported" > <input type="hidden" name="sno" size="15" value="<%=Helper.correctNull((String)g1.get(6))%>" > 
<input type="hidden" name="sno" > </td></tr> <%
						
						}
						else
						 {
					%> <tr> <td width="4%" align="center"><%=l+1%></td><td align="center" width="15%"> 
<input type="text" name="material" size="15" maxlength="99" onKeyPress="notAllowSplChar1(this)"> 
</td><td align="center" width="37%"> <textarea name="supplier" cols="35" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> 
</td><td align="center" bgcolor="#F9F7F2" width="28%"> <textarea name="location" cols="25" ></textarea> 
</td><td width="16%" align="center"> <textarea name="credit" cols="25" onKeyPress="textlimit(this,999)" onKeyUp="textlimit(this,999)"></textarea> 
<input type="hidden" name="type" size="15" value="imported"> <input type="hidden" name="sno" value=""> 
</td></tr> <%}
				}%> </table></td></tr> </table></td></tr> </table></td></tr> 
</table></td></tr> </table></td></tr> </table><br> <lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> </form>
</body>
</html>