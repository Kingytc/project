<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
%>
<html>
<title>LAPS: BuilderNameList</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var cat="";	
function onselect1()
{
	if (document.forms[0].selradio[0].checked==true)
	{
		document.forms[0].stype.value = document.forms[0].selradio[0].value;
	}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
}
	
function searchData()
{

	if(document.forms[0].rad[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].rad[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	
	var txtval=document.forms[0].txt_ser.value;
	var txtlen=txtval.length;	
	if (cat==1 || cat==2)
	{
		if(txtlen<=2)
		{
			alert("Enter atleast 3 characters");
			document.forms[0].txt_ser.focus();
			return;
		}
	}
	else if(txtval=="")
	{
		alert("Enter Value to Search");
		document.forms[0].txt_ser.focus();
		return;
	}
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getBuilderMasterList";
	document.forms[0].stype.value ="N"; 
	document.forms[0].hidcat.value =cat;
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/builderslist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
	
function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val17, val18, val19, val20, val21, val22, val23, val24, val25,val26)
{	

	if(from_link == "BuilderMaster")
	{
	
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
		/*	window.opener.document.forms[0].hidsno.value = "";
			window.opener.document.forms[0].txt_name.value="";
			window.opener.document.forms[0].txt_address1.value="";
			window.opener.document.forms[0].txt_address2.value ="";
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
			window.opener.document.forms[0].txt_contactmobilephone.value ="";
			window.opener.document.forms[0].txt_desig.value = "";		
			window.opener.document.forms[0].txt_emailid.value = "";	
			window.opener.document.forms[0].txt_reputedstatus.value = "";
			window.opener.document.forms[0].txt_action.value = "";		
			window.opener.document.forms[0].txt_comments.value = "";
			window.opener.document.forms[0].txt_desig1.value = "";
			window.opener.document.forms[0].sel_blacklist.value = "";
			window.opener.document.forms[0].txt_blacklistdate.value = "";
			return;*/
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].hidmastid.value = val2;
			window.opener.document.forms[0].txt_name.value=val3
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
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
			window.opener.document.forms[0].txt_reputedstatus.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			window.opener.document.forms[0].txt_projectName.value = val26;
			 
			//window.opener.document.forms[0].txt_blacklistdate.value = val23;
		    
			if(val22=="N")
				{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
				}
			else
				{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
				}
				window.opener.document.forms[0].hidcity.value = val7;
				window.opener.document.forms[0].hidstate.value = val8;	
			
			
			if(window.opener.document.frmbuildermast.sel_blacklist.value=="Y")
	         {
				window.opener.document.all.t1.style.visibility="Visible";
				window.opener.document.all.t2.style.visibility="Visible";	
				if(window.opener.document.frmbuildermast.txt_blacklistdate.value=="01/01/1900")
				{
				window.opener.document.frmbuildermast.txt_blacklistdate.value="";
				}
	         }
	        
			else if(window.opener.document.frmbuildermast.sel_blacklist.value=="N")
			{
			
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";			
			}
        	 window.opener.enableButtons(true, true, true, true,true);
			
			window.close();
		}
		else
		{	
			window.opener.document.forms[0].org_code.value = val1;
			window.opener.document.forms[0].hidExorgcode.value = val1;	
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].hidmastid.value = val2;
			window.opener.document.forms[0].txt_name.value=val3
			window.opener.document.forms[0].txt_address1.value=val4;
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
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
			window.opener.document.forms[0].txt_reputedstatus.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			window.opener.document.forms[0].txt_blacklistdate.value = val23;
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;	
			window.opener.document.forms[0].txt_projectName.value = val26;
			
			if(val22=="N")
				{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
				}
			else
				{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
				}
			window.opener.enableButtons(true, false, true, true, false);
			window.close();
		}
	}
	else if(from_link == "House")
	{
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].txt_buildercode.value = "";
			window.opener.document.forms[0].prop_housingaddress.value = "";
			return;
		}
		else
		{			
			window.opener.document.forms[0].txt_buildercode.value = val2;
			window.opener.document.forms[0].prop_housingaddress.value=val3;
			window.close();
		}
	}
	else if(from_link == "sec_property")
	{
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].hid_buildercode.value = "";
			window.opener.document.forms[0].txt_BuilderName.value = "";
			window.opener.document.forms[0].txt_ProjectName.value = "";
			return;
		}
		else
		{			
			window.opener.document.forms[0].hid_buildercode.value = val2;
			window.opener.document.forms[0].txt_BuilderName.value = val3;
			window.opener.document.forms[0].txt_ProjectName.value = val26;
			window.close();
		}
	}

	
}
function doClose()
{
	window.close();
}
function doSelect()
{
	document.forms[0].txt_ser.value="";
	document.forms[0].txt_ser.focus();
}
function doReset()
{	document.forms[0].txt_ser.value="";
	document.forms[0].txt_ser.focus();
	document.forms[0].txt_ser.readOnly=false;
	document.all.txt_ser.src=appURL+'action/blank.jsp';
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
            <td><b>Search<br></b>
              <table border="0" cellspacing="0" cellpadding="2" width="100%" class="outertable linebor"  align="center">
                <tr>                  
                  <td width="10%" nowrap="nowrap"><input type="radio" name="rad" onClick="doSelect();" style="border-style: none" value="1">Builder Name</td>
                  <td width="10%" nowrap="nowrap"><input type="radio" name="rad" onClick="doSelect();" style="border-style: none" value="2">Project Name</td>
                  <td width="10%"> 
                    <input type="text" name="txt_ser" maxlength="40" size = "30" value="<%=strvalue%>" onClick="doReset()" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="7%" align = "center"> 
                    <input type=button   class="buttonStyle"  value="Search" name="search" tabindex="20" onClick="searchData()">
                  </td>
                  <td width="7%" align = "center"> 
                    <input type=button   class="buttonStyle"  value="Reset" name="cmdreset" tabindex="20" onClick="doReset()">
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                      <tr class="dataheader"> 
                 	     <td width="15%">Sl. No.</td>
                        <td width="85%">Builder Name</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
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
						if(strFromLink.equalsIgnoreCase("BuilderMaster"))
						{
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
								'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(20))))%>','<%=Helper.correctNull((String)g1.get(21))%>',
								'<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
								'<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>')" align="center"><b><%=Helper.correctNull((String)g1.get(2))%>&nbsp;</b></a></td>
		                  </tr>
		                  <%
						}
						else if(strFromLink.equalsIgnoreCase("sec_property"))
						{
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
									'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(20))))%>','<%=Helper.correctNull((String)g1.get(21))%>',
									'<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
									'<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>')" align="center"><b><%=Helper.correctNull((String)g1.get(2))%>&nbsp;--&nbsp;<%=Helper.correctNull((String)g1.get(25))%>&nbsp;,&nbsp;<%=Helper.correctNull((String)g1.get(23))%></b></a></td>
			                  </tr>
			                  <%
							}else{
								
							if(Helper.correctNull((String)g1.get(19)).equalsIgnoreCase("1"))
							{
								%>
									 <tr valign="top" class="datagrid">
				                    <td  width="15%" align="left">
				                    <%=++i%>&nbsp;</td>
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
										'<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
										'<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>')"  align="center"><b><%=Helper.correctNull((String)g1.get(2))%>&nbsp;</b></a></td>
				                  </tr>
								<%
							}
						}
				     }
				}
					%>
					
                      <%if (inside.equals("N"))
						{
						%>
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
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="hidcat" value="">
</form>
</body>
</html>

