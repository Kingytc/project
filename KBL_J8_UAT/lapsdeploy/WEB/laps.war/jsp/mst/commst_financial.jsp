<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
ArrayList  vecdesc = (ArrayList)hshValues.get("vecdesc");
ArrayList vectype=(ArrayList)hshValues.get("vectype");
ArrayList vecCuryear = (ArrayList)hshValues.get("year");
ArrayList vecPreyear = (ArrayList)hshValues.get("prevyear");
ArrayList vecNextyear = (ArrayList)hshValues.get("nextyear");
ArrayList vecNextyear2 = (ArrayList)hshValues.get("nextyear2");
ArrayList vecPreyearHold1 = (ArrayList)hshValues.get("prevyearhold1");
 
String strPage=Helper.correctNull((String)hshValues.get("page"));

int vecsize=0;


String curYear="",curYearDesc="",pervYear="",prevYearDesc="",nextYear="",nextYearDesc="",pervYear1="",prevYearDesc1="";
String nextYear2="",nextYearDesc2="";

 ArrayList yearval=new ArrayList();
 yearval=(ArrayList)hshValues.get("yearvalue");
 if(yearval.size()>0 && yearval!=null)
 {
	curYear= Helper.correctNull((String)yearval.get(0));
	curYearDesc= Helper.correctNull((String)yearval.get(1));
	
	pervYear= Helper.correctNull((String)yearval.get(2));
	prevYearDesc= Helper.correctNull((String)yearval.get(3));
	
	nextYear= Helper.correctNull((String)yearval.get(4));
	nextYearDesc= Helper.correctNull((String)yearval.get(5));
	
	pervYear1= Helper.correctNull((String)yearval.get(6));
	prevYearDesc1= Helper.correctNull((String)yearval.get(7));
	
	nextYear2= Helper.correctNull((String)yearval.get(8));
	nextYearDesc2= Helper.correctNull((String)yearval.get(9));
 }
 
 String a="",b="",c="",d="",e="";
 
 if(curYearDesc.trim().equals("a"))
 {
	 a="Audited";
 }
else if(curYearDesc.trim().equals("u"))
 {
	 a="Unaudited";
 }
 else if(curYearDesc.trim().equals("e"))
 {
	 a="Estimated";
 }
 else if(curYearDesc.trim().equals("p"))
 {
	 a="Projection";
 }
 
 if(prevYearDesc.trim().equals("a"))
 {
	 b="Audited";
 }
else if(prevYearDesc.trim().equals("u"))
 {
	 b="Unaudited";
 }
 else if(prevYearDesc.trim().equals("e"))
 {
	 b="Estimated";
 }
 else if(prevYearDesc.trim().equals("p"))
 {
	 b="Projection";
 }
 
  if(nextYearDesc.trim().equals("a"))
 {
	 c="Audited";
 }
else if(nextYearDesc.trim().equals("u"))
 {
	 c="Unaudited";
 }
 else if(nextYearDesc.trim().equals("e"))
 {
	 c="Estimated";
 }
 else if(nextYearDesc.trim().equals("p"))
 {
	 c="Projection";
 }
  
 if(prevYearDesc1.trim().equals("a"))
 {
	 d="Audited";
 }
else if(prevYearDesc1.trim().equals("u"))
 {
	 d="Unaudited";
 }
 else if(prevYearDesc1.trim().equals("e"))
 {
	 d="Estimated";
 }
 else if(prevYearDesc1.trim().equals("p"))
 {
	 d="Projection";
 }
 
 if(nextYearDesc2.trim().equals("a"))
 {
	 e="Audited";
 }
else if(nextYearDesc2.trim().equals("u"))
 {
	 e="Unaudited";
 }
 else if(nextYearDesc2.trim().equals("e"))
 {
	 e="Estimated";
 }
 else if(nextYearDesc2.trim().equals("p"))
 {
	 e="Projection";
 }
 
 
%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

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

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>

<Script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callLink(page,bean,method)
{	
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}


function placevalues()
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
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
}
	
