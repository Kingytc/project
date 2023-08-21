
<%@include file="../share/directives.jsp"%>
<%
 
 
 ArrayList arrRow = new ArrayList();
 ArrayList arrCol = new ArrayList();
 
 arrRow=(ArrayList)hshValues.get("arrRow");
 
 int intsize=0;
 if(arrRow!=null)
	 intsize=arrRow.size();
 
 %>

<html>
<head>
<title>Facility Arrangement</title>
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varPromoFreeze="<%=Helper.correctNull((String)hshValues.get("app_freeze_flag"))%>";
var varloanapplied="<%=Helper.correctNull((String)hshValues.get("Strloanapplied"))%>";

 function onload()
{
	var cnt=0;
	var a=0;
	//display sublimtof value....
	<%if(intsize>1){%>	
	for(var i=0;i<eval(<%=intsize%>);i++)
	{
		if(document.forms[0].sellimitType[i].value=="S")
		{
			a=1;
			document.forms[0].sel_MainLimit[i].length=eval(cnt)+1;
			document.forms[0].sel_MainLimit[i].options[0]=new Option('--select--','');
			for(var z=0;z<eval(<%=intsize%>);z++)
			{
				if(document.forms[0].sellimitType[z].value=="M")
				{
					document.forms[0].sel_MainLimit[i].options[a] = new Option(document.forms[0].txtfac_sno[z].value+"-"+document.forms[0].txtfac_desc[z].value,document.forms[0].txtfac_sno[z].value);
					a=a+1;
				}
			}
			document.forms[0].sel_MainLimit[i].value=document.forms[0].txtfac_group[i].value;
			
		}
		else
		{
			document.forms[0].sel_MainLimit[i].length=1;
			document.forms[0].sel_MainLimit[i].options[0]=new Option('--select--','0');

			
		}	
	}
	<%}else if(intsize==1){%>

		document.forms[0].sel_MainLimit.length=1;
		document.forms[0].sel_MainLimit.options[0]=new Option('--select--','0');
		
	<%}%>
	disableFields(true);
	if(varPromoFreeze=="Y")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}

 function doSave(){

	 for(var i=0;i<eval(<%=intsize%>);i++)
	 {
		if(document.forms[0].sellimitType[i].value=="S")
		{
			if(document.forms[0].sel_MainLimit[i].value=="")
			{
				alert("choose Main Limit of "+document.forms[0].txtfac_desc[i].value);
				document.forms[0].sel_MainLimit[i].focus();
				return
			}
		}
	}
	//For LLR Amount Check
	 var varTotMainLimitAmt=0;
	 for(var i=0;i<eval(<%=intsize%>);i++)
	 {
		if(document.forms[0].sellimitType[i].value=="M")
		{
			var  varMailLimitAmt=document.forms[0].txtfac_amt[i].value;
			varTotMainLimitAmt=parseFloat(varTotMainLimitAmt)+parseFloat(varMailLimitAmt);
		}
	 }
	if(parseFloat(varloanapplied)<parseFloat(varTotMainLimitAmt))
	{
		alert("Amount Requested should not be greater than Attached LAR Requested Limit");
		return;
	}
	//For Limit Type Change Check
	var varlimitChange="";
	<%for(int i=0;i<arrRow.size();i++)
	{
		arrCol=(ArrayList)arrRow.get(i);%>
		if(document.forms[0].sellimitType[<%=i%>].value=="S")
		{
			if(document.forms[0].sel_MainLimit[<%=i%>].value!='<%=Helper.correctNull((String)arrCol.get(1))%>')
			{
				varlimitChange="false";
			}
		}
		else if(document.forms[0].sellimitType[<%=i%>].value=="M")
		{
			if('<%=Helper.correctNull((String)arrCol.get(1))%>'!="0")
			{
				varlimitChange="false";
			}
		}
	<%}%>
	if(varlimitChange=="false")
	{
		if(ConfirmMsg(200))
		 {
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidBeanId.value="facilities";
			document.forms[0].hidBeanMethod.value="UpdateFacilityArrangement";		
			document.forms[0].hidBeanGetMethod.value="getFacilityArrangement";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/facilitiesArrangement.jsp";		
			document.forms[0].submit();
		 }
	}
	else
	{
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFacilityArrangement";
		document.forms[0].action=appURL+"action/facilitiesArrangement.jsp";
		document.forms[0].submit();
	}
 }
 
