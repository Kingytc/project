<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
%>
<html>
<title>Company Master</title>
<head><style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
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
	if(trim(document.forms[0].txt_ser.value)=="")
		{
		ShowAlert(121,'Search Name');
		document.forms[0].txt_ser.focus();
		return;
		}
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getCompanyMasterList";
	document.forms[0].stype.value ="N"; 
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/companymastlist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val17, val18, val19, val20, val21, val22, val23)
{	
           
	if(from_link == "CompanyMaster")
	{
		if( val20=="Y")
		{ 
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;
		/*	window.opener.document.forms[0].hidsno.value ="";
			window.opener.document.forms[0].txt_name.value="";
			window.opener.document.forms[0].txt_address1.value="";
			window.opener.document.forms[0].txt_address2.value = "";	
			window.opener.document.forms[0].txt_address3.value = "";		
			window.opener.document.forms[0].txt_city.value = "";
			window.opener.document.forms[0].txt_state.value = "";
			window.opener.document.forms[0].txt_zip.value = "";
			window.opener.document.forms[0].txt_country.value = "";
			window.opener.document.forms[0].txt_offphone.value = "";	
			window.opener.document.forms[0].txt_offfaxno.value = "";
			window.opener.document.forms[0].txt_resphone.value = "";
			window.opener.document.forms[0].txt_resmobileno.value = "";
			window.opener.document.forms[0].txt_contactperson.value = "";
			window.opener.document.forms[0].txt_contactmobilephone.value = "";
			window.opener.document.forms[0].txt_desig.value = "";		
			window.opener.document.forms[0].txt_emailid.value = "";
			window.opener.document.forms[0].txt_comments.value = "";
			window.opener.document.forms[0].sel_blacklist.value = "";
			window.opener.document.forms[0].txt_blacklistdate.value = "";	
			window.opener.document.forms[0].txt_desig1.value = "";
			return;*/
			window.opener.document.forms[0].hidsno.value = val2;
			
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
			//window.opener.document.forms[0].txt_desig.value = val17;		
			window.opener.document.forms[0].txt_emailid.value = val18;	
			window.opener.document.forms[0].txt_comments.value = val19;
			window.opener.document.forms[0].sel_blacklist.value = val20;
			window.opener.document.forms[0].txt_blacklistdate.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].txt_city.value = val22;	
			window.opener.document.forms[0].txt_state.value = val23;
			window.opener.enableButtons(true,true,true,true,true);	
			if(window.opener.document.forms[0].sel_blacklist.value=="Y")
	      {
		window.opener.document.all.t1.style.visibility="Visible";
		window.opener.document.all.t2.style.visibility="Visible";	
		if(window.opener.document.forms[0].txt_blacklistdate.value=="01/01/1900")
			{
			window.opener.document.forms[0].txt_blacklistdate.value="";
			val21="";
			window.opener.document.all.t1.style.visibility="hidden";	
	    	window.opener.document.all.t2.style.visibility="hidden";
			}	
	}
	else if(window.opener.document.forms[0].sel_blacklist.value=="N")
	{
		window.opener.document.all.t1.style.visibility="hidden";	
		window.opener.document.all.t2.style.visibility="hidden";			
	}	
			window.close();
		}
		else
		{	
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;
			window.opener.document.forms[0].hidsno.value = val2;
			
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
		//	window.opener.document.forms[0].txt_desig.value = val17;		
			window.opener.document.forms[0].txt_emailid.value = val18;	
			window.opener.document.forms[0].txt_comments.value = val19;
			window.opener.document.forms[0].sel_blacklist.value = val20;
			//window.opener.document.forms[0].txt_blacklistdate.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].txt_city.value = val22;	
			window.opener.document.forms[0].txt_state.value = val23;
			if(val20=="N")
				{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
				}
			else
				{
				window.opener.document.forms[0].txt_blacklistdate.value = val21;		
				}
			window.opener.enableButtons(true,false,true,true,false);		
			window.close();
		}
	}
	else if(from_link == "CompanyMaster1")
	{	
		if( val20=="Y")
		{	
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].txtperemp_name.value="";
			window.opener.document.forms[0].txtperemp_address1.value="";
			window.opener.document.forms[0].txtperemp_address2.value="";
			window.opener.document.forms[0].txtperemp_address3.value="";
			window.opener.document.forms[0].txtperemp_city.value="";	
			//window.opener.document.forms[0].txtperemp_country.value="";
			window.opener.document.forms[0].txtperemp_state.value="";	
			window.opener.document.forms[0].txtperemp_zip.value="";
			window.opener.document.forms[0].txtperemp_phone.value="";
			window.opener.document.forms[0].txtperemp_fax.value="";
			window.opener.document.forms[0].txtperemp_email.value="";
			window.opener.document.forms[0].hidcity.value="";	
			window.opener.document.forms[0].hidstate.value="";	
			return;
		}
		else
		{			
			window.opener.document.forms[0].txtperemp_name.value=val3;
			window.opener.document.forms[0].txtperemp_address1.value=val4;
			window.opener.document.forms[0].txtperemp_address2.value=val5;
			window.opener.document.forms[0].txtperemp_address3.value=val6;
			window.opener.document.forms[0].txtperemp_city.value=val22;	
			//window.opener.document.forms[0].txtperemp_country.value=val10;
			window.opener.document.forms[0].txtperemp_state.value=val23;	
			window.opener.document.forms[0].txtperemp_zip.value=val9;
			window.opener.document.forms[0].txtperemp_phone.value=val11;
			window.opener.document.forms[0].txtperemp_fax.value=val12;
			window.opener.document.forms[0].txtperemp_email.value=val18;
			window.opener.document.forms[0].hidcity.value=val7;	
			window.opener.document.forms[0].hidstate.value=val8;	
			
			window.close();
		}		
	}
}
function doClose()
{
	window.close();
}
</SCRIPT>
</head>
<body>
	<form name="CompanyMaster" method="post" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td><b>Search By 
              <br>
              </b>
              <table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable" align="center">
                <tr>                  
                  <td width="20%">Company Name</td>
                  <td width="20%"> 
                    <input type="text" name="txt_ser" maxlength="50" size = "20"  tabindex="1" value="<%=strvalue%>" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="20%" align = "center"> 
                    <input type=button  class="buttonStyle"  value="Search" name="search" tabindex="20" onClick="searchData()">
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="97%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                 	     <td width="15%">Sl. No.</td>
                         <td width="85%">Company Name</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<% 
 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
			
			String inside="N";
				if(v!=null)
				{					
					int vecsize =v.size();
					for(int l=0;l<vecsize;l++)
					{	inside="Y";						
						g1 = (ArrayList)v.get(l);
						%>
		                  <tr valign="top" class="datagrid">
		                    <td  width="15%" align="left">
		                    <%=l+1%>&nbsp;</td>
		                    <td width="85%" align="left" ><a href="javascript:getSelectedValue(
		                    		'<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
		                    		'<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>',
		                    		'<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>',
		                    		'<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>',
		                    		'<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
		                    		'<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
		                    		'<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
		                    		'<%=Helper.correctNull((String)g1.get(14))%>','<%=Helper.correctNull((String)g1.get(15))%>',
		                    		'<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
		                    		'<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
		                    		'<%=Helper.correctNull((String)g1.get(20))%>','<%=Helper.correctNull((String)g1.get(21))%>',
		                    		'<%=Helper.correctNull((String)g1.get(22))%>','<%//=Helper.correctNull((String)g1.get(23))%>')" class="blackfont" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                  </tr>
		                  <%
				          	}
						}
					 if (inside.equals("N"))
					{
						%>
					 <tr class="datagrid">
                        <td width="15%">&nbsp;</td>
                        <td width="73%">&nbsp;</td>
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
<lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type ="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>">
<input type ="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>">
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>