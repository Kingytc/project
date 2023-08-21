<%@include file="../share/directives.jsp"%>
<%@ page import="java.text.DecimalFormat"%>
<%String stramtin = "";
	if (strCategoryType.equalsIgnoreCase("OPS")) 
	{
		stramtin = "<b>in Lacs</b>";
	}
	  String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	  ArrayList arrSecRow = new ArrayList();
	  ArrayList arrSecCol = new ArrayList();
	  
  	  ArrayList arrAttachRow=new ArrayList();
  	  ArrayList arrAttachCol = new ArrayList();
	  
	  if(hshValues!=null)
	  {
		  arrSecRow = (ArrayList) hshValues.get("arrSecRow");
		  arrAttachRow = (ArrayList)hshValues.get("arrAttachRow");
	  }
	  int intLength = arrSecRow.size();
	  
	  String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
	  String strApplicant = Helper.correctNull((String)hshValues.get("strcmpId"));
	  String strAppId = Helper.correctNull((String)hshValues.get("strappId"));
	  String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
	  DecimalFormat dc=new DecimalFormat();
		dc.setGroupingUsed(false);
		dc.setMaximumFractionDigits(2);
		dc.setMinimumFractionDigits(2);
		String propsecFlag= Helper.correctNull((String)hshValues.get("propsecFlag"));
  //out.println(hshValues);
	%>
<html>
<head>
<title>Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varCategoryType = "<%=strCategoryType%>";
var varApplicant = "<%=strApplicant%>";
var varlength = "<%=intLength%>";
var varFreeze="<%=strFreezeflag%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var propsecFlag="<%=propsecFlag%>";
function Onloading()
{
	disablefields(true);
	document.forms[0].sel_applicants.value=varApplicant;
	if(document.forms[0].btnenable.value=="Y")
	{
		if(varPostSanc=="P")
		{
			var boolflag=false;
			var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
			for(var i=0;i<varPSterms.length;i++)
			{ 
				if(varPSterms[i] == "SEC"||varPSterms[i] == "MODSEC"||varPSterms[i] == "MARGIN")
				{
					boolflag=true;
				}
				
			}
			if(boolflag)
			{
				enablebuttons(false,true,true,true,false);
			}
			else
			{
				enablebuttons(true,true,true,true,false);
			}
		}
	}
	if(varFreeze=="Y")
	{
		//document.forms[0].cmdrelease.disabled=true;
		enablebuttons(true,true,true,true,false);
	}
	if(varlength>0)
	{
	if(varlength==1)
	{
		document.forms[0].cmdattach.disabled=true
	}
	else
	{
for(var i=0;i<document.forms[0].cmdattach.length;i++)
{
	document.forms[0].cmdattach[i].disabled=true
}
	}
	}
	//if(propsecFlag=="Y")
		//document.forms[0].coll_mdtd.disabled=false;
	//else
		//document.forms[0].coll_mdtd.disabled=true;
	
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	document.forms[0].sel_applicants.disabled = false;
}

function enablebuttons(editbool,savebool,canbool,delbool,closebool)
{
	document.forms[0].cmdedit.disabled=editbool;
	document.forms[0].cmdsave.disabled=savebool;
	document.forms[0].cmdcancel.disabled=canbool;
	document.forms[0].cmddelete.disabled=delbool;
	document.forms[0].cmdclose.disabled=closebool;
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	disablefields(false);
	enablebuttons(true,false,false,false,true);	
	document.forms[0].sel_applicants.disabled = true;
	//doAttchbtn();
	if(varlength==1)
	{
		document.all.cmdattach.disabled=false;
	}
	else 
	{
		for(var i=0;i<varlength;i++)
		{
			document.all.cmdattach[i].disabled=false;
		}
	}
	if(varFreeze=="Y")
	{
		if(varlength==1)
		{
			document.all.cmdattach[i].disabled=true;
		}
		else
		{
		for(var i=0;i<varlength;i++)
		{
			document.all.cmdattach[i].disabled=true;
		}
		}
	}
	if(varPostSanc=="P")
	{
		var boolflag=false;
		var varPSterms1 = document.forms[0].hidPostSancParams.value.split("@");
		document.forms[0].cmddelete.disabled=true;
		for(var i=0;i<varPSterms1.length;i++)
		{ 
			if(varPSterms1[i] == "SEC")
			{
				//document.forms[0].cmddelete.disabled=false;
			}
			
		}
		
	}
}

