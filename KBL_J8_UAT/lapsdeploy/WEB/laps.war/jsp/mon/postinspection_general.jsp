<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%	
	String strReviewtype = (String)hshValues.get("postins_type");
	String postins_no = (String)hshValues.get("postins_no");
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var vartype = "<%=strReviewtype%>";
function onLoading()
{
	if( vartype != "")
	{
		document.forms[0].reviewOf.value=vartype;
	}
	else
	{
		document.forms[0].reviewOf.value="S";
	}
	if(document.forms[0].statusflag.value=="P")
	{
		disableCommandButtons("load");
	}
	else
	{
		disableCommandButtons("closed");
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		
		document.forms[0].cmdedit.disabled=false;
	
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose2.disabled=false;	
		
	}
	
	else if(val=="edit")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose2.disabled=true;	 
		 disableFields(false);
		 
	}
	else if(val=="closed")
	{	 
		
		 document.forms[0].cmdedit.disabled=true;
		 
		 document.forms[0].cmdapply.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose2.disabled=false;	 
		 disableFields(true);
		 
	}

}



function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Review of");
		return;
	}	
	//disableFields(false);
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}


function doCancel()
{  
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="";
		document.forms[0].hidBeanId.value="postinspection";
		document.forms[0].hidBeanGetMethod.value="getTypePostInspection";
		document.forms[0].action=appUrl+"action/postinspection_general.jsp";
	    document.forms[0].submit();	
	}	
	
	
}

function doSave()
{
   document.forms[0].hidBeanId.value="postinspection";
   document.forms[0].hidBeanMethod.value="updateTypePostInspection";
   document.forms[0].hidBeanGetMethod.value="getTypePostInspection";
   document.forms[0].action=appUrl+"controllerservlet";
   document.forms[0].hidSourceUrl.value="/action/postinspection_general.jsp";
   document.forms[0].submit();
}

function disableFields(val)
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callLink1(page,bean,method)
{
	if(document.forms[0].cmdapply.disabled!=false)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
	
}


</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						
              <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr> 
                  <td width="20%" align="center" bgcolor="#71694F"> <font size="1" face="MS Sans Serif" color="#000000"><b><font color="#FFFFFF">General 
                    </font></b></font></td>
			
			      <td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('postinspection_facility.jsp','postinspection','getPostInspectionFaclity')" class="blackfont">Facility Enjoyed</a></b></font> </td>
				<td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <%if(strReviewtype.equalsIgnoreCase("R")) {%>
                    <a href="JavaScript:callLink1('postinspection_retail_report.jsp','postinspection','getPostInspectionReport')" class="blackfont">Inspection Report</a>
			  <%}else if(strReviewtype.equalsIgnoreCase("A")) { %>
			  <a href="JavaScript:callLink1('followupInspectionReport.jsp','postinspection','getPostInspectionReport')" class="blackfont">Inspection Report</a>
			  <%}else if(strReviewtype.equalsIgnoreCase("C")) { %>
			  <a href="JavaScript:callLink1('mon_inspectionreport.jsp','postinspection','getPostInspectionReport')" class="blackfont">Inspection Report</a>
			  <%} %>
			</b> </font> </td>
          
          </tr>
        </table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
  <table width="100%" border="1" cellspacing="0" cellpadding="0" >
          <tr> 
           
      <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
        -&gt; Post Inspection -&gt; General</font></i></b></td>
          </tr>
        </table>
 
  <table width="100%" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<laps:PostInspection/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="60%">&nbsp; </td>
    </tr>
  </table>
        
  <table width="100%" border="1" cellspacing="0" cellpadding="4" align="center" bordercolordark="#DEDACF" bordercolorlight="#FFFFFB">
    <tr> 
      <td height="24"><font size="1" face="MS Sans Serif">Review of</font></td>
      <td height="24"> 
        <select name="reviewOf">
	<option value="S" selected>&lt;---Select---&gt;</option>
  	<option value="R">Retail</option>
    <option value="A">Agriculture</option>
  	<option value="C">Corporate/ SME/ Tertiary</option>
	</select>
	</td>
	 </tr>
          <tr> 
      <td>&nbsp; </td>
	  <td>&nbsp; </td>
          </tr>
        </table>
    

<table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
	<tr> 
    	<td> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="2">
        	<tr>
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
				
					<td align="center">	
						<input type="button" name="cmdclose2"
			value="Close"
			class="buttonClose"
			onclick="doClose()">
			</td>
					</tr>
					
			</table>
		</td>
		
	</tr>
</table>

<laps:hiddentag/>
<input type="text" name="hidreviewtype" value="<%=strReviewtype%>"/>

</form>
</body>
</html>

