<%@include file = "../share/directives.jsp"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList v1 = (ArrayList) hshValues.get("vecRow");
			ArrayList v = (ArrayList) hshValues.get("vecRow");
			String strFromLink = Helper.correctNull((String) request
					.getParameter("strfrom"));
			String strtxtid=Helper.correctNull((String) request
					.getParameter("txtid"));
			String size=Helper.correctNull((String) request
					.getParameter("size"));
					
		
			if ((v == null)) {
				v = new ArrayList();
			}
			if (v1 == null) {
				v1 = new ArrayList();
			}
			ArrayList vecRow1 = (ArrayList) hshValues.get("vecRow1");
			if ((vecRow1 == null)) {
				vecRow1 = new ArrayList();
			}
			ArrayList arrCol = new ArrayList();
			if (arrCol == null) {
				arrCol = new ArrayList();
			}
			String strappno = Helper.correctNull((String) request.getParameter("strappno"));
		%>
<html>
<title>LAPS: Finance Master</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var vartxtid = "<%=strtxtid%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var state = "<%=Helper.correctNull((String)hshValues.get("strStatId"))%>";
var districtid = "<%=Helper.correctNull((String)hshValues.get("hidslno"))%>";
var size="<%=size%>";
function callonload()
{
	if(state!="")
	{
		document.forms[0].sel_state.value=state;
	}
	else
	{
		document.forms[0].sel_state.value="s";
	}
	if(districtid!="")
	{
		document.forms[0].sel_district.value=districtid;
	}
	else
	{
		document.forms[0].sel_district.value=0;
	}
}

function callDistrict()
{
	document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	document.forms[0].hidBeanId.value="staticdata";
    document.forms[0].hidBeanGetMethod.value="getDistrictMasterList1";
	document.forms[0].action=appUrl+"action/scalefinancemasterlist.jsp";
	document.forms[0].submit();
}

function doSearch()
{
    document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanGetMethod.value="getFinancemasterData";
	document.forms[0].action=appUrl+"action/scalefinancemasterlist.jsp?strAssessment=130";
	document.forms[0].submit();
}