function doAttchbtn()
{
	var varCleanflag="";
	if(varlength==1)
	{
		document.all.cmdview.disabled=false;
		document.all.cmdattach.disabled=false;
	}
	else 
	{
		for(var i=0;i<varlength;i++)
		{
			var varhidtype = document.all.hidType[i].value;
			var varhidsecCategory = document.all.hidsecCategory[i].value;
			if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1))
			{
				varCleanflag = "Y";
				break;
			}
			else if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory!="1"||varhidsecCategory.indexOf("1~")== -1))
			{
				varCleanflag = "N";
			}
		}
		
		for(var i=0;i<varlength;i++)
		{
			var varhidtype = document.all.hidType[i].value;
			var varhidsecCategory = document.all.hidsecCategory[i].value;
			if(varCleanflag == "Y")
			{
				if((varhidtype=="P"||varhidtype.indexOf("P~")!= -1) && (varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1))
				{
					document.all.cmdview[i].disabled=false;
					document.all.cmdattach[i].disabled=false;
				}
				else
				{
					document.all.cmdview[i].disabled=true;
					document.all.cmdattach[i].disabled=true;
				}
			}
			else if(varCleanflag == "N")
			{
				if(varhidsecCategory=="1"||varhidsecCategory.indexOf("1~")!= -1)
				{
					document.all.cmdview[i].disabled=true;
					document.all.cmdattach[i].disabled=true;
				}
				else
				{
					document.all.cmdview[i].disabled=false;
					document.all.cmdattach[i].disabled=false;
				}
			}
			else
			{
				document.all.cmdview[i].disabled=false;
				document.all.cmdattach[i].disabled=false;
			}
		}
	}
}

