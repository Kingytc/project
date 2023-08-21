<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)
	for(int i=0;i<2;i++)
	{	vecCol =(ArrayList)vecRow.get(i);
		strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}
	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}
}
else
{
	strgenid ="0";
}

String strcat="";
if(!strCategoryType.equalsIgnoreCase(null))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callDisable(one)
{
	for( i=1;i<=2;i++)		
	{
		document.forms[0].elements["txt_industryactivity"+i].readOnly=one;	
	}		
}
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmddel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmddelete.disabled=bcmddel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	callDisable(true);
	document.forms[0].hidparam.value="ExistingIndustrialActivity^ProposedIndustrialActivity";
	document.forms[0].hidTabName.value="IndustryActivity";
	document.forms[0].hidMethod.VALUE="getGeneralDetails";
}
function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
}
function doSave()
{	
	if(<%=vecrowsize%> >0)
	{
		document.forms[0].hidAction.value="update";
	}
	else
	{
		document.forms[0].hidAction.value="insert";
	}
	document.forms[0].hidMethod.value="getGeneralDetails";
	document.forms[0].hidBeanGetMethod.value="updateGeneralData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above10_industryactivity.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="Delete";
	if(!ConfirmMsg("101"))
    {
		return false;
	}

	document.forms[0].hidBeanGetMethod.value="removeUtillitiesData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appURL+"action/ssi_above10_industryactivity.jsp";	
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_industryactivity.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		 document.forms[0].submit();
	}
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="4" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr><td class="page_flow">Home  -&gt; <%=strcat %>-&gt; Application-&gt; Ind. Activity   -&gt;Industrial/Business Activity</td>
          </tr>
  </table>    
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>   
<lapschoice:Activitytab tabid="1" ssitype='<%=strSSIType%>' />
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                      <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
						{
							vecCol =(ArrayList)vecRow.get(0);%>
                      <tr class="dataheader"> 
                        <td><b>Brief Description 
                          of the Industrial/Business activity</b></td>
                      </tr>
                      <tr> 
                        <td width="84%">Existing</td>
                      </tr>
                      <tr> 
                        <td width="84%"> 
                          <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                          <textarea name="txt_industryactivity1" cols="125" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%> </textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="84%">Proposed</td>
                      </tr><% vecCol =(ArrayList)vecRow.get(1);%>
                      <tr> 
                        <td width="84%"> 
                          <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                          <textarea name="txt_industryactivity2" cols="125" wrap="VIRTUAL" rows="8"><%=vecCol.get(1)%> </textarea>
                        </td>
                      </tr>
                      <%
						
						}
					else
						{
					%>
                      <tr class="dataheader"> 
                        <td><b>Brief Description of the Industrial/Business activity</b></td>
                      </tr>
                       <tr> 
                        <td width="84%">Existing</td>
                      </tr>
                      <tr> 
                        <td width="84%"> 
                          <textarea name="txt_industryactivity1" cols="125" wrap="VIRTUAL" rows="8"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="84%">Proposed</td>
                      </tr>
                      <tr> 
                        <td width="84%"> 
                          <textarea name="txt_industryactivity2" cols="125" wrap="VIRTUAL" rows="8"></textarea>
                        </td>
                      </tr>
                      <%}%>
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
<br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br> 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="ExistingIndustrialActivity">
<input type="hidden" name="hidDesc2" value="ProposedIndustrialActivity">
<input type="hidden" name="hidTotalDesc" value="2">
<input type="hidden" name="hidFieldPrefix" value="txt_industryactivity">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<input type="hidden" name="otherGetMethod" value="">
</form>
</body>
</html>
