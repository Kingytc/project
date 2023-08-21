<%@include file="../../share/directives.jsp"%>
<%
ArrayList arrValues=new ArrayList();
if (hshValues instanceof java.util.HashMap) 
{
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrRow");
	}
	
}

%>

<html>
<head>
<title>SHARE VALUE MASTER SEARCH</title>
<style type="text/css">
<!--
.cellContainers {
	width: 100%;
	height: 250px;
	overflow: auto;
}
-->
</style>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		window.close();
	}
}

function selectValues()
{
	document.forms[0].txt_company_name.readOnly=false;
	document.forms[0].txt_company_name.value="";
	document.forms[0].txt_company_name.focus();
}

function callSearch1()
{

	
	if((document.forms[0].searchtype[0].checked==false)&&(document.forms[0].searchtype[1].checked==false))
	{
		alert("Please choose the Company CIN No or Name ");
		return;
	}
	if(trimtxt(document.forms[0].txt_company_name.value)=="")
	{
		alert("Please Enter Company CIN No or Name ");
		return;
	}
	if(document.forms[0].searchtype[0].checked==true)
	{
		document.forms[0].SearchStatus.value="cinno";
	}
	if(document.forms[0].searchtype[1].checked==true)
	{
		document.forms[0].SearchStatus.value="name";
	}


	if(document.forms[0].txt_company_name.value.length<=2) {
		 alert("Enter atleast 3 characters");
	     document.forms[0].txt_company_name.focus();
	     return;
	}
	
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getShareValueMasterData";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="Search";
	document.forms[0].action=appURL+"action/setShareValueMasterSearch.jsp";	
	document.forms[0].submit();
}

function callReset()
{
	ClearFields();
}
function callonLoad()
{		
	document.forms[0].txt_company_name.readOnly=true;		
}


function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
	}
}