function doSave()
{
	if(document.forms[0].sel_applicants.value=="0")
	{
		ShowAlert('121', "Applicant"); 	
		document.forms[0].sel_applicants.focus();
		return;	
	}
	disablefields(false);
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hid_categoryType.value = varCategoryType;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="securitymaster"
	document.forms[0].hidBeanMethod.value="updateSecurityValuesDetails";
	document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/securitiesMasterPage.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{		
	if(ConfirmMsg(189))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanMethod.value="updateSecurityValuesDetails";
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/securitiesMasterPage.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function reloadSecurityDetails()
{
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
	document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
	document.forms[0].submit();
}

function showsecurities(val)
{
	if (document.forms[0].hideditflag.value=="Y")
	{
		var varSecID="";
		var varSecType="";
		if(varlength==1)
		{
			varSecType = document.forms[0].hidSecClass.value;
			varSecID = document.forms[0].hidSecID.value;
		}
		else
		{
			varSecType = document.forms[0].hidSecClass[val].value;
			varSecID = document.forms[0].hidSecID[val].value;
			/*for(var i=0;i<varlength;i++)
			{
				if(document.all.cmdview[i].disabled==true)
				{
					varSecID = document.forms[0].hidSecClass[i].value;
				}
			}	*/
		}
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getSecuritiesbySecId";
		document.forms[0].action=appURL+"action/security_detailsdisp.jsp?hidsectype="+varSecType+"&hidsecid="+varSecID+"&pagefrom=appl";
		document.forms[0].submit();
	}
	else
	{
		return false;
	}
}
function callAttach(val) 
{
	var hidVal=val;
	var arrSize='<%=arrSecRow.size()%>';
	var varSecclassification="";
	if(eval(arrSize)=='1')
	{
		var hidFacID=document.forms[0].hidFacID.value;
		var hidSecID=document.forms[0].hidSecID.value;
		var secValue=document.forms[0].hid_securityVal.value;
		var resiValue=document.forms[0].hid_residualVal.value;
		var secType=document.forms[0].sel_exisprop.value;
		var applicantid=document.forms[0].hidBowID.value;
		varSecclassification=document.forms[0].hidSecClassification.value;
	}
	else
	{
		var hidFacID=document.forms[0].hidFacID[val].value;
		var hidSecID=document.forms[0].hidSecID[val].value;
		var secValue=document.forms[0].hid_securityVal[val].value;
		var resiValue=document.forms[0].hid_residualVal[val].value;
		var secType=document.forms[0].sel_exisprop[val].value;
		var applicantid=document.forms[0].hidBowID[val].value;
		varSecclassification=document.forms[0].hidSecClassification[val].value;
	}
	var appno=document.forms[0].hidappno.value;
	var varsecOwnerID=document.forms[0].sel_applicants.value;
	var varQryString = appURL + "action/attachSecurities.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getattachSecurity&secValue="+secValue+"&resiValue="+resiValue+"&hidposition="+hidVal+"&secType="+secType+"&appno="+appno+"&hidFacIDlist="+hidFacID+"&hidSecID="+hidSecID+"&Securitycount="+arrSize+"&applicantid="+applicantid+"&strSecOwnerId="+varsecOwnerID+"&strSecClassifi="+varSecclassification;
	var title = "Securities";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
}

function callprisec()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=primarysec"+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}

function callcollsec()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=collsec"+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function callRelease()
{
var appno=document.forms[0].hidappno.value;
	
	var varQryString = appURL + "action/app_releaseofsecurities.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getReleaseofSecurity&appno="+appno;
	var title = "Securities";
	var prop = "scrollbars=yes,width=850,height=500,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);

}
function calllegalopinion()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=legal"+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function callMDTD()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/app_sec_MDTDdetails.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getMDTDattachedSec&hidAppNo="+hidAppNo+"&hidCommentPage=RetailCollateralsec&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"MDTD",prop);	
}
function callcomments(val)
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+val+"&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
</script>
</head>
<body onload="Onloading()">
<form name="frmcapitalstructure" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="subpageid" value="105" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Promoters -&gt; Security Master </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Promoters -&gt; Security Master</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="1"/>
			<jsp:param name="Freezeflag" value="<%=strFreezeflag%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" cellspacing="0" cellpadding="3" align="center" class="outertable" border="0">
     <tr>
         <td width="35%">&nbsp;</td>
         <td width="10%" align="center">Select Applicant</td>
         <td>
	         <select name="sel_applicants" class="selectwidth" tabindex="1" onchange="reloadSecurityDetails()">
					<%
					String appidval = request.getParameter("appno");
					String strcompanyname = request.getParameter("appname");
					%>							
				    <option value="">&lt;---select---&gt;</option>
				    <option value="<%=strAppId%>"><%=strcompanyname%></option>
				   <lapschoice:compromoter />
		     </select>
		  </td></tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>

		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
			<tr class="dataheader">		
			<td align="center" width="10%">Security ID</td>	                        
					<td align="center" width="25%">Security Type</td>
					<td align="center" width="25%">Classification</td>
					<td align="center" width="25%">Owner Name</td>
					<td align="center" width="15%">Security Value</td>
					<td align="center" width="10%" colspan="2">Action</td>										
			</tr>	
			<%
			if(arrSecRow.size()!=0){
			for(int i=0;i<arrSecRow.size();i++){
				arrSecCol = (ArrayList)arrSecRow.get(i);
				arrAttachCol = (ArrayList)arrAttachRow.get(i);
				%>			
			<tr class="datagrid">		
			<td><input type="hidden" name="hidSecID" value="<%=Helper.correctNull((String)arrSecCol.get(0))%>">
					<%=Helper.correctNull((String)arrSecCol.get(0))%></td>	                        
					<td align="left" width="20%">
					<input type="hidden" name="hidID" value="<%=i%>">
					<input type="hidden" name="hidSecExisting" value="<%=arrSecCol.get(12)%>">
					<b><%=Helper.correctNull((String)arrSecCol.get(6))%></b></td>
					<td align="left" width="13%">
					<input type="hidden" name="hidSecClass" value="<%=Helper.correctNull((String)arrSecCol.get(1))%>">
					<b><%=Helper.correctNull((String)arrSecCol.get(7))%></b></td>

					<td align="left" width="12%"><b><%=Helper.correctNull((String)arrSecCol.get(3))%></b></td>
					<td width="15%" align="right"><b><%=dc.format(Double.parseDouble(Helper.replaceComma(Helper.correctNull((String)arrSecCol.get(4)))))%><input type="hidden" name="hid_securityVal" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.replaceComma(Helper.correctNull((String)arrSecCol.get(4)))))%>"></b></td>
					<input type="hidden" name="hid_residualVal" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.replaceComma(Helper.correctNull((String)arrSecCol.get(5)))))%>">
					<input type="hidden" name="sel_exisprop" value="<%=arrSecCol.get(10) %>">		
					<input type="hidden" name="hidCollFlag" value="<%=Helper.correctNull((String)arrSecCol.get(9))%>">
					
					<td width="7%" align="center"><input type="button" name="cmdview" value="View" class="buttonOthers"
					onClick="showsecurities(<%=i%>)">
					</td>
					<td width="8%" align="center"><input id="attachbtn" type="button" name="cmdattach" value="Attach" class="buttonOthers"
					onClick="callAttach('<%=i%>')"></td>	
					
					<input type="hidden" name="hidFacID" value="<%=Helper.correctNull((String)arrAttachCol.get(0))%>">
					<input type="hidden" name="hidFacSno" value="<%=Helper.correctNull((String)arrAttachCol.get(1))%>">
					<input type="hidden" name="hidFacType" value="<%=Helper.correctNull((String)arrAttachCol.get(2))%>">
					<input type="hidden" name="hidSecMargin" value="<%=Helper.correctNull((String)arrAttachCol.get(3))%>">
					<input type="hidden" name="hidFacNature" value="<%=Helper.correctNull((String)arrAttachCol.get(4))%>">		
					<input type="hidden" name="hidFacLimit" value="<%=Helper.correctNull((String)arrAttachCol.get(5))%>">
					<input type="hidden" name="hidFacOutstand" value="<%=Helper.correctNull((String)arrAttachCol.get(6))%>">
					<input type="hidden" name="hidType" value="<%=Helper.correctNull((String)arrAttachCol.get(7))%>">							
					<input type="hidden" name="sel_sectype"  value="<%=Helper.correctNull((String)arrAttachCol.get(8))%>">
					<input type="hidden" name="hidBowID" value="<%=Helper.correctNull((String)arrAttachCol.get(9))%>">		
					  <input type="hidden" name="hid_parentappno" value="0">
					  <input type="hidden" name="hidsecuritytype" value="<%=Helper.correctNull((String)arrAttachCol.get(10))%>">
					  <input type="hidden" name="hidsecCategory" value="<%=Helper.correctNull((String)arrAttachCol.get(11))%>">
					<input type="hidden" name="hid_parentsno" value="0">	
					<input type="hidden" name="hidSelect" value="<%=Helper.correctNull((String)arrSecCol.get(13))%>">
					<input type="hidden" name="hidSecClassification" value="<%=Helper.correctNull((String)arrSecCol.get(2))%>">
					<input type="hidden" name="hidsharecount" value="<%=Helper.correctNull((String)arrSecCol.get(14))%>">
