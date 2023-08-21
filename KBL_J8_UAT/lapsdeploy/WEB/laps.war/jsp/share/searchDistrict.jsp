<%@include file="../share/directives.jsp"%>
<%	
    String hidcitycontrol = Helper.correctNull((String)request.getParameter("hidcitycontrol"));
    String hidstatecontrol = Helper.correctNull((String)request.getParameter("hidstatecontrol"));
	String hidcitycodecontrol  = Helper.correctNull((String)request.getParameter("hidcitycodecontrol"));
	String hidstatecodecontrol = Helper.correctNull((String)request.getParameter("hidstatecodecontrol"));
	
	String hidzipcontrol = Helper.correctNull((String)request.getParameter("hidzipcontrol"));
	String hidzipvaildatorcontrol = Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol"));
	String rowindex=Helper.correctInt((String)hshValues.get("rowindex"));
%>
<html>
<head>
<title>City Search</title>
<SCRIPT LANGUAGE="JavaScript">
var state = "<%=Helper.correctNull((String)hshValues.get("strStatId"))%>";
var distflag = "<%=Helper.correctNull((String)hshValues.get("distflag"))%>";
var rowCount = "<%=Helper.correctInt((String)hshValues.get("rowCount"))%>";
var rowindex = "<%=rowindex%>";

function callSearch()
{
	varlen =document.forms[0].txt_distsearch.length;
	if(trim(document.forms[0].txt_distsearch.value)=="")
	{
	ShowAlert(121,'District Name');
	document.forms[0].txt_distsearch.focus();
	return;
	}		
	else
	{
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchDistrict.jsp?hidBeanGetMethod=getDistrictSearch&hidBeanId=mastapplicant&distdesc="+document.forms[0].txt_distsearch.value+"&code="+document.forms[0].distflag.value+"&statecode="+document.forms[0].state_id.value+"&rowindex="+rowindex+"&rowCount="+rowCount;
	var title = "District";
	var prop = "scrollbars=no,width=500,height=500";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 300) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
	}
}
function setValues(val1,val2)
{	
	if(distflag == "REG")
	{
	window.opener.document.forms[0].txtperapp_district.value = val2;
	window.opener.document.forms[0].hidperapp_dist.value = val1;	
	}
	if(distflag == "CORP")
	{
	window.opener.document.forms[0].txtperapp_permdistrict.value = val2;
	window.opener.document.forms[0].hidperapp_permdist.value = val1;
	}
	if(distflag == "ADM")
	{
	window.opener.document.forms[0].txtperapp_admindistrict.value = val2;
	window.opener.document.forms[0].hidperapp_admindist.value = val1;
	}
	if(distflag == "BRANCH")
	{
	window.opener.document.forms[0].comapp_dist.value = val2;
	window.opener.document.forms[0].hid_dist.value = val1;
	}
	if(distflag == "SISTER")
	{
	window.opener.document.forms[0].comapp_div_dist.value = val2;
	window.opener.document.forms[0].hid_dist.value = val1;
	}
	if(distflag == "INWARD")
	{
	window.opener.document.forms[0].txt_comndist.value = val2;
	window.opener.document.forms[0].hid_dist.value = val1;
	}
	if(distflag == "MIS" || distflag == "PROP")
	{
	window.opener.document.forms[0].txt_District.value = val2;
	window.opener.document.forms[0].hid_District.value = val1;
	}
	if(distflag =="SOL")
	{
	window.opener.document.forms[0].txt_district.value = val2;
	window.opener.document.forms[0].hidperapp_permstate.value = val1;	
	}
	if(distflag == "ORGANISATION")
	{
	window.opener.document.forms[0].txtorg_district.value = val2;
	window.opener.document.forms[0].hid_district.value = val1;
	}
	if(distflag == "VEH")
	{
		window.opener.document.forms[0].txt_district.value = val2;
		window.opener.document.forms[0].hid_district.value = val1;
	}
	if(distflag == "VEH1")
	{
		window.opener.document.forms[0].txt_dealerdistrict.value = val2;
		window.opener.document.forms[0].hid_dealerdistrict.value = val1;
	}
	if(distflag == "MACH")
	{
		window.opener.document.forms[0].txt_dealerdistrict.value = val2;
		window.opener.document.forms[0].hid_dealerdistrict.value = val1;
	}
	if(distflag == "MACH1" || distflag == "FURN")
	{
		window.opener.document.forms[0].txt_locationdistrict.value = val2;
		window.opener.document.forms[0].hid_locationdistrict.value = val1;
	}
	if(distflag == "ValuerMaster")
	{
		if(rowCount==1)
		{
			window.opener.document.forms[0].txt_district.value = val2+"-"+val1;
			window.opener.document.forms[0].txt_districtcode.value = val1;
		}
		else
		{
			for(var i=0;i<rowCount;i++)
			{
				if(window.opener.document.forms[0].txt_districtcode[i].value==val1 && window.opener.document.forms[0].txt_district[i].value==val2)
				{
					alert("District already exist");
					return;
				}
			}
			window.opener.document.forms[0].txt_district[<%=rowindex%>].value = val2+"-"+val1;
			window.opener.document.forms[0].txt_districtcode[<%=rowindex%>].value = val1;
		}
		
	}
	if(distflag == "perhou")
	{
		window.opener.document.forms[0].txt_addr_district.value = val2;
		window.opener.document.forms[0].hid_dist.value = val1;
		window.opener.document.forms[0].txt_addr_town.value = "";
		window.opener.document.forms[0].hidtown.value = "";
	}
	if(distflag == "livestock")
	{
		window.opener.document.forms[0].txt_addr_district.value = val2;
		window.opener.document.forms[0].hid_dist.value = val1;
	}
	if(distflag == "per_dev")
	{
		window.opener.document.forms[0].txt_appl_district.value = val2;
		window.opener.document.forms[0].hid_dist.value = val1;
	}
	if(distflag == "crop")
	{
		window.opener.document.forms[0].txt_cropdistrict.value = val2;
		window.opener.document.forms[0].hid_cropdistrict.value = val1;
	}
	if(distflag == "stock")
	{
		window.opener.document.forms[0].txt_district.value = val2;
		window.opener.document.forms[0].hid_district.value = val1;
	}
	if(distflag == "svanidhi")
	{
		window.opener.document.forms[0].txt_DistrictDesc.value = val2;
		window.opener.document.forms[0].txt_District.value = val1;
	}
	if(distflag == "BANKER")
	{
		window.opener.document.forms[0].txt_benfDistrict.value = val2;
		window.opener.document.forms[0].hid_District.value = val1;
	}
	 window.close();
}

