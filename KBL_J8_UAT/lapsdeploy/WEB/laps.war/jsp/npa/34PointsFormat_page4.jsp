<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>

<%String strCons_Owner = Helper.correctNull((String) request
					.getParameter("hidCostitution"));

			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));
			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}
			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);

			String[] stractholdname = new String[5];
			String[] strrelation = new String[5];
			String[] straccounttype = new String[5];
			String[] stroutstandingamount = new String[5];

			stractholdname = (String[]) hshValues.get("fil_actholdname");
			strrelation = (String[]) hshValues.get("fil_relation");
			straccounttype = (String[]) hshValues.get("fil_accounttype");
			stroutstandingamount = (String[]) hshValues
					.get("fil_outstandingamount");

			%>
<html>
<head>
<title>ubi</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

var sel_bank_arrangement="<%=Helper.correctNull((String)hshValues.get("sel_bank_arrangement"))%>";
var sel_associate="<%=Helper.correctNull((String)hshValues.get("sel_associate"))%>";
var sel_accountholder="<%=Helper.correctNull((String)hshValues.get("sel_accountholder"))%>";

var fil_symptoms="<%=Helper.correctNull((String)hshValues.get("fil_symptoms"))%>";


function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true; 
		 disableFields(false);
	}
}

function clearValues()
{
	
	if(sel_accountholder=="n")
	for( i=0;i<=4;i++)		
	{	
		    document.forms[0].txt_actholdname[i].value="";
			document.forms[0].txt_relation[i].value="";
			document.forms[0].txt_accounttype[i].value="";
			document.forms[0].txt_outstandingamount[i].value="";
		
	}
	if(fil_symptoms=="n")
	  document.forms[0].txt_account_history.value="";	

}
function onLoading()
{
	
		if(fil_symptoms!="")
		{
			document.forms[0].txt_symptoms.value=fil_symptoms;	
		}
		else
		{
			document.forms[0].txt_symptoms.value="y";	
		}
		
	//disableCommandButtons("load");
	
	if(sel_accountholder!="")
	{
	    document.forms[0].sel_accountholder.value=sel_accountholder;	
		
	}
	else
	{
	    document.forms[0].sel_accountholder.value="y";	
	}
	
	<%for(int d=0;d<5;d++)
	{
		stractholdname[d]=Helper.correctNull((String)stractholdname[d]);
		strrelation[d]=Helper.correctNull((String)strrelation[d]);
		straccounttype[d]=Helper.correctNull((String)straccounttype[d]);
		stroutstandingamount[d]=Helper.correctDouble((String)stroutstandingamount[d]);
////System.out.println("++++++++++++++++++============================="+stractholdname[d]);
		if(!stractholdname[d].equalsIgnoreCase("") && stractholdname[d]!=null)
		{
		%>
			var stractholdname="<%=stractholdname[d]%>";
			var strrelation="<%=strrelation[d]%>";
			var straccounttype="<%=straccounttype[d]%>";
			var stroutstandingamount="<%=Helper.formatDoubleValue(Double.parseDouble(stroutstandingamount[d]))%>";
			var sel1="<%=d%>";
			
			document.forms[0].txt_actholdname[sel1].value=stractholdname;
			document.forms[0].txt_relation[sel1].value=strrelation;
			document.forms[0].txt_accounttype[sel1].value=straccounttype;
			document.forms[0].txt_outstandingamount[sel1].value=stroutstandingamount;
		<%}
	}%>
	accountHolder();
	selAssociate();
	selourbank();
	clearValues();
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	disableCommandButtons("edit");	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_symptoms.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page4.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="get34pointspage4Data";
		document.forms[0].hidBeanMethod.value="get34pointspage4Data";
		document.forms[0].action=appUrl +"controllerservlet"; 
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page4.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="update34pointspage4Data";
	document.forms[0].hidBeanGetMethod.value="get34pointspage4Data";
	document.forms[0].action=appUrl+"controllerservlet"; 
	document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one' )
		  {
 				document.forms[0].elements[i].disabled=val;
		  }  
		   if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}  
		 
	}
	
	
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
		}
	}
	
	function doDelete()
{
if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/34PointsFormat_page4.jsp";
			document.forms[0].hidBeanId.value="npa";
			document.forms[0].hidBeanMethod.value="update34pointspage4Data";
			document.forms[0].hidBeanGetMethod.value="get34pointspage4Data";
			document.forms[0].action=appUrl +"controllerservlet";
			document.forms[0].submit(); 
		}


}	

function callLink(page,bean,method)
		{
		if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		//alert(document.forms[0].hidSourceUrl);
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="SUIT";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
			 }
	else
	{
		ShowAlert(103);
	}
		}
		
		