</tr>	
			<%}}else{ %>
			<tr align="center" class="datagrid" align="center">
			<td colspan="8"><b>No Securities Found</b></td>
			</tr>
			<%} %>	
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hid_categoryType" value="">
<!--<input type="hidden" name="hidsectype" value="<%=sectype%>">-->
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<table width="90%" align="center" border="0" cellpadding="2" cellspacing="0">
	<tr>
	<td>
	<table width="50%" align="center" border="0" cellpadding="2" cellspacing="0">
		<tr>
		
			<!-- <td style="display:none; ">
			<input type="button" name="cmdrelease" class="buttonstyle" 
			value="Release of Securities" onClick="callRelease()">
			</td> -->
			<td align="center">
			<input type="button" name="pri_sec" class="buttonstyle" 
			value="Comments on Primary Security" onClick="callprisec()">
			</td>
			<td align="center">
			<input type="button" name="coll_sec" class="buttonstyle" 
			value="Comments on Collateral Security" onClick="callcollsec()">
			</td>
			
			
			
		</tr>
		<tr>
			<td>
			<input type="button" name="legal_opinion" class="buttonstyle" 
			value="Comments on Legal Opinion / Valuation Report" onClick="calllegalopinion()">
			</td>
			<td>
			<input type="button" name="cmdsection185" class="buttonstyle" 
			value="Comment as to section 185 & 186 of Companies Act" onClick="callcomments('section185')">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" name="cmtcersai" class="buttonstyle" 
				value="Comment on Search made in CERSAI database" onClick="callcomments('cersaicmts')">
			</td>
			<td>
			<input type="button" name="cmts_indep" class="buttonstyle" 
			value="Comments on independent evaluation of the value of the properties" onClick="callcomments('Independenteval')">
			</td>
		</tr>
	</table>
	</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<input type="hidden" name="hidsize" value="<%=arrSecRow.size()%>">
<input type="hidden" name="hid_applicant" value="<%=strApplicant%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
</form>

</body>
</html>
