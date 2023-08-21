<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
%>
<html>
<head>
<title>Modification in Sanction Terms</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varbrn_level="<%=Helper.correctNull((String)hshValues.get("branch_level"))%>";
function placeValues()
{
	disableFields(true);
	enableButtons(false,true,true,true,true,false);
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanGetMethod.value="getModsoughtData"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_modificationsought.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanMethod.value="updateModsoughtData"
		document.forms[0].hidBeanGetMethod.value="getModsoughtData"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_modificationsought.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doEdit()
{
		disableFields(false);
		enableButtons(true,true,false,false,false,true);
		document.forms[0].hidAction.value="update";
}

function doNew()
{
		disableFields(false);
		enableButtons(true,true,false,false,false,false);
		document.forms[0].hidAction.value="insert";
}


function doSave()
{
	if(trim(document.forms[0].txt_existing.value)=="")
	{
		alert('Enter Existing Terms');
		document.forms[0].txt_existing.focus();
		return;
	}
	document.forms[0].hidBeanId.value="modsancterms"
	document.forms[0].hidBeanMethod.value="updateModsoughtData"
	document.forms[0].hidBeanGetMethod.value="getModsoughtData"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/commst_modificationsought.jsp";
	document.forms[0].submit();
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

function palceValues(val1,val2)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_existing.value=document.getElementById("hidexist"+val2).value;
	document.forms[0].txt_modification.value=document.getElementById("hidproposed"+val2).value;
	document.forms[0].txt_justification.value=document.getElementById("hidjustification"+val2).value;
	
	if(document.forms[0].btnenable.value=='Y')
	{
		enableButtons(true,false,true,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,true,true,false);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="modificationsought" method="post" class="normal">
<lapstab:applurllinksmst pageid="4"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
  <tr>
    <td class="page_flow"> Corporate &amp; SME -&gt; Modification in Sanction Terms 
      -&gt; Modification Sought</td>
  </tr>
</table>
<lapschoice:MSTApplications/>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
<tr>
<td valign="top"> 
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr>
<td valign="top"> 
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr align="center"> 
      <td colspan="2" class="mantatory"><b>In Other Sanction Terms</b></td>
    </tr>
    <tr> 
      <td width="51%">Existing Terms</td>
      <td width="49%">Modifications Proposed by Branch</td>
    </tr>
    <tr> 
      <td colspan="2"></td>
    </tr>
    <tr> 
      <td width="51%"> 
        <textarea name="txt_existing" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
      <td width="49%"> 
        <textarea name="txt_modification" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
    </tr>
    <tr> 
      <td  colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td  colspan="2">Justification</td>
    </tr>
    <tr> 
      <td  colspan="2"></td>
    </tr>
    <tr> 
      <td  colspan="2"> 
        <textarea name="txt_justification" cols="80" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
    </tr>
   </table>
   </td>
   </tr>
   </table>
   <br>
    <lapschoice:combuttonnew btnnames="New_Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
    <br> 
     <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td width="2%">&nbsp; </td>
            <td width="38%" align="center"><b> Existing Terms</b></td>
            <td width="31%" align="center"><b> Modifications 
              Proposed by Branch</b></td>
            <td width="29%" align="center"><b> Justification</b></td>
          </tr>
          <%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0; i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
	%>
          <tr valign="top" class="datagrid"> 
            <td width="2%"> 
              <input type="radio" name="rdosec" onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=i%>')">
              <input type="hidden" name="hidexist<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(1))%>">
              <input type="hidden" name="hidproposed<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(2))%>">
              <input type="hidden" name="hidjustification<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3))%>">
            </td>
            <td width="38%"><%=Helper.correctNull((String)arrCol.get(1))%></td>
            <td width="31%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
            <td width="29%"><%=Helper.correctNull((String)arrCol.get(3))%></td>
          </tr>
          <%
			}
		}
	%>
        </table>
      </td>
    </tr>
    </table>
    <lapschoice:hiddentag pageid='<%=PageId%>'/> 
    <input type="hidden" name="hidsno" />
  </table>
</form>
</body>
</html>