function callCalender(name)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
		
	}
}	

function showtabular()
{

}


function accountHolder()
{
	if(document.forms[0].sel_accountholder.value=="y")
	{
	document.all.a1.style.visibility="visible";
	for(var i=0;i<5;i++)
	{
		document.all.row3[i].style.visibility="visible";
		document.all.row3[i].style.position="relative";
		}
	
		
	}
	else
	{
	document.all.a1.style.visibility="hidden";
	for(var i=0;i<5;i++)
	{
		document.all.row3[i].style.visibility="hidden";
		document.all.row3[i].style.position="absolute";
		
		document.forms[0].txt_actholdname[i].value="";
			document.forms[0].txt_relation[i].value="";
			document.forms[0].txt_accounttype[i].value="";
			document.forms[0].txt_outstandingamount[i].value="";
		
		}
	
		
	}
}

function selAssociate()
{
	
}

function selourbank()
{
	if(document.forms[0].txt_symptoms.value=="y")
	{
	document.all.s1.style.visibility="visible";
	document.all.s1.style.position="relative";
		
	}
	else
	{
	document.all.s1.style.visibility="hidden";
	document.all.s1.style.position="absolute";
	document.forms[0].txt_account_history.value="";
		
	}
}





</script>
</head>
<body onload="onLoading()">
<form name="34pointsFormatpage4" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
 class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"
			align="left">
			<tr>
				<td><lapstab:suiturltag pageid="7" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of
				Suit -&gt;Banking Details</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			colspan="2"  class="outertable">
			<tr>
				<td>Does the borrower(s) Bank with any of the other branches of our
				Bank. <br>
				</td>
				<td><select name="txt_symptoms" onChange="selourbank()">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
			</tr>
			<tr>
				<td COLSPAN="" id="s1"><textarea rows="8" name="txt_account_history"
					cols="70" onkeypress="textlimit(this,3950)" onKeyUp="textlimit(this,3950)"><%=Helper.correctNull((String) hshValues
							.get("fil_account_history"))%></textarea></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td COLSPAN=""></td>
			</tr>
			<tr>
				<td WIDTH="53%">Does the borrower(s) have any Savings Bank Account
				and/or Term Deposit Account. either ..&#149;. in the personal
				name(s) of the partners. their family members. etc. in your branch.
				or with gny other Branch of our Bank and/or with any other Bank?</td>
				<td WIDTH="47%"><select name="sel_accountholder"
					onChange="accountHolder();">
					<option value="y">Yes</option>
					<option value="n">No</option>
				</select></td>
			</tr>
			<tr>
				<td COLSPAN=""></td>
			</tr>
			<tr id="a1">
				<td width="25%">Name of Account Holder</td>
				<td width="25%">Relation</td>
				<td width="25%">Type Of Account</td>
				<td width="25%">Outstanding Amount</td>
			</tr>
			<%for (int i = 0; i < 5; i++) {

				if (stractholdname[i] != null && stractholdname[i] != "") {
					//System.out.println("==-=-=-=-=-=-0=-=" + stractholdname[i]);

					%>
			<tr id="row3">
				<td width="25%"><input type="text" name="txt_actholdname" size="35"
					maxlength="75"
					value="<%//=Helper.correctNull((String)arrColsta.get(1))%>"></td>
				<td width="25%"><INPUT TYPE="text" NAME="txt_relation" SIZE="35"
					MAXLENGTH="45"
					VALUE="<%//=Helper.correctNull((String)arrColsta.get(1))%>"></td>
				<td width="25%"><input type="text" name="txt_accounttype" size="35"
					maxlength="45"
					value="<%//=Helper.correctNull((String)arrColsta.get(1))%>"></td>

				<td width="25%">Rs.<lapschoice:CurrencyTag
					name="txt_outstandingamount" size="35" maxlength="15" /></td>
			</tr>
			<%}

				else {%>
			<tr id="row3">
				<td width="25%"><input type="text" name="txt_actholdname" size="35"
					maxlength="75"></td>
				<td width="25%"><input type="text" name="txt_relation" size="35"
					maxlength="45"></td>

				<td width="25%"><input type="text" name="txt_accounttype" size="35"
					maxlength="45"></td>

				<td width="25%">Rs.<lapschoice:CurrencyTag
					name="txt_outstandingamount" size="35" maxlength="15" /></td>
			</tr>
			<%}
			}

			%>

			<tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete"
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
	<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidCostitution" value="<%=strCons_Owner%>" /></form>
</body>
</html>
