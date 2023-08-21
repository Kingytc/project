<%@include file="../share/directives.jsp"%>

<% 
String strSubCategory=Helper.correctNull((String)request.getParameter("classificationtype"));
if(strSubCategory.equals(""))
{
	strSubCategory=Helper.correctNull((String)hshValues.get("strSubCategory"));
}
String str_house_cat= Helper.correctNull((String) hshValues.get("PMAY_HOUSE_CAT"));
String strappno=Helper.correctNull((String)request.getParameter("Applicationno"));

%>
<html>

<head>
<title>PMAY Housing Loan</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script type="text/javascript">
var varsubcat="<%=strSubCategory%>";
var varsubcat1="<%=str_house_cat%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getPMAYdata";
		document.forms[0].action=appURL+"action/pmay_houseloan.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updatePMAYdata";
			document.forms[0].hidBeanGetMethod.value="getPMAYdata";
			document.forms[0].hidSourceUrl.value="/action/pmay_houseloan.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
}

function placevalues()
{
	
	document.forms[0].sel_house_cat.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_HOUSE_CAT"))%>";
	document.forms[0].sel_loan_type.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_LOAN_TYPE"))%>";
	Ownship_mode();
	document.forms[0].sel_own_mode.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_OWN_MODE"))%>";
	document.forms[0].sel_borr_pucca.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_BORR_PUCCA"))%>";
	document.forms[0].sel_pre_cat.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_PREFER_CAT"))%>";
	document.forms[0].sel_subsid_inst.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_SUBSID_INST"))%>";
	document.forms[0].sel_source_app.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_SOURCE_APP"))%>";
	document.forms[0].sel_cert_house_own.value = "<%=Helper.correctNull((String) hshValues.get("PMAY_CERTIF_HOUSEOWN"))%>";
	pre_cat();
} 

function callOnload()
{	 
	calldisable(true);
	
	callValues();

	if(varRecordFlag=="Y")
	{
		window.opener.document.forms[0].hidPMAYDet.value="Y";
	}
	else
	{
		window.opener.document.forms[0].hidPMAYDet.value="N";
	}
	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}		

 	
}	

function callValues()
{
	document.all.iframe_setPmay.src = appURL+"action/iframe_setPmay.jsp?hidBeanGetMethod=getPmayClassification&hidBeanId=perDeviation&classificationtype="+ varsubcat+"&strSubCategory="+varsubcat1+"&flag=y";
}


function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}

