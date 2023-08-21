<%@include file="../share/directives.jsp"%>

<%
   	ArrayList arrFromUsr=(ArrayList)hshValues.get("arrFromUsr");
   	ArrayList arrToUsr=(ArrayList)hshValues.get("arrToUsr");
   	ArrayList arrFromflow=(ArrayList)hshValues.get("arrFromflow");
   	ArrayList arrToflow=(ArrayList)hshValues.get("arrToflow");
   	ArrayList arrDate=(ArrayList)hshValues.get("arrDate");
   	ArrayList arrMailtype=(ArrayList)hshValues.get("arrMailType");
  	String strmoduletype=Helper.correctNull((String)request.getParameter("hidmoduletype"));
	String chkstatus = Helper.correctNull((String)hshValues.get("Stateflag"));
	
%>
<html>
<head>
<title>Personal - Work Flow</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var chkstatus="<%=chkstatus%>";
function callOnload()
{
	if(chkstatus=="1" && document.forms[0].appstatus.value == "Processed/Approved")
 	{
		alert("Application is Approved");
	}
}

function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getNPAAction";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appUrl+"action/npa_appworkflowaction.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function callClose()
{
	if(ConfirmMsg(100))
	{
	
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function dohlp()     
{
  	var hlpvar = appUrl+"phlp/loan_appretail_workflow_his.htm";
  	var title = "History";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<STYLE>
</STYLE>
</head>
<body   onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
					<%if(strmoduletype.equalsIgnoreCase("PAWO"))
						{%>
						<lapstab:pwourltag pageid="8"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("SUIT"))
						{
						%>
						<lapstab:suiturltag pageid="11"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("OTSCO"))
						{
						%>
						<lapstab:otscourltag pageid="9"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("STAT"))
						{
						%>
						<lapstab:staturltag pageid="11"/>
						<%}
						else if(strmoduletype.equalsIgnoreCase("SARFI"))
						{
						%>
						<lapstab:sarfiurltag pageid="6"/>
						<%}%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
       	 <tr> <%if(strmoduletype.equalsIgnoreCase("PAWO"))
				{%>
				 <td valign="top" colspan=5 class="page_flow">
				 Home -&gt; NPA-&gt;Prudential Write Off -&gt;Work Flow  -&gt; History
				 </td>
				<%}
				else if(strmoduletype.equalsIgnoreCase("SUIT"))
				{
				%>
				 <td valign="top" colspan=5 class="page_flow">
				 Home -&gt; NPA-&gt; Filing Of Suit   -&gt;Work Flow  -&gt; History
				 </td>
				<%}
				else if(strmoduletype.equalsIgnoreCase("OTSCO"))
				{
				%>
				 <td valign="top" colspan=5 class="page_flow">
				 Home -&gt; NPA-&gt; Compromise Proposal   -&gt;Work Flow  -&gt; History
				 </td>
				<%}
				else if(strmoduletype.equalsIgnoreCase("STAT"))
				{
				%>
				 <td valign="top" colspan=5 class="page_flow">
				 Home -&gt; NPA-&gt; Status Note   -&gt;Work Flow  -&gt; History
				</td>
				<%}else if(strmoduletype.equalsIgnoreCase("SARFI"))
				{
				%>
				 <td valign="top" colspan=5 class="page_flow">
				 Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Work Flow  -&gt; History
				</td>
				<%}%>
        </tr>
      </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr> 
    	<td height="20" width="50%" valign="bottom"> 
        	<table width="40%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          		<tr align="center"> 
            		<td width="33%" class="sub_tab_active"><b>History</b></td>
            		<td width="33%"  id="action" class="sub_tab_inactive"><b><a href="javascript:callOtherTab('action')" >Action</a></b></td>
            		<td width="33%"  style="visibility:hidden" class="sub_tab_inactive"><b><a href="javascript:callOtherTab('remarks')" >Remarks</a></b></td>
          		</tr>
        	</table>
      	</td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3" height="10%"  align="center" class="outertable">
	<tr> 
    	<td valign="top"> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable">
          		<tr> 
            		<td> 
              			<table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%" class="outertable">
                			<tr> 
                  				<td valign="top" align="left">
                  					<br>
                      					<b>History</b>
                      				 <br>
                                	<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                      					<tr> 
                        					<td width="47%" valign="top"> 
                          						<table width="100%" border="0" cellspacing="0" cellpadding="4"  height="285" class="outertable border1">
                            						<tr> 
                              							<td valign="top"> 
                                							<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
                                  								<tr class="dataheader"> 
                                    								<td width="10%" align="center">
                                    									
                                    										From Flowpoint
                                    									
                                    								</td>
                                    <td width="19%" height="22" > 
                                      <div align="center">Sent 
                                        By</div>
                                    </td>
                                    <td width="16%" height="22"> 
                                      <div align="center">Sent 
                                        On</div>
                                    </td>
                                    <td width="15%" height="22"> 
                                      <div align="center">To 
                                        Flowpoint</div>
                                    </td>
                                    <td width="21%" height="22"> 
                                      <div align="center">Sent 
                                        To</div>
                                    </td>
                                    <td width="19%" height="22"> 
                                      <div align="center">NPA
                                        Type</div>
                                    </td>
                                  </tr>
                                  <tr align="center"> 
                                    <td colspan="6"> 
                                      <DIV CLASS="cellContainer"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
                                          <%
                                          
                                          if(arrFromUsr!=null && arrFromUsr.size()>0)
                                          {
                                          for(int i=0;i<arrFromUsr.size();i++){ %>
                                          <tr > 
                                            <td height="22" width="10%" align="center"> 
                                              <%=Helper.correctNull((String)arrFromflow.get(i))%> 
                                              </td>
                                            <td height="22" width="23%">  
                                              &nbsp;<%=Helper.correctNull((String)arrFromUsr.get(i))%></td>
                                            <td height="22" width="11%" align="center"> 
                                              <%=Helper.correctNull((String)arrDate.get(i))%> 
                                              </td>
                                            <td height="22" width="16%" align="center"> 
                                              <%=Helper.correctNull((String)arrToflow.get(i))%> 
                                              </td>
                                            <td height="22" width="21%"> <%=Helper.correctNull((String)arrToUsr.get(i))%> 
                                              </td>
                                              <% 
                                              	String npatype=Helper.correctNull((String)arrMailtype.get(i));
                                              if(npatype.equalsIgnoreCase("PAWO"))
                      							{
                      							npatype="Prudential Write off";%>
                      							
                      						<%}
                      						else if(npatype.equalsIgnoreCase("SUIT"))
                      						{
                      							npatype="Filing of Suit";%>
                      						<%}
                      						else if(npatype.equalsIgnoreCase("OTSCO"))
                      						{
                      						npatype="Compromise Proposal";%>
                      						<%}
                      						else if(npatype.equalsIgnoreCase("STAT"))
                      						{
                      							npatype="Status Note";%>
                      						<%}
                      						else if(npatype.equalsIgnoreCase("SARFI"))
                      						{
                      						npatype="Sarfaei Proposal";%>
                      						<%}
                                              
                                              %>
                                            <td height="22" width="19%">  
                                              <%=npatype%> &nbsp;</td>
                                          </tr>
                                          <% } }%>
                                        </table>
                                      </div>
                                    </td>
                                  </tr>
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
            </td>
          </tr>
        </table>
        
      </td>
    </tr>
  </table>
  <br>
  <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="top"> 

            <td height="2" align="center"> 
                <input type="button" name="cmdclose" value="Close"  onclick = "callClose()" class="buttonClose">
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
