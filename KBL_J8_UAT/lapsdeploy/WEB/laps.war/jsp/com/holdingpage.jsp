<% 
int tab=Integer.parseInt(request.getParameter("tab"));

%> 
<tr>
		<td>
			<table width="40%" border="0" cellspacing="3" cellpadding="2"> 
				<tr>
					
	<%if(tab==1){ %>
	<td width="50%" align="center" class="tabactive">
	<b>Holding levels</b>
	</td>
	<%}else { %>
	<td width="50%" align="center" class="tabinactive">
	<a href="JavaScript:gototab('comproposal','getDataComment','com_holdinglevels.jsp',5)"
						onMouseOut="window.status='';return true;" 
						onMouseOver="window.status='HOLDING LEVEL';return true;">
							<b>Holding level</b>
						</a>
					</td>
			    <%} if(tab==2){%>
			    <td width="50%" align="center" class="tabactive">
			    <b>Break Up of Non Current Asset</b>
			    </td>	
			    <%}else { %>
			    <td width="50%" align="center" class="tabinactive">
			    <a href="JavaScript:gototab2('comproposal','getBreakUpofNoncurrent','com_breakupofcurrent.jsp',2)"
			             onMouseOut="window.status='';return true;" 
						onMouseOver="window.status='Break Up of Non Current Asset';return true;">
			      <b>Break Up of Non Current Asset</b>
			      </a>
			    <%} %>	
			    </tr>
			    </table>