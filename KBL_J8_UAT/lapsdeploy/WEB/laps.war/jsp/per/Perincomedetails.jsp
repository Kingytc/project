<%@include file="../share/directives.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<%String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
  String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
%> 
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varstrFreeze="<%=strFreeze%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	
	document.forms[0].hidAction.value="update";
	
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="updatePerincomedetaildate";
	document.forms[0].hidBeanGetMethod.value="getdataPerincomedetaildate";
	document.forms[0].hidSourceUrl.value="/action/Perincomedetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updatePerincomedetaildate";
			document.forms[0].hidBeanGetMethod.value="getdataPerincomedetaildate";
			document.forms[0].hidSourceUrl.value="/action/Perincomedetails.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	else
	{
		
		ShowAlert(158);
	}	
		
}




function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getdataPerincomedetaildate";
		document.forms[0].action=appURL+"action/Perincomedetails.jsp";	
		document.forms[0].submit();
	}
}


function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}

function onloading()
{
	var prd_type="<%=prd_type%>";
	calldisable(true);

	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	document.forms[0].cmdedit.disabled = false;
	document.forms[0].cmddelete.disabled = true;
	document.forms[0].cmdcancel.disabled = true;
	document.forms[0].cmdsave.disabled = true;
		}
		else
		{
			document.forms[0].cmdedit.disabled = true;
			document.forms[0].cmddelete.disabled = true;
			document.forms[0].cmdcancel.disabled = true;
			document.forms[0].cmdsave.disabled = true;
		}
	}
	else
	{
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdsave.disabled = true;
	}
	var undertaken="<%=Helper.correctNull((String)hshValues.get("PERINC_UNDERTAKEN"))%>";
	if(prd_type=="pP")
	{
		document.all.Personal_Salaried.style.visibility="visible";
    	document.all.Personal_Salaried.style.position="relative";
    	if(!(undertaken==""))
		{
			document.forms[0].sel_undrtkngletter.value=undertaken;
		}
		else
		{
			document.forms[0].sel_undrtkngletter.value="0";
		}
	}
	else
	{
		document.all.Personal_Salaried.style.visibility="hidden";
    	document.all.Personal_Salaried.style.position="absolute";
	}

	//if(varstrFreeze=='Y')
	//{
	//	document.forms[0].cmdedit.disabled=true;
	//	document.forms[0].cmdsave.disabled=true;
	//}
	
}

</script>

<html>
<head>
<title>Income Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="appform" method="post" action="" class="normal">
	<jsp:include page="../share/Applurllinkper.jsp" flush="true" > 
	        <jsp:param name="pageid" value="1" />
     </jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Loan Particulars -&gt; Co-Applicant / Guarantor</td>
   </tr>
</table>

<lapschoice:application />
<jsp:include page="../per/applicanttab.jsp" flush="true"> 
<jsp:param name="linkid" value="117" />
 </jsp:include><br>
 
 <table width="98%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
    <tr> 
      <td valign="top"> 
      <table width="50%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
	          <tr> 
	            <td> 
               <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	        		  <tr> 
				            <td>  Basic Salary</td>
				            <td><%=ApplicationParams.getCurrency()%></td>
				            <td><input type="text" name="txt_Basicsal" size="15" maxlength="14" tabindex="1" onkeypress="allowDecimals(this)" onBlur="roundtxt(this);" style="text-align:right" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("perinc_basicsalary")))%>"></td>
           			 </tr>
          			 <tr>
          			        <td> DA</td>
          			        <td><%=ApplicationParams.getCurrency()%></td>
          			        <td><input type="text" name="txt_da" size="15" maxlength="14" tabindex="2" onkeypress="allowDecimals(this)" onBlur="roundtxt(this);" style="text-align:right" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("perinc_da")))%>"></td>
          			 </tr>
          			 <tr>
          			        <td> Allowance Eligible for Super Annuation</td>
          			        <td><%=ApplicationParams.getCurrency()%></td>
          			        <td><input type="text" name="txt_allowannuation" size="15" maxlength="14" tabindex="3" onkeypress="allowDecimals(this)" onBlur="roundtxt(this);" style="text-align:right" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("perinc_alloweligible")))%>" ></td>
          			 </tr>
          		   
          		    <tr id="Personal_Salaried">
          		    <td colspan="2">Where the applicant has produced necessary irrevocable undertaking letter from his salary-drawing officer for deduction of monthly installments and interest from his salary and for remittance of the same to the bank.</td>
					<td><select name="sel_undrtkngletter">
							<option value="0" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
          			 </tr>
          		   </table>
               </td>
          </tr>
       </table>
       </td>
       </tr>
     
       </table>
       
                           <br>
<lapschoice:combuttonnew btnnames='Edit _Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
    </form>
  </body>
</html>
          