function doEdit()
{
	document.forms[0].hidAction.value="Update";
	disableFields(false);
	enableButtons(true,false,false,false,false)
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanGetMethod.value="getFinancialData";
		document.forms[0].action=appURL+"action/commst_financial.jsp";
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

function doSave()
{
	document.forms[0].hidBeanId.value="modsancterms"
	document.forms[0].hidBeanMethod.value="updateFinancial";
	document.forms[0].hidBeanGetMethod.value="getFinancialData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/commst_financial.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	var con=ConfirmMsg('152');
	if(con)
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="modsancterms"
		document.forms[0].hidBeanMethod.value="updateFinancial";
	    document.forms[0].hidBeanGetMethod.value="getFinancialData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commst_financial.jsp";
		document.forms[0].submit();
	}
}

</script>
</head>

<body  onload="placevalues()">
<form method="post" name="frmpri" class="normal">
<lapstab:applurllinksmst pageid="3"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"><tr><td class="page_flow">
Corporate &amp; SME -&gt;  Modification in Sanction Terms -&gt; Financial Highlights
</td>
</tr>
</table>
<lapschoice:MSTApplications/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
        
           <%  if((!pervYear.trim().equalsIgnoreCase("")) || (!pervYear1.trim().equalsIgnoreCase(""))){
                     %>
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="left" class="outertable">
                      <tr class="dataheader"> 
                        <td width="28%" align="center">Particulars</td>
                        <td colspan="2" align="center" width="30%">Last 2 Years</td>
                        <td align="center" width="12%" >Current Year</td>
                        <td  colspan="2" align="center" width="30%">Next 2 Years</td>
                        </tr>
                     <tr> 
                        <td width="28%">&nbsp;</td>
                        <td align="center" width="15%"><b><%=pervYear%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=pervYear1%></b></td>
                        <td align="center" width="12%"><b><%=curYear%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=nextYear%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=nextYear2%>&nbsp;</b></td>
                      </tr>
                      <tr> 
                        <td width="28%">&nbsp;</td>
                        <td align="center" width="15%" ><b><%=b%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=d%></b></td>
                        <td align="center" width="12%" ><b><%=a%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=c%>&nbsp;</b></td>
                        <td align="center" width="15%"><b><%=e%>&nbsp;</b></td>
                      </tr>
                      
                      <%	  

				if(vecdesc!=null)
				{
					vecsize = vecdesc.size();
				}

				for(int i=0;i<vecsize;i++)
				{
					String desc =Helper.correctNull((String)vecdesc.get(i));
					String type =Helper.correctNull((String)vectype.get(i));
					String col1 =Helper.correctNull((String)vecCuryear.get(i));//3
					String col3 = Helper.correctNull((String)vecPreyear.get(i));//1
					String col5 =Helper.correctNull((String)vecNextyear.get(i));//4
					String col9 =Helper.correctNull((String)vecNextyear2.get(i));//5
					String col8 =Helper.correctNull((String)vecPreyearHold1.get(i));//2
			%>
                      <tr bgcolor="#EEEAE3"> 
                        <% 
				 if((type.trim().equals("HE")|| type.trim().equals("H")) && (!strPage.trim().equals("MPBF1")))
				{ 				
					%>
                      <td width="28%"><%=desc%></td>
                      <td width="15%" align="center">&nbsp;</td>
                      <td width="15%" align="right">&nbsp;</td>
                      <td width="12%" align="center">&nbsp;</td>
                      <td width="15%" align="center">&nbsp;</td>  
                      <td width="15%" align="right">&nbsp;</td>    
                                   
                    <% 
				}
				else
				{
				%>
                      <td width="28%"><%=desc%></td>
                      <td width="15%" align="center">&nbsp;<%=col3%></td>
                      <td width="15%" align="right" >&nbsp;<%=col8%></td>
                      <td width="12%" align="center" >&nbsp;<%=col1%></td>
                      <td width="15%" align="center" >&nbsp;<%=col5%></td>
                      <td width="15%" align="center" >&nbsp;<%=col9%></td>
                      <%
				}
				}
          }   %>
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
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
                      <td><b>COMMENTS ON FINANCIAL INDICATORS:</b></td>
          </tr>
          <tr> 
            <td> <textarea name="exec_notes"  cols="120" rows="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<br> 
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 
  <table>
  
  </table>
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="flowtype" value="MST">
</form>
</body>
</html>