function displayCompanyList(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
	if(document.forms[0].pagefrom.value=="sharemaster")
	{
	window.opener.document.forms[0].hidcompanycode.value=val1;
	window.opener.document.forms[0].txt_CIN_no.value=val2;
	window.opener.document.forms[0].txt_Companyname.value=val3;
	window.opener.document.forms[0].txt_facevalue.value=roundVal(val4);
	window.opener.document.forms[0].txt_networth.value=roundVal(val5);
	window.opener.document.forms[0].txt_networthasondate.value=val6;
	window.opener.document.forms[0].txt_avgmarketval.value=roundVal(val7);
	window.opener.document.forms[0].hid_avgmarketval.value=roundVal(val7);
	window.opener.document.forms[0].txt_marketval.value=roundVal(val8);
	window.opener.document.forms[0].txt_marketvalasondate.value=val9;
	window.opener.document.forms[0].txt_paidupcapital.value=roundVal(val10);
	window.opener.document.forms[0].txt_paidupcapitalasondate.value=val11;
	window.opener.document.forms[0].hidtype.value=val12;
	var str_type_temp =val12.split("@");//for enable options
	//for enable options
		for(var i=1;i<str_type_temp.length-1;i++)
		{
			var selValue=str_type_temp[i];		
				for(var j=0;j<window.opener.document.forms[0].sel_type.options.length;j++)
				{	
						if(window.opener.document.forms[0].sel_type.options[j].value==selValue)
						{
							window.opener.document.forms[0].sel_type.options[j].selected=true;
						}
				}		
		}
		if(val16!="" && val16!= null){
		var str_temp1=val16.split("@");//for disable options
		var len_opt=window.opener.document.forms[0].sel_type.options.length;
		for(var j=0;j<str_temp1.length;j++)
		{	
				var str_tempVal=str_temp1[j].split("~");
				var x = window.opener.document.getElementById("sel_type1");
				var option = window.opener.document.createElement("option");
				option.text = str_tempVal[1];
				option.title = str_tempVal[1];
				option.value=str_tempVal[0];
				option.selected=true;	
				x.add(option);
		}
		}
	window.opener.document.forms[0].sel_approve.value=val13;
	window.opener.document.forms[0].txt_reservescapital.value=roundVal(val14);
	window.opener.document.forms[0].sel_active.value=val15;
	window.opener.enableButtons(true,false,true,false,false,false);
	window.close();
	}
	else if(document.forms[0].pagefrom.value=="securitymaster")
	{
		if(val1=="000000001")
		{
			alert("You cannot use Our bank share");
			return;
		}
		window.opener.document.forms[0].hidcompanycode.value=val1;
		window.opener.document.forms[0].txt_com_cinno.value=val2;
		window.opener.document.forms[0].txt_companyname.value=val3;
		window.opener.document.forms[0].txt_shareval.value=roundVal(val7);
		window.opener.caltotalsecvalue();
		window.close();
	}
}
</SCRIPT>
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>

		<td class="page_flow">Company Master Search</td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable">
					<tr>
						<td width="2%" nowrap="nowrap"><input type="radio"
							name="searchtype" value="radiobutton" style="border-style: none"
							onClick="selectValues()"></td>
						<td width="20%">CIN Number</td>
						<td width="0%" nowrap="nowrap"><input type="radio"
							name="searchtype" value="radiobutton" style="border-style: none"
							onClick="selectValues()"></td>
						<td width="7%" nowrap="nowrap">Company Name</td>
						<td width="33%"><input type="text" name="txt_company_name"
							size="20" maxlength="25" value="" readOnly="readonly"></td>
						<td width="50%"><input type="button" name="cmdsearch"
							value="Search" class="buttonStyle" onClick="callSearch1()">
						</td>

					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr class="dataheader" align="center">
						<td width="5%">&nbsp;</td>
						<td width="20%"><b>Company CIN Number</b></td>
						<td width="45%"><b>Company Name</b></td>
					</tr>
					<tr>
						<td valign="top" align="center" colspan="3">
						<DIV class="cellContainers">
						<table width="100%" border="0" cellspacing="1" cellpadding="2">

							<%
                                   
                                      if(arrValues!=null && arrValues.size()>0)
                                      {
                                    	  int arrSize=arrValues.size();
                                          ArrayList arrData=null;
                                    	  for(int i=0;i<arrSize;i++)
                                    	  {
                                    		  arrData=new ArrayList();
                                    		  arrData=(ArrayList)arrValues.get(i);

                                   %>
							<tr class="datagrid">

								<td width="5%"><input type="radio" name="rdoUser"
									style="border-style: none" onClick="displayCompanyList('<%=Helper.correctNull((String)arrData.get(0)) %>',
									'<%=Helper.correctNull((String)arrData.get(1)) %>','<%=Helper.correctNull((String)arrData.get(2)) %>',
									'<%=Helper.correctNull((String)arrData.get(3)) %>','<%=Helper.correctNull((String)arrData.get(4)) %>',
									'<%=Helper.correctNull((String)arrData.get(5)) %>','<%=Helper.correctNull((String)arrData.get(6)) %>',
									'<%=Helper.correctNull((String)arrData.get(7)) %>','<%=Helper.correctNull((String)arrData.get(8)) %>',
									'<%=Helper.correctNull((String)arrData.get(9)) %>','<%=Helper.correctNull((String)arrData.get(10)) %>',
									'<%=Helper.correctNull((String)arrData.get(11)) %>','<%=Helper.correctNull((String)arrData.get(12)) %>',
									'<%=Helper.correctNull((String)arrData.get(13)) %>','<%=Helper.correctNull((String)arrData.get(14)) %>',
									'<%=Helper.correctNull((String)arrData.get(15)) %>');"></td>
								<td width="20%"><%=Helper.correctNull((String)arrData.get(1)) %>&nbsp;</td>
								<td width="45%"><%=Helper.correctNull((String)arrData.get(2)) %>&nbsp;</td>
							</tr>
							<% 		  
                                    	  }
                                    	  
                                      }
                                      else{
                                   %>

							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<%} %>
						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames=""
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="SearchStatus"> <input type="hidden" name="pagefrom"
	value="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>" />
	<input type="hidden" name="SecType"
	value="<%=Helper.correctNull((String)request.getParameter("SecType"))%>" />

</form>
</body>
</html>

