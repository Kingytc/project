<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
function callLink(page,bean,method)
{	
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	 <%if(strCategoryType.equalsIgnoreCase("SRE")){%>
	 document.forms[0].hidCategoryType.value="SRE";
	 <%}else{%> 
	 document.forms[0].hidCategoryType.value="CORP"; 
	 	 <%}%>
 	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit(); 
}

function placevalues()
{
	disableFields(true);
	var exec_summ_indlevelrbiY="<%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelrbiY"))%>";
	<%if(!strCategoryType.equalsIgnoreCase("SRE")){%>
	if (exec_summ_indlevelrbiY!="")
	{
		document.forms[0].exec_summ_indlevelrbiY.value=exec_summ_indlevelrbiY;
	}
	else 
	{
		document.forms[0].exec_summ_indlevelrbiY.value="0";
	}
	<%}%>
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
	enableButtons(true,false,false,false,false);
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
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getData5";
		document.forms[0].action=appUrl+"action/exec_page5.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="edit";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData5";
	document.forms[0].hidBeanGetMethod.value="getData5";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page5.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanMethod.value="updateData5";
		document.forms[0].hidBeanGetMethod.value="getData5";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page5.jsp";
		document.forms[0].submit();
	 }
}

</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="placevalues()">
<form name="frmpri" method = post class="normal">
<%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 4
		</td>
	</tr>
</table>
<%} %>
<span style="display:none;">
            				<lapschoice:borrowertype />
            			</span>
  						<lapschoice:application/>
<table width="100%" border="1" cellspacing="0" cellpadding="5"align="center" class="outertable">
	<tr> 
    	<td valign="top"> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        		<tr> 
            		<td valign="top" colspan="2"> 
            			<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
              				<tr> 
                				<td colspan="2">
                					REGULATORY / COMPLIANCE RISK:
                				</td>
              				</tr>
              				<%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
              				<tr> 
                  				<td width="30%">
                  					Whether Director/Partner /proprietor is a director in our /other bank 
                    				or is related to them.
                    			</td>
                				<td width="70%">
                					<select name="exec_summ_indlevelrbiY">
                    					<option value="0" selected>----Select----</option>
                    					<option value="1">Yes</option>
                    					<option value="2">No</option>
                  					</select>
                  				</td>
              				</tr>
              				<tr> 
                				<td width="30%">
                					If Yes, Name of such Director with name of the bank
                				</td>
                				<td width="70%">
                  					<textarea name="exec_summ_indlevelrbiremarks" cols="105" size="40" rows="5" 
                  					onKeyPress="textlimit(document.forms[0].exec_summ_indlevelrbiremarks,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelrbiremarks"))%></textarea>
                  				</td>
              				</tr>
              				<%} %>
            			</table>
          			</td>
        		</tr>
        		<%if(!strCategoryType.equalsIgnoreCase("SRE")){ %>
        		<tr> 
            		<td valign="top" colspan="2"> 
            			<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
              				<tr> 
                				<td width="30%">
                					If Yes, Type of the Relation
                				</td>
				                <td width="70%">
                				  <textarea name="exec_summ_indlevelbankremarks" cols="105" 
                				  	size="40" rows="5" 
                				  	onKeyPress="textlimit(document.forms[0].exec_summ_indlevelbankremarks,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelbankremarks"))%></textarea>
								</td>
              				</tr>
            			</table>
          			</td>
        		</tr>
        		<tr> 
            		<td valign="top" width="30%">
            			Any litigation in force aganist the firm/comapny 
              			or aganist the partners/Directors.If so,mention details and present 
              			position 
              		</td>
            		<td valign="top" width="70%"> 
              			<textarea name="exec_summ_indlevelcomkeystrengths" size="40" cols="105" rows="5" 
              			onKeyPress="textlimit(document.forms[0].exec_summ_indlevelcomkeystrengths,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelcomkeystrengths"))%></textarea>
              		</td>
        		</tr>
        		<%} %>
        		<tr> 
            		<td valign="top" width="30%">
            			Any Irregular feature observed in the monitoring report
            		</td>
            		<td valign="top" width="70%"> 
              			<textarea name="exec_summ_indlevelgenmanager" size="40" cols="105" rows="5" 
              			onKeyPress="textlimit(document.forms[0].exec_summ_indlevelgenmanager,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("exec_summ_indlevelgenmanager"))%></textarea>
                 	</td>
              	</tr>
       		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr> 
    	<td colspan="3"> 
        	
       <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
        
        </td>
    </tr>
    <tr> 
      <td width="33%">&nbsp; 
      <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
      <div align="left"><a href="javascript:callLink('exec_page2.jsp','executive','getData2')" >&lt;&lt;&nbsp; Previous</a></div>
      <%} else{%>
        <div align="left"><a href="javascript:callLink('exec_page4.jsp','executive','getData4')" >&lt;&lt;&nbsp; Previous</a></div>
        <%} %>
      </td>
      <td width="33%" align="center">
        <jsp:include page="../com/link1.jsp" flush="true"> 
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="tabid" value="3"/>
        </jsp:include>
        </td>
      <td width="33%">&nbsp; 
      <div align="right">
      
      <%if(strCategoryType.equalsIgnoreCase("SRE")){ %>
       Pg.3/9  &nbsp;
       <%}else{%>
      Pg.4/8  &nbsp;
      <%} %>
      <a href="javascript:callLink('exec_page10.jsp','executive','getData10')" >Next &gt;&gt; </a> </div>
    </td>
    </tr>
</table>
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="" >
  <input type="hidden" name="hidSourceUrl" value="">
   </form>  
 </body></html>
