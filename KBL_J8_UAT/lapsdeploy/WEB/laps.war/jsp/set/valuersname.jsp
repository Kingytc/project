<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
String strsecuritytype = Helper.correctNull((String)request.getParameter("strsecuritytype"));
String rowcount = Helper.correctInt((String)request.getParameter("rowcount"));
String rowindex = Helper.correctInt((String)request.getParameter("rowindex"));
String fieldtype = Helper.correctNull((String)request.getParameter("fieldtype"));
String valuernametemp = Helper.correctNull((String)request.getParameter("valuernametemp"));

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
var strsecuritytype="<%=strsecuritytype%>";
var fieldtype="<%=fieldtype%>";
var rowcount="<%=rowcount%>";
var valuernametemp="<%=valuernametemp%>";

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
	document.forms[0].stype.value ="Name" ;
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/valuersname.jsp?strsecuritytype="+strsecuritytype;
	document.forms[0].method="post";
	document.forms[0].submit();
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, 
val14, val15, val16, val17, val18, val19, val20, val21, val22, val23, val24, val25, val26,val32,val33,val34,val35,val36,val37,val38)
{
	if(eval(val36)<=90)
	{
		alert("Valuer empanelment is expiring on "+val37+". Kindly renew the same within the due date.");
	}
	if(valuernametemp.indexOf(val3)!=-1)
	{
		alert("The selected Valuer is already attached to the Security !");
		return;
	}
	if(val34=="N")
	{
		alert("The Valuer cannot Valuate this property.Maximum Valuation Limit of this borrower is "+val35);
		return;
	}
		if(fieldtype=="valuerlist")
		{
			if(rowcount==1)
			{
				window.opener.document.forms[0].txt_Valuers_name_mul.value=val3;
				window.opener.document.forms[0].txt_Valuers_code_mul.value=val2;
				window.opener.document.forms[0].txt_Valuers_limit_mul.value=val35;
				window.opener.document.forms[0].txt_Valuers_catcode_mul.value=val33;
				window.opener.document.forms[0].txt_Valuationloc_mul.value=val38;
			}
			else
			{
				window.opener.document.forms[0].txt_Valuers_name_mul[<%=rowindex%>].value=val3;
				window.opener.document.forms[0].txt_Valuers_code_mul[<%=rowindex%>].value=val2;
				window.opener.document.forms[0].txt_Valuers_limit_mul[<%=rowindex%>].value=val35;
				window.opener.document.forms[0].txt_Valuers_catcode_mul[<%=rowindex%>].value=val33;
				window.opener.document.forms[0].txt_Valuationloc_mul[<%=rowindex%>].value=val38;
			}
		}
		else
		{
			window.opener.document.forms[0].sel_currentEmpList.value=val20;
			window.opener.document.forms[0].txt_val_catCode.value=val33;
			window.opener.document.forms[0].txt_Valuers_name.value=val3;
			window.opener.document.forms[0].txt_Valuers_code.value=val2;
			window.opener.document.forms[0].txt_Valuers_limit.value=val35;
			window.opener.document.forms[0].hidvaluationarea.value=val38;

			window.opener.captureComments();
			window.opener.CallvaluerCheck();
			window.opener.govtValuerCheck();
			
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
	<form name="productlisthelp" method="post" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td>
              <table align="center" width="40%" border="0">
              	<tr align="center">
              		<td><input type="text" name="txt_ser" size="15" onKeyPress="allowAlphabetsForName()"></td>
              		<td><input type="button" name="search" value="Search by Name" class="buttonStyle" onClick="searchData()" ></td>
              	</tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                 	     <td width="15%">Sl. No.</td>
                 	     <td width="60%">Valuer Name</td>
                 	     <td width="20%">Category Code</td>
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
						
						if(strFromLink.equalsIgnoreCase("Securities"))
						{
							boolean sectypeflag=false;
							String[] valNature=Helper.correctNull((String)g1.get(32)).split("@");
							for(int j=0;j<valNature.length;j++)
							{
								if(valNature[j].equals(strsecuritytype))
								{
									sectypeflag=true;
								}
							}
							if(sectypeflag)
							{
						%>
		                  <tr class="datagrid">
		                    <td  width="15%">
		                    <%=l+1%>&nbsp;</td>
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
								'<%=Helper.replaceForJavaScriptString((String)g1.get(24))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(25))%>','<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>','<%=Helper.correctNull((String)g1.get(35))%>','<%=Helper.correctNull((String)g1.get(36))%>'
								,'<%=Helper.correctNull((String)g1.get(37))%>','<%=Helper.correctNull((String)g1.get(27))%>','<%=Helper.correctNull((String)g1.get(34))%>')" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                   <td  width="20%"> <%=Helper.correctNull((String)g1.get(33))%>&nbsp;</td>
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
                  <%
				}%>
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

</form>
</body>
</html>

