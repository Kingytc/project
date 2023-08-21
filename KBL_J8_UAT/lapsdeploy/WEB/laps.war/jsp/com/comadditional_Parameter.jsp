<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />
<%

String flag="false";
if(hshValues.get("flag")!=null)
{

	flag="true";
	
}
%>
<html>
<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";



function placevalues()
{
	    disableFields(true);
		enableButtons(false,true,true,false,false,true);
	
	
	var a="<%=Helper.correctNull((String)hshValues.get("sel_occupationlist"))%>";
	
	if(a!="")
	{
		document.forms[0].sel_occupationlist.value=a;
	}
	else
	{
		document.forms[0].sel_occupationlist.value="0";
	}
	var b="<%=Helper.correctNull((String)hshValues.get("sel_minor"))%>";
	
	if(b!="")
	{
		document.forms[0].sel_minor.value=b;
	}
	else
	{
		document.forms[0].sel_minor.value="0";
	}
	var c="<%=Helper.correctNull((String)hshValues.get("sel_trade"))%>";
	
	if(c!="")
	{
		document.forms[0].sel_trade.value=c;
	}
	else
	{
		document.forms[0].sel_trade.value="0";
	}
	var d="<%=Helper.correctNull((String)hshValues.get("sel_inland"))%>";
	
	if(d!="")
	{
		document.forms[0].sel_inland.value=d;
	}
	else
	{
		document.forms[0].sel_inland.value="0";
	}
	var e="<%=Helper.correctNull((String)hshValues.get("sel_constitution"))%>";
	
	if(e!="")
	{
		document.forms[0].sel_constitution.value=e;
	}
	else
	{
		document.forms[0].sel_constitution.value="0";
	}
	

}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
enableButtons(true,false,false,false,true,true)
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	//document.forms[0].cmdaudit.disabled=bool6;
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comadditional_Parameter.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	this.close();
	
}
function doSave()
{
	
		if("<%=flag%>"=="false")
		{
		document.forms[0].hidAction.value="insert";
		}else
		{
		document.forms[0].hidAction.value="update";
		}
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comadditional_Parameter.jsp";
		document.forms[0].submit();
		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="additionalParameter";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comadditional_Parameter.jsp";
		document.forms[0].submit();
	 }
}
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>


<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000" onload="placevalues()">
<form  method = post>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td valign="bottom" align="center" height="49"><font face="MS Sans Serif" size="2"><b>Customer Profile<br>
      <br>
      </b></font></td>
  </tr>
  
  </table>
<table width="100%" border="1" cellspacing="0" cellpadding="5" height="10%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">

 
  <tr> 
    <td width="18%">occupation</td>
    <td width="37%"> 
      <select name="sel_occupationlist" >
      <%String apptype="13"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
    <td width="17%">constitution</td>
    <td width="28%">
      <select name="sel_constitution">
       <%apptype="14"; %>
      <laps:StaticDataNewTag apptype='<%=apptype%>'/>
      </select>
    </td>
  </tr>
  <tr> 
    <td width="18%">Guardian Relationship<br>
    </td>
    <td width="37%">
      <input type="text" name="txt_guardian" disabled value="<%=Helper.correctNull((String)hshValues.get("txt_guardian"))%>">
    </td>
    <td width="17%">relation name and address</td>
    <td width="28%"><textarea name="txt_relation"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" disabled><%=Helper.correctNull((String)hshValues.get("txt_relation"))%></textarea></td>
  </tr>
  <tr> 
    <td width="18%">Whether Minor </td>
    <td width="37%">
      <select name="sel_minor">
        <option value="0" selected>select</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">Permanent Address Country</td>
    <td width="37%">
      <input type="text" name="txt_permanent" value="<%=Helper.correctNull((String)hshValues.get("txt_permanent"))%>">
    </td>
    <td width="17%">Employer Address Country</td>
    <td width="28%">
      <input type="text" name="txt_employer" value="<%=Helper.correctNull((String)hshValues.get("txt_employer"))%>">
    </td>
  </tr>
  <tr> 
    <td width="18%">date of becoming non-resident</td>
    <td width="37%">
      <input type="text" name="txt_nonresident" value="<%=Helper.correctNull((String)hshValues.get("txt_nonresident"))%>">
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">trade finance</td>
    <td width="37%">
      <select name="sel_trade">
        <option value="0" selected>select</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">if trade finance yes inland trade allowed</td>
    <td width="37%">
      <select name="sel_inland">
        <option value="0" selected>select</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">introducer title </td>
    <td width="37%">
      <input type="text" name="txt_ititle" value="<%=Helper.correctNull((String)hshValues.get("txt_ititle"))%>">
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="18%">introducer name</td>
    <td width="37%">
      <input type="text" name="txt_iname" value="<%=Helper.correctNull((String)hshValues.get("txt_iname"))%>">
    </td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="28%">&nbsp;</td>
  </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    
   
           
    <tr> 
      <td colspan="3"> 
        <%
		String strappno = request.getParameter("appno");
		//out.println(strappno);
		%>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=''/> </td>
    </tr>
   </table>
   <input type="hidden" name="hidAction">
   <input type="hidden" name="appno" value="<%=strappno%>">
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanGetMethod"  >
  <input type="hidden" name="hidSourceUrl" >
    <input type="hidden" name="hidAppType" value="C">
   </form>
</body>

</html>