function callonLoad()
{
	var val=document.forms[0].state_id.value;
	if(val!="")
	{
		//document.forms[0].sel_state.value=val;
	}
}

function doClose()
{
 	window.close();
} 
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="1"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable linebor">
							
							<tr >
								<td  colspan="2"><b>Enter District Name</b></td>
								<td><input type="text" value="" name="txt_distsearch" size="15" maxlength="5"> &nbsp;
								<input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch()">
								</td>

							</tr>
							
							<tr class="dataheader">
								<td width="10%" ><b>S.No</b></td>
								<td width="25%"><b>District Code</b></td>
								<td width="65%"><b>District Name</b></td>

							</tr>
						</table>
						</td>
					</tr>
					<tr>
					<tr>
					<td>

						<table width="100%" border="0" cellspacing="1" cellpadding="2"
							class="outertable linebor">
						<%	
						ArrayList arrDistRow=new ArrayList();
						ArrayList arrDistCol=new ArrayList();
						if(hshValues!=null)
						{
							arrDistRow = (ArrayList)hshValues.get("arrCust");
						}												
						
						if (arrDistRow != null && arrDistRow.size() > 0)							
						{
						for (int i = 0; i < arrDistRow.size(); i++) 
						{
							arrDistCol = (ArrayList) arrDistRow.get(i);
						%>
							<tr class="datagrid">

								<td width="10%"><%=i+1%></td>
								<td width="25%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrDistCol.get(0))%>','<%= Helper.correctNull((String)arrDistCol.get(1))%>')"><%= Helper.correctNull((String)arrDistCol.get(0))%></a></td>
								<td width="65%">
								<a href="javascript:setValues('<%= Helper.correctNull((String)arrDistCol.get(0))%>','<%= Helper.correctNull((String)arrDistCol.get(1))%>')"><%= Helper.correctNull((String)arrDistCol.get(1))%></a></td>



							</tr>
							<% 		  
                                    	  }
                                    	  
                                      } else {
                                      
                                   %>
                                   <tr class="datagrid">

								<td colspan="7" align="center"> No Data Found</td>
							</tr>
                                   
                                   <%} %>
                                   
							
						</table>
						</td>
						</tr>
						<tr>
						<td>
						<table width="10%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr valign="top">
								<td width="20%"><lapschoice:combuttonnew
									btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
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
</table>


<input type="hidden" name="hidcitycontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycontrol")) %>">
<input type="hidden" name="hidstatecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecontrol")) %>">

<input type="hidden" name="hidcitycodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidcitycodecontrol")) %>">
<input type="hidden" name="hidstatecodecontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidstatecodecontrol")) %>">

<input type="hidden" name="hidzipcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipcontrol")) %>">
<input type="hidden" name="hidzipvaildatorcontrol"
	value="<%=Helper.correctNull((String)request.getParameter("hidzipvaildatorcontrol")) %>">
<input type="hidden" name="hidzipdiffcode" value="">
<input type="hidden" name="hidstatuscode" value="">	
<input type="hidden" name="distflag" value="<%=Helper.correctNull((String)request.getParameter("code"))%>">



<lapschoice:hiddentag /> <input type="hidden" name="state_id"
	value="<%=Helper.correctNull((String)hshValues.get("statecode"))%>">


<br>
</form>
</body>
</html>
