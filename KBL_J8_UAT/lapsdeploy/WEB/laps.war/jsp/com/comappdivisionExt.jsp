<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
ArrayList vecRow= new ArrayList();
ArrayList vecCol= new ArrayList();
vecRow =(ArrayList)hshValues.get("vecRow");
String existing=request.getParameter("exist");
%>
<html>
<head>
<title>Division Details</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callLink(page,bean,method)
{
	 document.forms[0].hidBeanGetMethod.value="getData";
	 document.forms[0].hidBeanId.value="comgroup";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		window.close();
	}
}

function selectValues(id,name,address,city,state,pin,ph,fax,divtype)
{
	document.forms[0].comapp_div_id.value=id;
	document.forms[0].comapp_div_name.value=name;
	document.forms[0].comapp_div_address.value=address;
	document.forms[0].comapp_div_city.value=city;
	document.forms[0].comapp_div_state.value=state;
	document.forms[0].comapp_div_pin.value=pin;
	document.forms[0].comapp_div_phone.value=ph;
	document.forms[0].comapp_div_fax.value=fax;	
	document.forms[0].comapp_divisiontype.value=divtype;	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}

function onloading()
{	  
  	disableFields(true);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Commercial(Applicant Master) -&gt;
		Customer Master Details -&gt; Company Details -&gt; Division Details</td>
	</tr>	
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top">      
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">                      
                            <tr> 
                              <td  width="14%" nowrap>Division Name<span class="mantatory"><b>*</b></span></td>
                              <td  width="20%"> 
                                <input type="text" name="comapp_div_name" size="25" maxlength="75"  style= text-align:left;border-style=groove>
                              </td>
                              <td width="10%" >Address</td>
                              <td width="24%" > 
                                <textarea name="comapp_div_address" cols="25" rows="2"  style= text-align:left;border-style=groove onKeyPress="formattext();textlimit(this,999)" onKeyUp="textlimit(this,999)"
                                     wrap="VIRTUAL">                                
                                </textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="11%">City</td>
                              <td width="21%"> 
                                <input type="text" name="comapp_div_city" size="20" maxlength="100"  style= text-align:left;border-style=groove onKeyPress="formattext()">
                              </td>
                              <td width="14%">State</td>
                              <td width="20%"> 
                                <input type="text" name="comapp_div_state" size="20" maxlength="50"  style= text-align:left;border-style=groove onKeyPress="formattext()">
                              </td>
                              <td width="10%">Pincode</td>
                              <td width="24%"> 
                                <input type="text" name="comapp_div_pin" size="25" maxlength="6"  style= text-align:left;border-style=groove onKeyPress="allowInteger()">
                              </td>
                            </tr>
                            <tr> 
                              <td width="11%">Phone No.</td>
                              <td width="21%"> 
                                <input type="text" name="comapp_div_phone" size="20" maxlength="20"  style= text-align:left;border-style=groove onKeyPress="allowInteger()">
                              </td>
                              <td width="14%">Fax</td>
                              <td width="20%"> 
                                <input type="text" name="comapp_div_fax" size="20" maxlength="20"  style= text-align:left;border-style=groove onKeyPress="allowInteger()">
                              </td>
                              <td width="10%">Division type<span class="mantatory">*</span></td>
                              <td width="24%">  
                                <select name="comapp_divisiontype" size="1"  tabindex="1">
                                  <option Selected value="">--Select--</option>
                                  <option value="Division concern">Division</option>
                                  <option value="Sister concern">Sister</option>
                                </select>
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
                      </table><br>
                      <lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
                      <br>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
                            <tr align="center" class="dataheader"> 
                              <td  width="5%">&nbsp;</td>
                              <td  width="17%">Division Name</td>
                              <td  width="17%">Division Type</td>
                              <td  width="25%">Address</td>
                              <td width="15%">City</td>
                              <td  width="15%">State</td>
                            </tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<%if(vecRow.size()>6){ %>
								<div class="cellContainer">
								<%} %>
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <% if(vecRow.size()>0)
                            {
                            	String temp="";
                            	for(int i=0;i<vecRow.size();i++)
                            	{
                            		vecCol =(ArrayList)vecRow.get(i);%>
                            <tr class="datagrid"> 
                              <td width="5%" align=center> 
                                <input type="radio"
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="javascript:selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
																					'<%=Helper.correctNull((String)vecCol.get(1))%>',
																					'<%=Helper.correctNull((String)vecCol.get(2))%>',
																					'<%=Helper.replaceForJavaScriptString((String)vecCol.get(3))%>',
																					'<%=Helper.correctNull((String)vecCol.get(4))%>',
																					'<%=Helper.correctNull((String)vecCol.get(5))%>',
													                            	'<%=Helper.correctNull((String)vecCol.get(6))%>',
													                            	'<%=Helper.correctNull((String)vecCol.get(7))%>',
													                            	'<%=Helper.correctNull((String)vecCol.get(8))%>',
													                            	'<%=Helper.correctNull((String)vecCol.get(9))%>')">
                                </td>
                              <td width="17%"> 
                                <b><%=Helper.correctNull((String)vecCol.get(1))%></b></td>
                              <td width="17%"><%=Helper.correctNull((String)vecCol.get(8))%></td>
                              <td width="25%"><%=Helper.correctNull((String)vecCol.get(2))%></td>
                              <td width="15%"><%=Helper.correctNull((String)vecCol.get(3))%></td>
                              <td width="15%"><%=Helper.correctNull((String)vecCol.get(4))%></td>
                            </tr>
                            <%}}else{%>
                            <tr class="datagrid"> 
                              <td align="center" colspan="6">No Data Found</td>
                            </tr>
                            <%}%>
                          </table>
                          <%if(vecRow.size()>6){ %></div><%} %>
                          </td>
                          </tr>
                          </table>
                          
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="comapp_sno" value="">
  <input type="hidden" name="comapp_id"  value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>">
  <input type="hidden" name="comapp_div_id" value="<%=Helper.correctNull((String)hshValues.get("comapp_div_id"))%>">

</form>
</body>
</html>
