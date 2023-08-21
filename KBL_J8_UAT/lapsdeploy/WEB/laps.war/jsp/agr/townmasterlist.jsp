<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
ArrayList	v = (ArrayList) hshValues.get("vecRow");
if((v == null))
{
	v = new ArrayList();
}
%>
<html>
<title>LAPS: Town Master </title>
<head><style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var appUrl="<%=ApplicationParams.getAppUrl()%>";

function getSelectedValue(val1, val2, val3,val4,val5)
{	
	if(document.forms[0].distflag.value == "per_house")
	{
		window.opener.document.forms[0].txt_addr_town.value = val3;
		window.opener.document.forms[0].hidtown.value = val2;
	}
	else{
		window.opener.document.forms[0].txt_town.value = val3;
		window.opener.document.forms[0].txt_towncode.value = val2;
		window.opener.document.forms[0].hidtownid.value = val4;
		window.opener.document.forms[0].sel_active.value = val5;
		window.opener.document.forms[0].cmdnew.disabled =true;
		window.opener.document.forms[0].cmdedit.disabled=false;
		window.opener.document.forms[0].cmdsave.disabled=true;
		window.opener.document.forms[0].cmdcancel.disabled=false;
		window.opener.document.forms[0].cmdclose.disabled=false;
	}
	window.close();
}	
function doClose()
{
	window.close();
}
</SCRIPT>
</head>
<body>
	<form name="districtlisthelp" method="post" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td>
         
              
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                      <tr class="dataheader"> 
                 	     <td width="25%">Town Code</td>
                        <td width="75%">Town Name</td>
                      </tr>
                    </table>
                  
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<% 
 				
			if(v.size()!=0){
				v = (ArrayList) hshValues.get("vecRow");
              
				if(v.size()!=0)
				{
							
					int vecsize =v.size();
					for(int l=0;l<vecsize;l++)
					{							
						g1 = (ArrayList)v.get(l);
						%>
		                  <tr valign="top" class="datagrid">
		             		<td width="26%" align="left" ><a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>')" 
		                   align="center"><b><%=Helper.correctNull((String)g1.get(1))%></b></a></td>
		                    <td width="74%" align="left" ><a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>')" 
		                    align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                  </tr>
		                  <%
				          	}
						}
		                  	}
					%>
					<% 
 				v = (ArrayList) hshValues.get("vecRow");
				if((v==null)||(v.size()==0))
				{	
					
					 
						%>
                  
                  <tr valign="top" class="datagrid"> 
                    <td  colspan="2" width="15%" align="center"><b>No 
                      Data Found for the selected criteria</b>  
                  </tr>
                  <%
				
				}%>
					 <!-- <tr class="datagrid">
                        <td width="15%">&nbsp;</td>
                        <td width="85%">&nbsp;</td>
                      </tr>
					   <tr class="datagrid">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					   <tr class="datagrid">
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
					   <tr class="datagrid">
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>
					<tr class="datagrid">
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr> -->
                </table>
              </div>
        </table>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="strdistId" value="<%=Helper.correctNull((String)hshValues.get("strdistId"))%>">
<input type="hidden" name="distflag" value="<%=Helper.correctNull((String)request.getParameter("code"))%>">

</form>
</body>
</html>

