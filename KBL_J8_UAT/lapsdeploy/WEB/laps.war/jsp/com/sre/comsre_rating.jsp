<%@include file="../../share/directives.jsp"%>

<%
ArrayList arr = null;
ArrayList arrCol = new ArrayList();
int arrsize = 0;

if (hshValues != null) {
	arr = (ArrayList) hshValues.get("arrVal");
}

if (arr != null) {
	arrsize = arr.size();

}

String[] strprevious= new String[8];
String[] strcurrent= new String[8];

for(int i=0;i<strprevious.length;i++)
{
	strprevious[i]="";
	strcurrent[i]="";
}

if (arr != null) 
{
	for(int i =0;i<arr.size();i++)
	{	
		arrCol = (ArrayList) arr.get(i);
		
		strprevious[i] = Helper.correctNull((String)arrCol.get(0));
		strcurrent[i] = Helper.correctNull((String)arrCol.get(1));
	}	
}

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
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varslno="<%=Helper.correctNull((String)hshValues.get("rate_slno"))%>";
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
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getDataSRERatingDetails"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comsre_rating.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanMethod.value="upDataSRERatingDetails"
		document.forms[0].hidBeanGetMethod.value="getDataSRERatingDetails"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comsre_rating.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
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
		document.forms[0].hidAction.value="edit";
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="executive"
	document.forms[0].hidBeanMethod.value="upDataSRERatingDetails"
	document.forms[0].hidBeanGetMethod.value="getDataSRERatingDetails"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/comsre_rating.jsp";
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


function callLink(page,bean,method)
{	
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	<%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	document.forms[0].hidCategoryType.value="SRE";
	<%}else{%>
		document.forms[0].hidCategoryType.value="STL";
		<%}%>
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}


function getValues()
{
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getDataSRERatingDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comsre_rating.jsp";
		document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="otrmatters" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
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
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
		<%if (strCategoryType.equalsIgnoreCase("SRE")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Process Note </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Process Note -&gt; Page 4 </td>
		</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
		<tr>
			<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Adhoc Limit -&gt; Process Note -&gt; Page	1  </td>
		</tr>
		
		<%}%>
	</table>
  <span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <br>
  <table width="80%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
    <tr class="dataheader"> 
      <td colspan="3"><b>Internal Credit Rating </b></td>
    </tr>
	 <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td><b>Year</b></td>
      <td align="center"><b>Previous Year</b></td>
      <td align="center"><b>Current Year</b></td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Total score obtained">
        Total score obtained</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="15" onKeyPress="allowNumber(this)" value="<%=strprevious[0]%>" onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="15" onKeyPress="allowNumber(this)" value="<%=strcurrent[0]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Grade">
        Grade</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="15" onKeyPress="notAllowSplChar()" value="<%=strprevious[1]%>" onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="15" onKeyPress="notAllowSplChar()" value="<%=strcurrent[1]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Risk definition">
        Risk definition</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="100" onKeyPress="notAllowSplChar()" value="<%=strprevious[2]%>" onBlur="roundtxt(this)">
        </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="100" onKeyPress="notAllowSplChar()" value="<%=strcurrent[2]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left" colspan="3">&nbsp;</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td align="left" colspan="3"><b>Parameter</b></td>
    </tr>
    
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Borrower rating">
        Borrower rating</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strprevious[3]%>" onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strcurrent[3]%>"  onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Facility rating">
        Facility rating</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strprevious[4]%>"  onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strcurrent[4]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Cash flow related parameters">
        Cash flow related parameters</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strprevious[5]%>" onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strcurrent[5]%>"  onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Bussiness aspects">
        Business aspects</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strprevious[6]%>"  onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strcurrent[6]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td align="left"> 
        <input type="hidden" name="txt_parameter" value="Total Marks with grade">
        Total Marks with grade</td>
      <td> 
        <input type="text" name="txt_previous" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strprevious[7]%>" onBlur="roundtxt(this)">
      </td>
      <td> 
        <input type="text" name="txt_current" size="25" maxlength="30" onKeyPress="notAllowSplChar()" value="<%=strcurrent[7]%>" onBlur="roundtxt(this)">
      </td>
    </tr>
    <tr align="center"> 
      <td colspan="3">&nbsp; </td>
    </tr>
    <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
    <tr > 
      <td colspan="3">Reason for Migration, if any.</td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <textarea name="txt_migration" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("mig_remarks"))%></textarea>
      </td>
    </tr>
    <tr > 
      <td colspan="3">External Credit Rating :</td>
    </tr>
    <tr > 
      <td colspan="3"> 
        <textarea name="txt_extrating" cols="80" wrap="VIRTUAL" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("extrating"))%></textarea>
      </td>
    </tr>
    <%} %>
    <tr> 
      <td colspan="3"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
          <tr> 
            <td colspan="3"> <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
            </td>
          </tr>
          <tr> 
            <td colspan="3"></td>
          </tr>
          <tr> 
            <td width="33%">&nbsp; 
            <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>  
             <div align="left"><b> <a href="javascript:callLink('comsre_justification.jsp?type=8','comproposal','getDataComment')" > 
                &lt;&lt;&nbsp; Previous</a></b> </div>
                <%}else{ %>
                <div align="left"><b> <a href="javascript:callLink('comstl_comments.jsp?type=9&hidpage=norms~bplr','comproposal','getDataComment')" > 
                &lt;&lt;&nbsp; Previous</a></b> </div>
                <%} %>
            </td>
            <td width="33%" align="center"><b> 
              <jsp:include page="../../com/link1.jsp" flush="true"> 
              <jsp:param name="cattype" value="<%=strCategoryType%>" />
              <jsp:param name="tabid" value="8"/>
              </jsp:include>
              </b></td>
            <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>  
            <td width="33%">&nbsp; 
              <div align="right"><b>Pg.8/9&nbsp;<a href="javascript:callLink('exec_page11.jsp','executive','getData11')" > 
                Next &gt;&gt; </a></b> </div>
            </td>
            <%}else{ %>
            <td width="33%">&nbsp; 
              <div align="right"><b>Pg.4/5&nbsp;<a href="javascript:callLink('exec_page11.jsp','executive','getData11')" > 
                Next &gt;&gt; </a></b> </div>
            </td>
            <%} %>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="3">&nbsp;</td>
    </tr>
    <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  </table>
</form>
</body>
</html>