function doEdit(){
	disableFields(false);
	enableButtons(true,false,false,true);

}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=true;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
				document.forms[0].elements[i].disabled=val;
		  }
	  }
}

function enableButtons(bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="facilities"
		document.forms[0].hidBeanGetMethod.value="getFacilityArrangement";
		document.forms[0].action=appURL+"action/facilitiesArrangement.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	
   if(ConfirmMsg(100))
   {
	   window.opener.document.forms[0].hidBeanId.value="facilities";
		window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
		window.opener.document.forms[0].action=appURL+"action/facilities.jsp";	
		window.opener.document.forms[0].method="post";
		window.opener.document.forms[0].submit();
		window.close();
	}
	
}

function sublimitType(val1){

	var cnt=0;
	var a=1;
	
	<%if(intsize==1)
	{%>
		if(val1.value=="S")
		{
			alert("There is no Main Limit, you can't modify this as submit");
			val1.value="M";
			return;
		}
	<%}
	else
	{%>
		var varIndex=0;
		<%for(int i=0;i<arrRow.size();i++)
		{%>
			if(document.forms[0].sellimitType[<%=i%>].value=="M" && val1!=document.forms[0].sellimitType[<%=i%>])
			{
				
				cnt=cnt+1;
			}

			if(val1==document.forms[0].sellimitType[<%=i%>])
			{
				varIndex="<%=i%>";
			}
			
		<%}%>

		if(val1.value=="S")
		{
			if(eval(cnt)==0)
			{
				alert("There is no Main Limit, you can't modify this as submit");
				val1.value="M";
				return;
			}
			document.all.sel_MainLimit_Of[varIndex].style.display="none";
			document.forms[0].sel_MainLimit[varIndex].length=eval(cnt)+1;
			
			for(var i=0;i<eval(<%=intsize%>);i++)
			{
				if(document.forms[0].sellimitType[i].value=="M")
				{
					document.forms[0].sel_MainLimit[varIndex].options[a] = new Option(document.forms[0].txtfac_sno[i].value+"-"+document.forms[0].txtfac_desc[i].value,document.forms[0].txtfac_sno[i].value);
					a=a+1;
				}
			}
		}
	<%}%>

	for(var i=0;i<eval(<%=intsize%>);i++)
	{
		var varValue="";
		if(document.forms[0].sellimitType[i].value=="S")
		{
			a=1;
			document.forms[0].sel_MainLimit[i].length=eval(cnt)+1;
			var varTemp=document.forms[0].sel_MainLimit[i].value;
			for(var z=0;z<eval(<%=intsize%>);z++)
			{
				if(document.forms[0].sellimitType[z].value=="M")
				{
					document.forms[0].sel_MainLimit[i].options[a] = new Option(document.forms[0].txtfac_sno[z].value+"-"+document.forms[0].txtfac_desc[z].value,document.forms[0].txtfac_sno[z].value);
					if(varTemp==document.forms[0].txtfac_sno[z].value)
					{
						varValue=varTemp;
					}
					a=a+1;
				}
			}
			document.all.sel_MainLimit_Of[i].style.display="table-cell";
			if(varValue!="")
			{
				document.forms[0].sel_MainLimit[i].value=varValue;
			}
			else
			{
			document.forms[0].sel_MainLimit[i].value="0";
			}
				
		}
		else
		{
			document.forms[0].sel_MainLimit[i].length=1;
			document.forms[0].sel_MainLimit[i].options[0]=new Option('--select--','0');
		 
			document.all.sel_MainLimit_Of[i].style.display="none";	
		}
	}

}	
function callChkAmount(val1)
{
	var selFacility=val1.value;
	var varMailLimitAmt=0;
	var varTotSubLimitAmt=0;
	var j;

	for(var i=0;i<eval(<%=intsize%>);i++)
	{
		if(document.forms[0].sel_MainLimit[i]==val1)
		{
			j=i;
		}
	}

	for(var i=0;i<eval(<%=intsize%>);i++)
	{
		if(document.forms[0].sellimitType[i].value=="M" && document.forms[0].txtfac_sno[i].value==selFacility)
		{
			varMailLimitAmt=document.forms[0].txtfac_amt[i].value;
		}
			
		if(document.forms[0].sel_MainLimit[i].value==selFacility && j==i)
		{
			varTotSubLimitAmt=document.forms[0].txtfac_amt[i].value;
		}
		
		if(document.forms[0].txtfac_sno[i].value==selFacility)
		{
			if(document.forms[0].txtfac_headid[i].value=="1" && document.forms[0].txtfac_subheadid[i].value=="44")
			{
				alert("Sub-Limit not allowed for Forward Contract Facilities");
				val1.value="";
				return;
			}
			if((document.forms[0].txtfac_cat[i].value=="A" || document.forms[0].txtfac_cat[i].value=="D") && document.forms[0].txtfac_cat[j].value=="O")
			{
				alert("You cannot add any Adhoc Limit/Additional facility for One Time Limit");
				val1.value="";
				return;
			}
			if((document.forms[0].txtfac_cat[j].value=="A" || document.forms[0].txtfac_cat[j].value=="D") && document.forms[0].txtfac_cat[i].value=="O")
			{
				alert("You cannot add any Adhoc Limit/Additional facility for One Time Limit");
				val1.value="";
				return;
			}
		}
	}
	if(eval(varMailLimitAmt)<eval(varTotSubLimitAmt))
	{
		alert("The Sublimit Amount should not exceeds the Main facility Amount " +varMailLimitAmt);
		val1.value="";
		return;
	}
}
function RefreshParent() {
	  if (window.opener != null && !window.opener.closed) {
		    window.opener.document.forms[0].hidBeanId.value="facilities";
	 		window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
	 		window.opener.document.forms[0].action=appURL+"action/facilities.jsp";	
	 		window.opener.document.forms[0].method="post";
	 		window.opener.document.forms[0].submit();
	 		window.close();
    }
}
//window.onbeforeunload = RefreshParent;