function showDistrict()
{
	var action=document.forms[0].hidAction.value;
	document.forms[0].strStatId1.value=document.forms[0].sel_state.value;
	var prop = "scrollbars=no,width=300,height=400,top=100,left=550";
	var url=appUrl+"action/districtmasterlist.jsp?&strStatId="+document.forms[0].strStatId1.value+"&hidBeanId=staticdata&hidBeanGetMethod=getDistrictMasterList&strfrom=DistrictMaster";
	window.open(url,"",prop);	
}	
function callEligibility()
{
var totval1=0.00;
var totval2=0.00;
for(var i=0;i<=20;i++)
	{
        var val1 =  document.forms[0].txt_area[i].value;
		var val2=document.forms[0].txt_finance[i].value;
		if(val1=="")
		{
			val1=0.00;
		}
		if(val2=="")
		{
			val2=0.00;
		}
		totalval1 = eval(val1)+eval(totval1);
		totalval2= eval(val2)+eval(totval2);
		var totval3=0.00;
		totval3=(totalval1) * (totalval2);
		document.forms[0].txt_eligibility[i].value= totval3;
	}
	
	
}
function getSelectedValue(val1, val2, val3,val4,val5,season,crop,scaleoffin)
{	
	var stateIndex=0;
	var districtIndex=0;
	season=season;
	if(from_link == "DistrictMaster")
	{		

			window.opener.document.forms[0].txt_amount.value = val4;	
			window.opener.document.forms[0].txt_amount.readOnly=true;
			
		for (i=0;i<document.forms[0].elements.length;i++){
			if(document.forms[0].elements[i].name=="sel_state") {
				stateIndex=document.forms[0].elements[i].selectedIndex;
			}

			if(document.forms[0].elements[i].name=="sel_district") {
				districtIndex=document.forms[0].elements[i].selectedIndex;
			}
			
		}

		window.opener.document.forms[0].txt_state.value = document.forms[0].sel_state.options[stateIndex].text;
		window.opener.document.forms[0].txt_district.value =document.forms[0].sel_district.options[districtIndex].text;	
		

		window.opener.document.forms[0].txt_season.value = season;
		window.opener.document.forms[0].txt_crop.value =crop;	
		window.opener.document.forms[0].txt_scloffin.value =scaleoffin;
		window.opener.document.forms[0].txt_season.readOnly = true;
		window.opener.document.forms[0].txt_crop.readOnly =true;
				
		window.close();
	}

	if(from_link == "Nursery")
	{		
		
			window.opener.document.forms[0].txt_amount.value = val4;	
			window.opener.document.forms[0].txt_amount.readOnly=true;
				

		for (i=0;i<document.forms[0].elements.length;i++){
			if(document.forms[0].elements[i].name=="sel_state") {
				stateIndex=document.forms[0].elements[i].selectedIndex;
			}

			if(document.forms[0].elements[i].name=="sel_district") {
				districtIndex=document.forms[0].elements[i].selectedIndex;
			}
			
		}

		window.opener.document.forms[0].txt_state.value = document.forms[0].sel_state.options[stateIndex].text;
		window.opener.document.forms[0].txt_district.value =document.forms[0].sel_district.options[districtIndex].text;	

		window.opener.document.forms[0].txt_season.value = season;
		window.opener.document.forms[0].txt_season.readOnly = true;
		
		window.close();
	}
	
	if(from_link == "DistrictMaster1")
	{		
		window.opener.document.forms[0].txt_finance[1].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster2")
	{		
		window.opener.document.forms[0].txt_finance[2].value = val4;	
		window.close();
	}	
	
	
	if(from_link == "DistrictMaster6")
	{		
		window.opener.document.forms[0].txt_finance[3].value = val4;	
		window.close();
	}	
	if(from_link == "DistrictMaster7")
	{		
		window.opener.document.forms[0].txt_finance[4].value = val4;	
		window.close();
	}	
	if(from_link == "DistrictMaster8")
	{		
		window.opener.document.forms[0].txt_finance[5].value = val4;	
		window.close();
	}	
	
	if(from_link == "DistrictMaster12")
	{		
		window.opener.document.forms[0].txt_finance[6].value = val4;	
		window.close();
	}	
	if(from_link == "DistrictMaster13")
	{		
		window.opener.document.forms[0].txt_finance[7].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster14")
	{		
		window.opener.document.forms[0].txt_finance[8].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster15")
	{		
		window.opener.document.forms[0].txt_finance[9].value = val4;	
		window.close();
	}	
	if(from_link == "DistrictMaster16")
	{		
		window.opener.document.forms[0].txt_finance[10].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster17")
	{		
		window.opener.document.forms[0].txt_finance[11].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster18")
	{		
		window.opener.document.forms[0].txt_finance[12].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster19")
	{		
		window.opener.document.forms[0].txt_finance[13].value = val4;	
		window.close();
	}
	if(from_link == "DistrictMaster20")
	{		
		window.opener.document.forms[0].txt_finance[14].value = val4;	
		window.close();
	}	
	if(from_link == "District_Master")
	{		
		window.opener.document.forms[0].txt_bearingarbval.value = val4;	
		window.close();
	}	
	if(from_link == "District_Master1")
	{		
		window.opener.document.forms[0].txt_nonbearingarbval.value = val4;	
		window.close();
	}
	if(from_link == "District_Master2")
	{		
		window.opener.document.forms[0].txt_bearingrobval.value = val4;	
		window.close();
	}	
	if(from_link == "District_Master3")
	{		
		window.opener.document.forms[0].txt_nonbearingrobval.value = val4;	
		window.close();
	}
	if(from_link == "District_loanmasterreq")
	{		
		window.opener.document.forms[0].txt_finval.value = val4;	
		window.close();
	}


}
</SCRIPT>
</head>
<body onLoad="callonload()">
<form name="financelisthelp" method="post"  class="normal" ><br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"
	align="center">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr >
				<td>
				
              <table width="101%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
                <tr class="dataheader"> 
                  <td><b>State</b></td>
                  <td> 
                    <%if ((v != null) || (v.size() != 0)) {
				v1 = (ArrayList) hshValues.get("vecRow");

			%>
                    <select name="sel_state" style="width:130"
							onChange="callDistrict()">
                      <option value="s">--Select--</option>
                      <lapschoice:statemaster /> 
                    </select>
                    <%}

			%>
                  </td>
                  <td><b>District </b></td>
                  <td>
                    <select name="sel_district" style="width:200" onChange="">
                      <option value="0"><b>--Select--</b></option>
                      <%if ((vecRow1 != null) && (vecRow1.size() != 0)) {
				vecRow1 = (ArrayList) hshValues.get("vecRow1");
				arrCol = new ArrayList();

				for (int i = 0; i < vecRow1.size(); i++) {
					arrCol = (ArrayList) vecRow1.get(i);
					out.print("<option value=" + arrCol.get(1));
					out.print(">" + arrCol.get(2) + "</option>");
				}
			}

			%>
                    </select>
                  </td>
                  <td><b>
                    <input type="button"
							name="Search" value="Search" onClick="doSearch()">
                    </b> </td>
                </tr>
              </table>
				
              <b><br>
				</b>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
							<td class="" width="6%">Sl. No.</td>
								<td class="" width="16%">Crop Name</td>
								<td class="" width="37%">Scale of Finance
								Value</td>
								<td class="" width="18%">Type</td>
								<td class="" width="23%">Valid Upto</td>
							</tr>
							<tr >
							</tr>
						</table>
						</td>
					</tr>
				</table>
			
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%String inside = "N";
			if ((v != null) && (v.size() != 0)) {
				v = (ArrayList) hshValues.get("vecRow");
//out.println("v:"+v);
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
	<tr valign="top" class="datagrid">
						<td width="6%" align="left"><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(2))%>','<%=Helper.correctNull((String) g1.get(3))%>','<%=Helper.correctNull((String) g1.get(9))%>','<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="center"><%=l + 1%></a></td>
						<td width="16%" align="left" height="23"><b><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(2))%>','<%=Helper.correctNull((String) g1.get(3))%>','<%=Helper.correctNull((String) g1.get(9))%>','<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="center"><%=Helper.correctNull((String) g1.get(10))%></a></b></td>
						<td width="37%" align="right"><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(2))%>','<%=Helper.correctNull((String) g1.get(3))%>','<%=Helper.correctNull((String) g1.get(9))%>','<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="right">  <%=Helper.correctNull((String) g1.get(3))%>
							
 	
  </a></td>
						<td width="18%" align="left"><a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>','<%=Helper.correctNull((String) g1.get(1))%>','<%=Helper.correctNull((String) g1.get(2))%>','<%=Helper.correctNull((String) g1.get(3))%>','<%=Helper.correctNull((String) g1.get(9))%>','<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="center">
						<%=Helper.correctNull((String) g1.get(11))%>
						</a></td>
						<td width="23%" align="left">
						<%if(strFromLink.equalsIgnoreCase("Nursery")) {%>
						<a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>',
							'<%=Helper.correctNull((String) g1.get(1))%>',
							'<%=Helper.correctNull((String) g1.get(2))%>',
							'<%=Helper.correctNull((String) g1.get(3))%>',
							'<%=Helper.correctNull((String) g1.get(9))%>',
							'<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="center">
							<%=Helper.correctNull((String) g1.get(8))%></a>
						
						<%}else{ %>
						<a
							href="javascript:getSelectedValue('<%=Helper.correctNull((String) g1.get(0))%>',
							'<%=Helper.correctNull((String) g1.get(1))%>',
							'<%=Helper.correctNull((String) g1.get(2))%>',
							'<%=Helper.correctNull((String) g1.get(3))%>',
							
							'<%=Helper.correctNull((String) g1.get(9))%>',
							'<%=Helper.correctNull((String) g1.get(10))%>','<%=Helper.correctNull((String) g1.get(11))%>','<%=Helper.correctNull((String) g1.get(12))%>')"
							align="center"><%=Helper.correctNull((String) g1.get(8))
							+ " - " + Helper.correctNull((String) g1.get(9))%></a>
						<%} %>	
							</td>
					</tr>
					<%
						}
						}
						else
						{%>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="18%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="18%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="6%">&nbsp;</td>
						<td width="16%">&nbsp;</td>
						<td width="37%">&nbsp;</td>
						<td width="18%">&nbsp;</td>
						<td width="23%">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td colspan="5" align="center"><b>No Data Found for the
						selected criteria</b>
					</tr>
					<%
						}
					%>
					

				</table>
				
		</table>
		</td>
	</tr>
</table>
<br>
<table width="10%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr valign="top">
		<td width="20%"><input type=button
			class="buttonClose"
			value="Close" name="closebtn" tabindex="25" onClick=window.close()></td>
	</tr>
</table>

<input type="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>"> 
<input type="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>"> 
<input type="hidden" name="strfrom" value="<%=strFromLink%>"> 
<input type="hidden" name="txtid" value="<%=strtxtid%>"> 
<input type="hidden" name="size" value="<%=size%>"> 
<input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String)hshValues.get("ORG_CODE"))%>"> 
<input type="hidden" name="hidsno" value=""> 
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidcat_parent" value="0">  
<input type="hidden" name="strStatId1" value="">
<input type="hidden" name="strappno" value="<%=strappno%>">
</form>
</body>
</html>