function doSave()
{

	if(document.forms[0].sel_house_cat.value=="")
	{
		ShowAlert(111,'Household Category');
		document.forms[0].sel_house_cat.focus();
		return;
	}
	

	if(document.forms[0].sel_loan_type.value=="")
	{
		ShowAlert(111,'Type of Loan');
		document.forms[0].sel_loan_type.focus();
		return;
	}
	
	if(document.forms[0].sel_own_mode.value=="")
	{
		ShowAlert(111,'Ownership mode');
		document.forms[0].sel_own_mode.focus();
		return;
	}
	
	if(document.forms[0].sel_borr_pucca.value=="")
	{
		ShowAlert(111,'Whether Borrower owned a Pucca house either in his/her name or in name of family member in any part of India');
		document.forms[0].sel_borr_pucca.focus();
		return;
	}
	if(document.forms[0].sel_pre_cat.value=="")
	{
		ShowAlert(111,'Preference Category');
		document.forms[0].sel_pre_cat.focus();
		return;
	}

	if(document.forms[0].sel_pre_cat.value=="O")
	{
		if(document.forms[0].txt_other_category.value=="")
		{
			ShowAlert(111,'Other Category');
			document.forms[0].txt_other_category.focus();
			return;
		}
	}	

	if(document.forms[0].sel_subsid_inst.value=="")
	{
		ShowAlert(111,'Whether customer has already availed subsidy from Ex- Institute');
		document.forms[0].sel_subsid_inst.focus();
		return;
	}
	if(document.forms[0].sel_source_app.value=="")
	{
		ShowAlert(111,'Source of Application');
		document.forms[0].sel_source_app.focus();
		return;
	}
	if(document.forms[0].sel_cert_house_own.value=="")
	{
		ShowAlert(111,'Certificate of house ownership from revenue authority of Beneficiarys native district obtained');
		document.forms[0].sel_cert_house_own.focus();
		return;
	}

	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updatePMAYdata";
	document.forms[0].hidBeanGetMethod.value="getPMAYdata";
	document.forms[0].hidSourceUrl.value="/action/pmay_houseloan.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}

function Ownship_mode()
{
	if(document.forms[0].sel_loan_type.value=="E")
	{
		document.forms[0].sel_own_mode.length=3;
	 	document.forms[0].sel_own_mode.options[0] = new Option('<--select-->','');
	 	document.forms[0].sel_own_mode.options[1] = new Option('Self Owned','O');
	 	document.forms[0].sel_own_mode.options[2] = new Option('Inherited','I');
	}
	else
	{
		document.forms[0].sel_own_mode.length=2;
	 	document.forms[0].sel_own_mode.options[0] = new Option('<--select-->','');
	 	document.forms[0].sel_own_mode.options[1] = new Option('Self Owned','O');
	}	
}
function pre_cat()
{
	if(document.forms[0].sel_pre_cat.value=="04")
	{
		document.all.t1.style.display="table-row";
	}
	else
	{
		document.all.t1.style.display="none";
		document.forms[0].txt_other_category.value="";
	}
	
}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload();placevalues();">
<form class="normal" method="post">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td><lapschoice:application /></td>
    </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr>
      <td >
        <div align="center">
          <p class="dataheader" >PMAY Housing Loan</p>
          <table width="95%" border="1" cellspacing="1" cellpadding="3" class="outertable">
           
            <tr>
              <td width="56%">Household Category  </td>
              <td width="40%"> 
                <select name="sel_house_cat" style="width:75%;">
                  <option value="" selected="selected"><--select--></option>
                  
                </select>
              </td>
            </tr>
           
          	<tr>
              <td width="56%">Type of Loan </td>
              <td width="40%"> 
                <select name="sel_loan_type" style="width:75%;" onchange="Ownship_mode();">
                  <option value="" selected="selected"><--select--></option>
                  <option value="N">New Acquisition</option>
                  <%if(strSubCategory.equalsIgnoreCase("078")){ %>
                  <option value="E">Extension</option>
                <%} %>
                  <option value="C">New Construction</option>
                  
                  
                </select>
              </td>
            </tr>
          	<tr>
              <td width="56%">Ownership mode </td>
              <td width="40%"> 
                <select name="sel_own_mode" style="width:75%;">
                </select>
              </td>
            </tr>
          	<tr>
              <td width="56%">Whether Borrower owned a Pucca house either in his/her name or in name of family member in any part of India</td>
              <td width="40%" valign="top"> 
                <select name="sel_borr_pucca" style="width:75%;">
                  <option value="" selected="selected"><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                </select>
              </td>
            </tr>
            <tr>
              <td width="56%">Preference Category </td>
              <td width="40%"> 
                <select name="sel_pre_cat" style="width:75%;" onChange="pre_cat();">
                  <option value="" selected="selected"><--select--></option>
                  <option value="01">Disability</option>
                  <option value="02">Manual Scavenger</option>
                  <option value="03">Widow</option>
                  <option value="04">Others</option>
                </select>
              </td>
            </tr>
            <tr id='t1'>
	            <td width="56%">Other Category </td>
	            <td width="40%"><textarea name="txt_other_category" cols="30" rows="3"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("PMAY_OTHER_CATEGORY"))%>
	            				</textarea> </td>
            </tr>
            <tr>
              <td width="56%">Whether customer has already availed subsidy from Ex- Institute </td>
              <td width="40%"> 
                <select name="sel_subsid_inst" style="width:75%;">
                  <option value="" selected="selected"><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                </select>
              </td>
            </tr>
           <tr>
              <td width="56%">Source of Application </td>
              <td width="40%"> 
                <select name="sel_source_app" style="width:75%;">
                  <option value="" selected="selected"><--select--></option>
                  <option value="DU">Direct/ULB</option>
                  <option value="G">Govt. designated agency</option>
                  <option value="N">NGO</option>
                  <option value="D">Developers</option>
                </select>
              </td>
            </tr>
             <tr>
              <td width="56%">Certificate of house ownership from revenue authority of Beneficiary's native district obtained </td>
              <td width="40%" valign="top"> 
                <select name="sel_cert_house_own" style="width:75%;">
                  <option value="" selected="selected"><--select--></option>
                  <option value="Y">Yes</option>
                  <option value="N">No</option>
                  <option value="NT">Not Applicable</option>
                </select>
              </td>
            </tr>
          </table>
        </div>
      </td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />

<iframe height="0" width="0" id="iframe_setPmay" frameborder=0 style="border: 0"></iframe>
<input type="hidden" name="hidsubcat" value="<%=strSubCategory%>">
<input type="hidden" name="hidappno" value="<%=strappno%>">
</form>
</body>

</html>