</script>
</head>
<body onload="onload();">
<form method="post" class="normal"><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="10"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" class="outertable">
			<tr class="dataheader">
				<td width="100%" align="center"><b>Facility Arrangement</b></td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="3"
	class="outertable linebor">
	<tr class="dataheader">
		<td width="5%" align="center">S.No</td>
		<td width="30%" align="center">Facility Head</td>
		<td align="center" width="25%">Facility</td>
		<td width="10%" align="center">Amount</td>
		<td align="center" width="10%">Limit Type</td>
		<td align="center" width="10%">Sub Limit Of</td>
	</tr>
	<%if(arrRow!=null && arrRow.size()>0){
		for(int i=0;i<arrRow.size();i++)
		{
		arrCol=(ArrayList)arrRow.get(i);
%>
	<tr id="fac_arrange">
		<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;<input type="hidden" name="txtfac_sno"
			value="<%=Helper.correctNull((String)arrCol.get(0)) %>" size="5">
			<input type="hidden" name="txtfac_group"
			value="<%=Helper.correctNull((String)arrCol.get(1)) %>">
			</td>
		<td><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;<input type="hidden" name="txtfac_head"
			value="<%=Helper.correctNull((String)arrCol.get(4)) %>"></td>
		<td><%=Helper.correctNull((String)arrCol.get(5)) %> &nbsp;<input type="hidden" name="txtfac_desc"
			value="<%=Helper.correctNull((String)arrCol.get(5)) %>"></td>
		<td><input type="text" name="txtfac_amt"
			value="<%=Helper.correctNull((String)arrCol.get(3)) %>" style="text-align: right;"></td>

		<td nowrap="nowrap" ><select name="sellimitType"
			onchange="sublimitType(this)">
			<%if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("0")){ %>
			<option value="M" selected="selected">Main Limit</option>
			<option value="S">sub Limit</option>
			<%}else{ %>
			<option value="M">Main Limit</option>
			<option value="S" selected="selected">sub Limit</option>
			<%} %>
		</select></td>
		<td	>
		<select name="sel_MainLimit" id="sel_MainLimit_Of"  onchange="callChkAmount(this)" <%if(Helper.correctNull((String)arrCol.get(1)).equalsIgnoreCase("0")){ %> style="display: none;"<%} %>>
		</select>
		<input type="hidden" name="txtfac_cat" value="<%=Helper.correctNull((String)arrCol.get(6)) %>">
		<input type="hidden" name="txtfac_headid" value="<%=Helper.correctNull((String)arrCol.get(7)) %>">
		<input type="hidden" name="txtfac_subheadid" value="<%=Helper.correctNull((String)arrCol.get(8)) %>">
		</td>


	</tr>
	<%}} %>

</table>



<lapschoice:combuttonnew btnnames='Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String) request 
							.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>