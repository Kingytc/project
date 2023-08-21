<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
 
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrRow=(ArrayList)hshValues.get("arryRow");
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var varsearchby="<%=Helper.correctNull((String)hshValues.get("strSearchBy"))%>";
function selectGroup(groupid,groupname)
{
    
	window.opener.document.forms[0].elements["hidgroupID"].value=trim(groupid);
	window.opener.document.forms[0].elements["txt_groupname"].value=trim(groupname);
	window.opener.document.forms[0].hidBeanId.value="mastapplicant";
	window.opener.document.forms[0].hidBeanGetMethod.value="getCusGroupMembersMgmt";
	window.opener.document.forms[0].action=appURL+"action/setcusgroupmem_mgt.jsp";
	window.opener.document.forms[0].submit();	
	window.close();	
}
function doClose()
{
	window.close();
}
function doSearch()
{
	if(document.forms[0].sel_search.value=="")
	{
		alert("Please select search criteria");
		document.forms[0].sel_search.focus();
		return;
	}
	if(document.forms[0].txtsearch.value=="")
	{
		alert("Enter search value");
		document.forms[0].txtsearch.focus();
		return;
	}
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].action=appURL+"action/cusgrouplist.jsp";
	document.forms[0].hidBeanGetMethod.value="getCusGroupMgmt";
	document.forms[0].submit();
}
function callOnLoad()
{
	if(varsearchby!="")
	{
		document.forms[0].sel_search.value=varsearchby;	
	}
}
function fieldclear()
{
	document.forms[0].txtsearch.value="";
	document.forms[0].txtsearch.focus();
}
function callkeypressfun()
{
	if(document.forms[0].sel_search.value=="N")
	{
		allowAlphaNumeric();
	}
	else if((document.forms[0].sel_search.value=="I") || (document.forms[0].sel_search.value=="S"))
	{
		allowNumber(document.forms[0].txtsearch);
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form name="form1" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable" >
  <tr><td>&nbsp;</td></tr>
  <tr>
  <td>
  <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
  <tr> 
  <td>Search By</td>
 <td><select name="sel_search" onchange="fieldclear();">
 <option value=""><-- Select --></option>
 <option value="N">Group Name</option>
 <option value="I">Group ID</option>
 <option value="S">Sol ID</option>
 </select></td>
 <td><input type="text" name="txtsearch" onkeypress="callkeypressfun();" value="<%=Helper.correctNull((String)hshValues.get("strSearch")) %>">
 <td><input type="button" name="search" value="Search" onclick="doSearch()" class="buttonStyle"></td>
  </tr>
  </table>
  </td>
  </tr>
    <tr> 
      <td valign="top"> 
        <table width="90%" border="0" cellspacing="1" cellpadding="5" align="center" class="outertable">
         <tr class="dataheader">
        <td align="center">Group ID</td>
        <td align="center">Group Names</td>
        </tr>
        <%if(arrRow!=null && arrRow.size()>0){
        	for(int i=0;i<arrRow.size();i++){
        	arrCol=(ArrayList)arrRow.get(i);%>
        <tr class="datagrid" align="center">
        <td><a href="javascript:selectGroup('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>')" class="blackfont"><%=Helper.correctNull((String)arrCol.get(0))%></a></td>
        <td><a href="javascript:selectGroup('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>')" class="blackfont"><%=Helper.correctNull((String)arrCol.get(1))%></a></td>
        </tr>
        
        <%}}else{ %>
        <tr class="datagrid">
        	<td align="center" colspan="2"> -- No Groups Available--</td>
        </tr>
        <%} %>
        <%for(int i=0;i<5;i++){ %>
        <tr  class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
        <%} %>
          <tr> 
            <td> 
            <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>


