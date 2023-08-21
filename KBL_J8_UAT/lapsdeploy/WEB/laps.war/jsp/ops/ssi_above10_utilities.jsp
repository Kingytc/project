<%@include file="../share/directives.jsp"%>
<%
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";
int vecrowsize =0;
if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)
	{
		for(int i=0;i<5;i++)
		{	vecCol =(ArrayList)vecRow.get(i);
			strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
		}		
		if(!strgenid.equals(""))
		{
		strgenid=strgenid.substring(0,(strgenid.length())-1);	
		}
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";

function callDisable(one)
{
	for( i=1;i<=6;i++)		
	{
		document.forms[0].elements["txt_utilities"+i].readOnly=one;	
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
	document.forms[0].hidparam.value="PowerContractedLoad^PowerConnectedLoad^PowerFutureConsumption^Water^Fuel^Others";
	document.forms[0].hidTabName.value="Utilities";
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
	document.forms[0].action=appUrl+"action/ssi_above10_utilities.jsp";
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
	document.forms[0].action=appURL+"action/ssi_above10_utilities.jsp";	
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_utilities.jsp";
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
        <jsp:param name="pageid" value="5" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
            <td class="page_flow">Home -&gt;  <%=strcat %> -&gt; Application -&gt; Tech. Feasibility -&gt; Utilities</td>
          </tr>
	</table> 
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>   
<lapschoice:Techfeasibilitytab tabid="10" typessi='<%=strSSIType%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center" >
          <tr> 
            <td valign="middle"> 
              <table width="70%" border="1" cellspacing="0" cellpadding="5" align="center" class="outertable">
                <tr> 
                  <td valign="top" align="center"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                      <tr> 
                        <td colspan="2"><b>UTILITIES 
                          </b>(Give 
                          comments on requirement /availability/adequacy,qualitative 
                          aspects,etc) </td>
                      </tr>
                      <tr> 
                        <td width="78%" >a) 
                          Power</td>
                        <td width="22%" > </td>
                      </tr>
                      <tr> 
                        <td width="78%">Contracted 
                          Load </td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>" >
						<textarea name="txt_utilities1" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(1);%>
                      <tr> 
                        <td width="78%">Connected 
                          Load  </td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
						<textarea name="txt_utilities2" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(2);%>
                      <tr> 
                        <td width="78%">Future 
                          Power Consumption (in No of units per month)</td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
							<textarea name="txt_utilities3" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="78%">(Enclose 
                          certified xerox copy of the power connection)</td>
                        <td width="22%" align="right">&nbsp;</td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(3);%>
                      <tr> 
                        <td width="78%">b) 
                          Water </td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
						<textarea name="txt_utilities4" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(4);%>
                      <tr> 
                        <td width="78%">c) 
                          Fuel </td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt5" VALUE="<%=vecCol.get(0)%>">                         
						<textarea name="txt_utilities5" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(5);%>
                      <tr> 
                        <td width="78%">d) 
                          Other's Specify</td>
                        <td width="22%" align="right"> 
                          <INPUT TYPE="hidden" NAME="hidtxt6" VALUE="<%=vecCol.get(0)%>">                        
						  <textarea name="txt_utilities6" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"><%=vecCol.get(1)%></textarea>
                      </tr>
                      <%
					  }
					  else
					  {
					%>
                      <tr> 
                        <td colspan="2"><b>UTILITIES 
                          </b>(Give 
                          comments on requirement /availability/adequacy,qualitative 
                          aspects,etc) </td>
                      </tr>
                      <tr> 
                        <td width="78%" >a) 
                          Power</td>
                        <td width="22%"  align="right"> </td>
                      </tr>
                      <tr> 
                        <td width="78%">Contracted 
                          Load </td>
                        <td width="22%" align="right">
					<textarea name="txt_utilities1" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="78%">Connected 
                          Load  </td>
                        <td width="22%" align="right">
						<textarea name="txt_utilities2" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="78%">Future 
                          Power Consumption (in No of units per month)</td>
                        <td width="22%">
							<textarea name="txt_utilities3" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="78%">(Enclose 
                          certified xerox copy of the power connection)</td>
                        <td width="22%" align="right">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="78%">b) 
                          Water </td>
                        <td width="22%" align="right"> 
							<textarea name="txt_utilities4" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="78%">c) 
                          Fuel </td>
                        <td width="22%" align="right"> 
									<textarea name="txt_utilities5" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
                        </td>
                      </tr>
                      <tr> 
                        <td width="60%">d) 
                          Other's Specify</td>
                        <td width="40%" align="right">
											<textarea name="txt_utilities6" cols="75" rows="5" onBlur="JavaScript:this.value =trim(this.value)" onkeypress="formattext()" style="text-align:left"></textarea>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDesc1" value="PowerContractedLoad">
<input type="hidden" name="hidDesc2" value="PowerConnectedLoad">
<input type="hidden" name="hidDesc3" value="PowerFutureConsumption">
<input type="hidden" name="hidDesc4" value="Water"> 
<input type="hidden" name="hidDesc5" value="Fuel"> 
<input type="hidden" name="hidDesc6" value="Others">
<input type="hidden" name="hidTotalDesc" value="6">
<input type="hidden" name="hidFieldPrefix" value="txt_utilities">
<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
</form>
</body>
</html>
