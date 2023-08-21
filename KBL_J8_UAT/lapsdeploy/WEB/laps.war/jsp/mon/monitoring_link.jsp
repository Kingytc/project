<%@ page import="com.sai.laps.helper.*"%>
<%
String grpRights = Helper.correctNull((String)session.getAttribute("strGroupRights"));
%>
<HTML>
<HEAD>
<TITLE>POSTDISBBURSAL - Monitoring</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<style  type="text/css">
#inner
		{
		margin:75px 10px 18px 10px;
		border-top:#e12500 10px solid;
		border-bottom:#e12500 10px solid;
		background-color:#fff;
		}
.btn
		{
		height:22px;
 		width:50px;
		border:#ffffff 1px solid;
		background-color:#2d6193;
	    color:#fff;
		font-family:Verdana, Arial, Helvetica, sans-serif;
		font-size:.9em;
		margin:1px 2px 8px 4px;
		font-weight:bold;
		}
</style>
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(page,mon)
{
	 document.forms[0].hidmontype.value = mon;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function callPageLink(pagename)
{
  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
  document.forms[0].submit();
}

function gotoNavigation()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}

</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</HEAD>
<BODY>
<form name="myform" method="post" action="">
<div id="inner">
	<table width="90%" border="0" cellspacing="0" cellpadding="5" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<td>
							 <%
                   				if(grpRights.charAt(14) == '1') 
                   				{
							%>
                    			<a href="javascript:callFunction('mon_borrowersearch.jsp','MONIT')" 
                    			class="blackfont"> 
                    			<b>Monitoring Register</b></a>
                    		<%
					  			}
					  			else
					  			{
					  		%>
                    			<font   color="#999999"><b>Monitoring Register</b> </font>
                    		<%
					  			}
					  		%>
					  	</td>
					</tr>
					<tr>
						<td>
							 <%
                   				if(grpRights.charAt(15) == '1') 
                   				{
							%>
                    			<a href="javascript:callFunction('mon_borrowersearch.jsp','MONTHMONIT')" 
                    			class="blackfont"> 
                    			<b>Monthly Monitoring Report</b></a>
                    		<%
					  			}
					  			else
					  			{
					  		%>
                    			<font   color="#999999"><b>Monthly Monitoring Report</b> </font>
                    		<%
					  			}
					  		%>
						</td>
					</tr>
					<%--<tr>
						<td>
							<%
                   				if(grpRights.charAt(14) == '1' || grpRights.charAt(15) == '1') 
                   				{
							%>
                    			<a href="javascript:callFunction('mon_printalllink.jsp','MONTHMONITREPORT')" 
                    			class="blackfont"> 
                    			<b>Print All</b></a>
                    		<%
					  			}
					  			else
					  			{
					  		%>
                    			<font   color="#999999"><b>Print All</b> 
                    		<%
					  			}
					  		%>
						</td>
					</tr>
					
					<tr>
						
              <td colspan="3"><a href="javascript:callFunction('mon_borrowersearch.jsp','MONITREVIEW')" 
                    			class="blackfont"> 
                    			<b>Term Loan - Review</b></a></td>
					</tr>
					<tr>
						
              <td colspan="3"><a href="javascript:callPageLink('mon_front_selectreport.jsp')" 
                    			class="blackfont"> 
                    			<b>Report</b></a>
								
								
			</td>
					</tr>
					--%>
					<tr>
      					<td>
        					<table width="10%" border="0" cellspacing="0" cellpadding="0" align="right" >
          						<tr align="center" bgcolor="#FFFFFF"> 
            						<td width="20%">
            						<input name="Help" type="button" class="btn" value="Close" onclick="gotoNavigation()"/>
						            </td>
          						</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<input type="hidden" name="hidBeanId" /> 
<input type="hidden" name="hidBeanMethod" value="" /> 
<input type="hidden" name="hidBeanGetMethod" value="" /> 
<input type="hidden" name="hidSourceUrl" value="" /> 
<input type="hidden" name="hidmontype" /> 
</form>
</BODY>
</HTML>
