<%@include file="../share/directives.jsp"%>
<%
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String strApploantype = Helper.correctNull((String) request.getParameter("apploantype"));
String strApplevel=Helper.correctNull((String)request.getParameter("applevel"));
String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
if(strValuesin.equals("L"))
{
	strValuesin=" in Lacs";
}
else
{
	strValuesin="";
}

//Added by Zahoorunnisa.S for button functionality
 	String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
//end	
		
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
String strProposal=Helper.correctNull((String)request.getParameter("hidproposal"));%>
<html>
<head>
<title>Facility For Recommendation</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function onloading()
{	
	disableFields(true);
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,false);	
		}
			
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		
		enableButtons(true,true,true,true,false);
			
    }else{
		
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,false);
		}
	}

  
	//End
}

function enableButtons(valedit,valapply,valcancel,valdel,valclose)
{
	
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
//end
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,false,true);
}

function doSave()
{
	if(trim(document.forms[0].txt_brrecomd.value)== "")
	{
		ShowAlert(112,'Branch Recommendations ');
		return false;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="inwardRegister";		
	document.forms[0].hidSourceUrl.value="/action/recmdforsanction.jsp";
	document.forms[0].hidBeanMethod.value="updatebrrecmd";
	document.forms[0].hidBeanGetMethod.value="getbrrecmd";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updatebrrecmd";
		document.forms[0].hidBeanGetMethod.value="getbrrecmd";	
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidSourceUrl.value="action/recmdforsanction.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="inwardRegister";
		document.forms[0].hidBeanGetMethod.value="getbrrecmd";
		document.forms[0].action=appURL+"action/recmdforsanction.jsp";
		document.forms[0].submit();
	}
}   
 function disableCommandButtons(cmdedit,cmdsave,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdsave.disabled=cmdsave;
	  document.forms[0].cmddelete.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doPrint()
{
	var ackno = document.forms[0].inwardno.value;
	var varvaluesin ="<%=strValuesin%>";
	var purl ="<%=ApplicationParams.getAppUrl()%>action/recmdbybrnewapplnprint.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getRecommendationPrint&inwardno="+ackno+"&valuesin="+varvaluesin;
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'RECOMMENDATIONBYBRANCHFORNEWAPPLN',prop);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd" class="normal">
 <%if (strSaral.equalsIgnoreCase("saral")) {%>
<lapschoice:saralreportTag tabid="5" sector='<%=strSector%>' applied='<%=strappliedfor%>' proposal='<%=strProposal%>'/> <lapschoice:inward />
<%} else if(strApploantype.equalsIgnoreCase("c")){%>

<lapstab:ComReportTab tabid="4" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>' applied='<%=strappliedfor%>'/>
<span style="display:none"><lapschoice:borrowertype /></span>
 <lapschoice:application /> 
<%} else if(strApploantype.equalsIgnoreCase("T")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td valign="top"> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="10" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr><td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Reports -&gt; Recommendation by Branch</td></tr>
  </table>

  <span style="display:none"><lapschoice:borrowertype /></span>
	<lapschoice:application /> 
	<lapstab:TerReportTab tabid="3" applevel='<%=strApplevel%>' applied='<%=strappliedfor%>'/>
<%} else if(strApploantype.equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Recommendation by Branch</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="12" />
		</jsp:include></td>
	</tr>
</table>
<%}else if((strCategoryType.equals("ADC") ||strCategoryType.equals("STL")||strCategoryType.equals("SRE"))  &&(strApplevel.equals("S")) ){%>
<table border="0" width="100%" class="outertable">
<tr>
 <td valign="top"> 
<jsp:include page="../share/applurllinkscom.jsp" flush="true">         
<jsp:param name="pageid" value="16" />
<jsp:param name="cattype" value="<%=strCategoryType%>" />
<jsp:param name="ssitype" value="<%=strSSIType%>" />
</jsp:include>
 </td>
</tr>  <tr>
         <%if(strCategoryType.equals("ADC")) {%>
		 <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Adhoc Limit -&gt; Saral -&gt; Recommendation
		 </td>
		 <%}else if(strCategoryType.equals("STL")) {%>
	       <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Saral -&gt;Recommendation
		 </td>
		  <%} else if(strCategoryType.equals("SRE")) {%>
	       <td class=page_flow>Home -&gt;Corporate &amp; SME -&gt; Short Review Extension -&gt; Saral -&gt; Recommendation
		 </td>
		 <%}%>      
     </tr>
 <tr>
<td>
<lapschoice:borrowertype /><lapschoice:application/>
<lapschoice:saralappinwardtag tabid="5" sector='<%=strCategoryType%>'	applied='<%=strappliedfor%>'  />
</td></tr>
  </table>
<%} %>
<table width="60%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr align="center">
		<td>
			Branch Recommendations
		</td>
		<td>
			<textarea cols="50" rows="10" name="txt_brrecomd" onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"><%=Helper.correctNull((String)hshValues.get("brrecomdations"))%></textarea>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
