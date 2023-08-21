<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
%>
<html>
<title>LAPS ::: Valuers List</title>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
	
function onselect1()
{
	if (document.forms[0].selradio[0].checked==true)
	{
		document.forms[0].stype.value = document.forms[0].selradio[0].value
	}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
}
	
function searchData()
{
	if (trim(document.forms[0].txt_ser.value)=="")
	{
		alert("Enter Search Text");
		return;
	}	
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getValuerMasterList";
	document.forms[0].stype.value ="N" ;
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/valuerslist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, 
val14, val15, val16, val17, val18, val19, val20, val21, val22, val23, val24, val25, val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,val40)
{	
	window.opener.document.forms[0].txt_appraisernameid.value = val31;
		window.opener.document.forms[0].txt_appraisername.value = val3;
		
		window.close();
}
	function doClose()
	{
		window.close();
	}


	function callOnload(){
		  
           <%if(Helper.correctNull((String)request.getParameter("hidAppVal")).equalsIgnoreCase("J")){%>
           		document.all.idcbsrad.style.display="table-cell";
           <%}else{%>
          		 document.all.idcbsrad.style.display="none";
          		document.forms[0].rad[0].checked=true;
           <%}%>
        
	}

	function radioCheck(){
		 if(document.forms[0].rad[0].checked==false && document.forms[0].rad[1].checked==false ){
			 alert("Please Select Either Appraiser Name or CBSID");
			 return;
		 }
	}
		
</SCRIPT>
</head>
<body onload="callOnload()">
	<form name="productlisthelp" method="post" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td>Search By 
             
              
              
              <table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable" align="center">
              
              <tr> 
              <td><input type="radio" name="rad" onClick="" style="border-style: none" value="Name">&nbsp;Appraiser Name</td>
              <td id="idcbsrad"><input type="radio" name="rad" onClick="" style="border-style: none" value="CBSID">&nbsp;CBS ID</td>
                              
                      
                  <td width="20%" id="cell_appraisername1"> 
                    <input type="text" name="txt_ser" maxlength="50" size = "20" value="<%=strvalue%>" onKeyPress="notAllowSplChar()" 
                    onblur="radioCheck()">
                  </td>
                  
                  
                  <td width="20%" align = "center" > 
                    <input type=button  class="buttonStyle"  value="Search" name="search" tabindex="20" onClick="searchData()">
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                 	     <td width="15%">Sl. No.</td>
                 	     <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{%>
						<td width="15%">CBS ID</td>
						<%} %>
                 	     <td width="60%">Appraiser /Valuer Name</td>
               	  		 <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
						{%>
						<td width="20%">Category Code</td>
						<%} %>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<% 
 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
			String inside="N";
			int i=0;
				if(v!=null)
				{		
					
					int vecsize =v.size();
					for(int l=0;l<vecsize;l++)
					{			
						inside="Y";
						g1 = (ArrayList)v.get(l);
						if(strFromLink.equalsIgnoreCase("ValuersMaster"))
						{
						%>
		                  <tr class="datagrid">
		                    <td  width="15%">
		                    <%=l+1%>&nbsp;</td>
		                    <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{%>
						<td width="15%"><%=Helper.correctNull((String)g1.get(30))%></td>
						<%} %>
		                    <td width="60%" ><a href="javascript:getSelectedValue(
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(0))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(1))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(2))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(3))))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(4))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(5))))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(6))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(7))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(8))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(9))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(10))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(11))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(12))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(13))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(15))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(16))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(17))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(18))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(19))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(20))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(21))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(22))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(23))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(24))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(25))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(26))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(27))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(28))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(29))%>','<%=Helper.correctNull((String)g1.get(30))%>'
								,'<%=Helper.correctNull((String)g1.get(31))%>','<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>','<%=Helper.correctNull((String)g1.get(34))%>'
								,'<%=Helper.correctNull((String)g1.get(37))%>','<%=Helper.correctNull((String)g1.get(27))%>'
								,'<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>','<%=Helper.correctNull((String)g1.get(40))%>'
								
								)" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
						
							<% if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
							{%>
							<td width="20%"><%=Helper.correctNull((String)g1.get(33))%></td>
							<%} %>	
								
		                  </tr>
		                  <%
						}
						else
						{
							if(!Helper.correctNull((String)g1.get(19)).equalsIgnoreCase(""))
							{
						%>
							<tr class="datagrid">
		                    <td  width="15%">
		                    <%=++i%>&nbsp;</td>
		                         <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{ %>
						<td width="15%"><%=Helper.correctNull((String)g1.get(30))%></td>
						<%} %>
		                    <td width="60%" ><a href="javascript:getSelectedValue(
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(0))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(1))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(2))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(3))))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(4))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(5))))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(6))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(7))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(8))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(9))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(10))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(11))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(12))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(13))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(15))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(16))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(17))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(18))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(19))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(20))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(21))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(22))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(23))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(24))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(25))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(26))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(27))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(28))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(29))%>',
								'<%=Helper.correctNull((String)g1.get(30))%>','<%=Helper.correctNull((String)g1.get(31))%>',
								'<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>',
								'<%=Helper.correctNull((String)g1.get(34))%>','<%=Helper.correctNull((String)g1.get(37))%>','<%=Helper.correctNull((String)g1.get(27))%>'
								,'<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>','<%=Helper.correctNull((String)g1.get(40))%>')" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                
		                <% if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
							{%>
							<td width="20%"><%=Helper.correctNull((String)g1.get(33))%></td>
							<%} %>	
		                  </tr>
						<%
							}
						}
				     }
				}
					if (inside.equals("N"))
					{
						%>
					 <tr class="datagrid">
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
					
                      <tr valign="top" class="datagrid"> 
                    <td  colspan="2"width="15%" align="center"><b>No 
                      Data Found for the selected criteria</b>  
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
                      </tr>
                      <tr class="datagrid">
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>                 
                  <%}%>
                </table>
              </div>
        </table>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type ="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>">
<input type ="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>">
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="hidAppVal" value="<%=Helper.correctNull((String)request.getParameter("hidAppVal"))%>">
<input type="hidden" name="appraiser" value="<%=Helper.correctNull((String)hshValues.get("appraiser"))%>">

</form>
</body>
</html>

