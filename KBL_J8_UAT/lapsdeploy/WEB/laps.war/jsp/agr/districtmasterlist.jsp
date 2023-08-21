<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String pagename = Helper.correctNull((String)request.getParameter("pagename"));
ArrayList	v = (ArrayList) hshValues.get("vecRow");
if((v == null))
{
	v = new ArrayList();
}
%>
<html>
<title>LAPS: District Master </title>
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
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var statename = "<%=Helper.correctNull((String)hshValues.get("statename "))%>";	
var pagename = "<%=pagename%>";	
function getSelectedValue(val1, val2, val3,val4,val5)
{
	if(from_link == "DistrictMaster")
	{
		window.opener.document.forms[0].hidsno.value = val2;
		window.opener.document.forms[0].sel_state.value = val1;
		window.opener.document.forms[0].txt_district.value = val4;
		window.opener.document.forms[0].txt_districtcode.value = val3;
		if(pagename!='scalefinancemaster') {	
		window.opener.document.forms[0].sel_active.value = val5;	
		}
		else
		{
			window.opener.document.forms[0].hidsno.value = val3;
		}
		window.close();
	}	
	if(pagename=='scalefinancemaster') {
		window.opener.document.forms[0].hidsno.value="130";
		window.opener.document.forms[0].hidsno.value = val3;
		window.opener.document.forms[0].action=appURL+"controllerservlet";
		window.opener.document.forms[0].hidBeanId.value="staticdata";
		window.opener.document.forms[0].hidBeanGetMethod.value="getFinanceData";
		window.opener.document.forms[0].hidSourceUrl.value="/action/scalefinancemaster.jsp";		
		window.opener.document.forms[0].submit();
	}
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
                 	     <td width="25%">District Code</td>
                        <td width="75%">District Name</td>
                      </tr>
                    </table>
                  
              <div class="cellcontainer"> 
                <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
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
		                   align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                    <td width="74%" align="left" ><a href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>')" 
		                    align="center"><b><%=Helper.correctNull((String)g1.get(3))%></b></a></td>
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
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="strStatId" value="<%=Helper.correctNull((String)hshValues.get("strStatId"))%>">
</form>
</body>
</html>

