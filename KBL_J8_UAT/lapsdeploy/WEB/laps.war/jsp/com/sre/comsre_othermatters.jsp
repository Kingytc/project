<%@include file="../../share/CKEditor.jsp"%>
<%@include file="../../share/directives.jsp"%>

<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
String Valuesin=Helper.correctNull((String) request.getParameter("valuesin"));
%>
<html>
<head>
<title>Short Review Extension</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script><!--

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
		document.forms[0].hidSourceUrl.value="/action/comsre_othermatters.jsp";
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
		document.forms[0].hidSourceUrl.value="/action/comsre_othermatters.jsp";
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
	/*if(trim(document.forms[0].txt_existing.value)=="S")
	{
		alert('Enter Existing Terms');
		document.forms[0].txt_existing.focus();
		return;
	}*/
	
	
	if(trim(document.forms[0].txt_modification.value)=="")
	{
		alert('Please Enter Details in Modifications Proposed by Branch');
		document.forms[0].txt_modification.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="modsancterms"
	document.forms[0].hidBeanMethod.value="updateModsoughtData"
	document.forms[0].hidBeanGetMethod.value="getModsoughtData"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/comsre_othermatters.jsp";
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
function callLink(page,bean,method)
{	
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidCategoryType.value="SRE";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}
--></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="otrmatters" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" table="outertable">
    <tr> 
      <td valign="top" > 
        <jsp:include page="../../share/applurllinkscom.jsp" flush="true">         
        <jsp:param name="pageid" value="8" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <br>
  <table width="100%" border="0" cellspacing="3" cellpadding="2" class="outertable">
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"></td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <select name="txt_existing" >
          <option  value ="S" selected="selected"> ---Select--- </option>
          <option  value ="1"> Rate of Interest </option>
          <option  value ="2"> Commission on LG/LC </option>
          <option  value ="3"> Processing Charges </option>
          <option  value ="4"> Others (Specify) </option>
        </select>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td>Modifications Proposed by Branch</td>
      <td>Justification</td>
    </tr>
    <tr> 
      <td  colspan="2"></td>
    </tr>
    <tr> 
      <td> 
        <textarea name="txt_modification" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
      <td> 
        <textarea name="txt_justification" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
      </td>
    </tr>
    <tr> 
      <td  colspan="2">&nbsp;</td>
    </tr>
    <tr>
	    <td colspan="2">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td colspan="3"> 
      	<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
      </td>
    </tr>
    <tr> 
      <td colspan="3"></td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
        <div align="left"><b> <a href="javascript:callLink('exec_page6.jsp','executive','getData6')" > 
          &lt;&lt;&nbsp; Previous</a></b> </div>
      </td>
      <td width="33%" align="center"><b> 
        <jsp:include page="../../com/link1.jsp" flush="true"> 
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="tabid" value="6"/>
        </jsp:include>
        </b></td>
      <td width="33%">&nbsp; 
        <div align="right"><b>Pg.6/9&nbsp;<a href="javascript:callLink('comsre_justification.jsp?type=8','comproposal','getDataComment')" > 
          Next &gt;&gt; </a></b> </div>
      </td>
    </tr>
  </table>
	    
	    
		</td>
    </tr>
    
    <tr> 
      <td  colspan="3"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td width="2%">&nbsp; </td>
            <td width="38%" align="center"><b> Matters</b></td>
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
				String strmatter=Helper.correctNull((String)arrCol.get(1));
				if(strmatter.equalsIgnoreCase("S"))
				{
					strmatter="";
				}
				else if(strmatter.equalsIgnoreCase("1"))
				{
					strmatter="Rate of Interest";
				}
				else if(strmatter.equalsIgnoreCase("2"))
				{
					strmatter="Commission on LG/LC";
				}
				else if(strmatter.equalsIgnoreCase("3"))
				{
					strmatter="Processing Charges";
				}
				else if(strmatter.equalsIgnoreCase("4"))
				{
					strmatter="Others (Specify)";
				}
	%>
          <tr valign="top"> 
            <td width="2%"> 
              <input type="radio" name="rdosec" onclick="palceValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=i%>')" style="border: none">
              <input type="hidden" name="hidexist<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(1))%>">
              <input type="hidden" name="hidproposed<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(2))%>">
              <input type="hidden" name="hidjustification<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(3))%>">
            </td>
            <td width="38%"><%=strmatter%></td>
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
    <lapschoice:hiddentag pageid='<%=PageId%>'/>
    <input type="hidden" name="hidsno" />
  </table>
</form>
</body>
</html>

