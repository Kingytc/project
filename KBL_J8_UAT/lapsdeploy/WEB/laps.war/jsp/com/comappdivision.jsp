<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%request.setAttribute("_cache_refresh", "true");%>
<%ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			vecRow = (ArrayList) hshValues.get("vecRow");
			String existing = Helper.correctNull((String) hshValues
					.get("existing"));
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			request.setAttribute("scode", "yyy");
			
			String strEmployment=(String)session.getAttribute("strEmployment");
			
			String strProfilestatus = Helper.correctNull((String) hshValues
					.get("strProfilestatus"));
			String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
			String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
			
			String pageid = request.getParameter("pageid");
			String strapptype = Helper.correctNull((String)request.getParameter("corp"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			ArrayList arrCol1 = new ArrayList();
			ArrayList arrRow1 = new ArrayList();
			String StrTemp = "";
			StringBuffer strbuff = new StringBuffer();
			String temp1 = "";
			String temp = "";
			int intArr1Size=0;
				if (hshValues != null)
					arrRow1 = (ArrayList) hshValues.get("arrmin");// coapplicant details
				
				if (arrRow1 != null && arrRow1.size() > 0) {
					for (int i = 0; i < arrRow1.size(); i++) {
						arrCol1 = (ArrayList) arrRow1.get(i);
						if (i == 0) {
							temp1 = temp1
									+ Helper.correctNull((String) arrCol1.get(1)
											.toString())
									+ " ("
									+ Helper.correctNull((String) arrCol1.get(0)
											.toString()) + ") ";
						} else {
							temp1 = temp1
									+ " and "
									+ Helper.correctNull((String) arrCol1.get(1)
											.toString())
									+ " ("
									+ Helper.correctNull((String) arrCol1.get(0)
											.toString()) + ") ";

						}
					}
					
					intArr1Size=arrRow1.size();
				}

					%>
<html>
<head>
<title>Factory Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varNewEntry = "N";

var appstatus="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";
var arrRow = "<%=intArr1Size%>";
var varStrAppid="<%=temp1%>";
function callDescHelp(page)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}	
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled == true)
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function doClose1()
{
	window.close();
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31,val32,val33)
{	
	//alert(val16);
	document.forms[0].comapp_div_id.value=val1;
	document.forms[0].comapp_div_name.value=val2;
	document.forms[0].comapp_div_address.value=val3;
	document.forms[0].comapp_div_city.value=val5;
	document.forms[0].hid_city.value=val4;
	document.forms[0].hid_state.value=val6;
	document.forms[0].comapp_div_state.value=val7;
	document.forms[0].comapp_div_pin.value=val8;
	document.forms[0].comapp_div_phone.value=val9;
	document.forms[0].comapp_div_fax.value=val10;	
	document.forms[0].comapp_divisiontype.value=val11;
	document.forms[0].comapp_companyid.value=val12;
	document.forms[0].hid_dist.value = val13;
	document.forms[0].comapp_div_dist.value=val14;
	document.forms[0].comapp_customer_id.value=val15;
	document.forms[0].txt_ratinggrade1.value=val16;
	document.forms[0].txt_ratingdate1.value=val17;
	document.forms[0].rating_type1.value=val18;
//	document.forms[0].txt_ratinggrade2.value=val19;
//	document.forms[0].txt_ratingdate2.value=val20;
//	document.forms[0].rating_type2.value=val21;
	document.forms[0].comapp_banker.value=val22;
	document.forms[0].comapp_cbsid.value=val23;
	document.forms[0].hid_grpname.value=val24;
	document.forms[0].txt_relation.value=val25;
	document.forms[0].sel_docexecutant.value=val27;
	if(val28!="")
		document.forms[0].selaccoperby.value=val28;
	else
		document.forms[0].selaccoperby.value="S";

	document.forms[0].txt_DINnumber.value=val29;
	document.forms[0].sel_chf_promoter.value=val31;
	document.forms[0].sel_personal_guarantee.value=val32;
	
	document.forms[0].sel_chk_npa.value=val33;

	concernChange(val26);
	//document.forms[0].comapp_divisionSubtype.value=val26;
	
	
	if(document.forms[0].readFlag.value=="r")
	{
		disableCommandButtons(true,true,true,true,true,false);
		
	}
	else
    {     
		 if(appstatus=="true")
		  {
			 disableCommandButtons(true,true,true,true,true,false);
		  }
		  else
		  {
			    if(document.forms[0].readFlag.value.toUpperCase()=="W")
			    {
					if(document.forms[0].exist.value=="e")
				    {
				     disableCommandButtons(true,true,true,true,true,false);
				    }
				    else if(document.forms[0].hidappexist.value=="true")
					{
				    disableCommandButtons(true,true,true,true,true,false);
					}
					else
					{
				    disableCommandButtons(true,false,true,false,true,false);
				    }

					if(document.forms[0].hid_grpname.value=="")
					{
						 document.forms[0].cmddelete.disabled=false;
					}
					else
					{
						document.forms[0].cmddelete.disabled=true;
					}
              }
		  }
	 }

}

function clearfields()
{
	document.forms[0].comapp_customer_id.value="";
	document.forms[0].comapp_div_id.value="";
	document.forms[0].comapp_div_name.value="";
	document.forms[0].comapp_div_address.value="";
	document.forms[0].comapp_div_city.value="";
	document.forms[0].comapp_div_state.value="";
	document.forms[0].comapp_div_pin.value="";
	document.forms[0].comapp_div_phone.value="";
	document.forms[0].comapp_div_fax.value="";	
	document.forms[0].comapp_divisiontype.value="";
	document.forms[0].txt_ratinggrade1.value="";
	document.forms[0].txt_ratingdate1.value="";
	document.forms[0].rating_type1.value="s";
//	document.forms[0].txt_ratinggrade2.value="";
//	document.forms[0].txt_ratingdate2.value="";
//	document.forms[0].rating_type2.value="s";
}

function doSave()
{
	if(varNewEntry == "Y")
	{
		<%if (vecRow!=null && vecRow.size() > 1) {
			for (int i = 0; i < vecRow.size(); i++) {
			vecCol = (ArrayList) vecRow.get(i);%>
				if(document.forms[0].txt_hidcbsid[<%=i%>].value != "" && document.forms[0].txt_hidcbsid[<%=i%>].value == document.forms[0].comapp_cbsid.value)
				{
					alert("Customer CBS ID Already Exists");
					return;
				}

				if(document.forms[0].sel_chf_promoter.value=="Y")
				{
					if("<%=Helper.correctNull((String)vecCol.get(30))%>"=="Y" && document.forms[0].txt_hidcbsid[<%=i%>].value != document.forms[0].comapp_cbsid.value)
					{
						alert("Cheif Promotor already exists");
						document.forms[0].sel_chf_promoter.value="";
						document.forms[0].sel_chf_promoter.focus();
						return;
					}
				}
		<%}}%>
	}

	<%if (vecRow!=null && vecRow.size() > 1) {
		for (int i = 0; i < vecRow.size(); i++) {
		vecCol = (ArrayList) vecRow.get(i);%>
			if(document.forms[0].sel_chf_promoter.value=="Y")
			{
				if("<%=Helper.correctNull((String)vecCol.get(30))%>"=="Y" && document.forms[0].txt_hidcbsid[<%=i%>].value != document.forms[0].comapp_cbsid.value)
				{
					alert("Cheif Promotor already exists");
					document.forms[0].sel_chf_promoter.value="";
					document.forms[0].sel_chf_promoter.focus();
					return;
				}
			}
	<%}}%>
	
	var strOldId="<%=Helper.correctNull((String)hshValues.get("strOldID"))%>";
	if(strOldId==document.forms[0].comapp_customer_id.value)
	{
		alert("Customer cannot act as Sister Concern");
		return;
	}
	if(document.forms[0].hidAction.value=="Insert")
			{
	<%if (vecRow!=null && vecRow.size() > 0) {
		for (int i = 0; i < vecRow.size(); i++) {
			vecCol = (ArrayList) vecRow.get(i);
			{%>
			var a="<%=Helper.correctNull((String)vecCol.get(14))%>";
			if(document.forms[0].comapp_customer_id.value==a && a!="")
			{
				alert("Already this Customer is added");
				return;
			}
			<%}}}%>
			}
	if(document.forms[0].comapp_divisiontype.value=="")
 	{
 		ShowAlert(111,'Concern Type');
 		document.forms[0].comapp_divisiontype.focus();
 		return;
 	}
	var concerntype=document.forms[0].comapp_divisiontype.value;
	if(concerntype=="D" ||concerntype=="PT" || concerntype=="SP" || concerntype=="OT" || concerntype=="K")
	{
		if(document.forms[0].comapp_divisionSubtype.value=="")
	 	{
	 		ShowAlert(111,'Concern Sub Type');
	 		document.forms[0].comapp_divisionSubtype.focus();
	 		return;
	 	}
	}
	//if(trim(document.forms[0].comapp_customer_id.value) == "")
 	//{
 		//ShowAlert(121,'Customer ID');
 		//document.forms[0].comapp_customer_id.focus();
 		//return;
 	//}
	
 	if(trim(document.forms[0].comapp_div_name.value) == "")
 	{
 		ShowAlert(121,'Concern Name');
 		document.forms[0].comapp_div_name.focus();
 		return;
 	}
 	
 	if(trim(document.forms[0].comapp_div_address.value)=="")
 	{
 		ShowAlert(121,'Concern Address');
 		document.forms[0].comapp_div_address.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_div_city.value)=="")
 	{
 		ShowAlert(121,'City');
 		document.forms[0].comapp_div_city.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_div_state.value)=="")
 	{
 		ShowAlert(121,'State');
 		document.forms[0].comapp_div_state.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_div_pin.value)=="")
 	{
 		ShowAlert(121,'Pincode');
 		document.forms[0].comapp_div_pin.focus();
 		return;
 	}
 	if(trim(document.forms[0].comapp_div_dist.value)=="")
 	{
 		ShowAlert(111,'District');
 		document.forms[0].comapp_div_dist.focus();
 		return;
 	}
	
	if(trim(document.forms[0].sel_docexecutant.value)=="")
 	{
 		ShowAlert(111,'Document Executant ');
 		document.forms[0].sel_docexecutant.focus();
 		return;
 	}
	if(trim(document.forms[0].selaccoperby.value)=="S")
 	{
 		ShowAlert(111,'Account to Operated by');
 		document.forms[0].selaccoperby.focus();
 		return;
 	}
	if(concerntype=="D")
	{
		if(trim(document.forms[0].txt_DINnumber.value)=="")
	 	{
	 		ShowAlert(121,'DIN Number');
	 		document.forms[0].txt_DINnumber.focus();
	 		return;
	 	}
	}

	
	if(trim(document.forms[0].sel_chk_npa.value)=="")
 	{
 		ShowAlert(111,'NPA Category for Group/Associate entites');
 		document.forms[0].sel_chk_npa.focus();
 		return;
 	}
	if(concerntype=="O"||concerntype=="D"||concerntype=="SP"||concerntype=="PT"||concerntype=="T"||concerntype=="K"||concerntype=="PA"||concerntype=="OT")
	{
		if(trim(document.forms[0].sel_chf_promoter.value)=="")
	 	{
	 		ShowAlert(111,'Chief Promoter');
	 		document.forms[0].sel_chf_promoter.focus();
	 		return;
	 	}
		if(trim(document.forms[0].sel_personal_guarantee.value)=="")
	 	{
	 		ShowAlert(111,'Personal Guarantee');
	 		document.forms[0].sel_personal_guarantee.focus();
	 		return;
	 	}
	}
 	
 	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="commappmaster";		
	document.forms[0].hidSourceUrl.value="/action/comappdivision.jsp";
	document.forms[0].hidBeanMethod.value="updateDivisionDetails";
	document.forms[0].hidBeanGetMethod.value="getDivisionDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(cmdnew,cmdedit,cmdsave,cmddel,cmdcancel,cmdclose)
{  
	document.forms[0].cmdnew.disabled =cmdnew;
	document.forms[0].cmdedit.disabled=cmdedit;	  
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmddelete.disabled=cmddel;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmdclose.disabled=cmdclose;
}  

function doEdit()
{ 	
	if(document.forms[0].comapp_customer_id.value=="")
	{
		disableFields(false);
		document.forms[0].comapp_customer_id.readOnly = true;
		document.forms[0].comapp_cbsid.readOnly = true;
	}
	else
	{
		disableFields(false);
		document.forms[0].comapp_customer_id.readOnly = true;
		document.forms[0].comapp_cbsid.readOnly = true;
		document.forms[0].comapp_div_name.readOnly = true;
		document.forms[0].comapp_div_address.readOnly = true;
		document.forms[0].comapp_div_pin.readOnly = true;
		document.forms[0].comapp_div_phone.readOnly = true;
		document.forms[0].comapp_div_fax.readOnly = true;
	}
	document.all.idsearch.style.visibility="hidden";
	document.all.idsearch.style.position="absolute";
	document.forms[0].hidAction.value ="Update";
	disableCommandButtons(true,true,false,true,false,false);
	document.forms[0].comapp_div_city.readOnly = true;
	document.forms[0].comapp_div_dist.readOnly = true;
	document.forms[0].comapp_div_state.readOnly = true;
	document.forms[0].hideditflag.value="Y";
}

function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="Insert";
	disableCommandButtons(true,true,false,true,false,true);
	clearfields();
	document.forms[0].comapp_customer_id.readOnly = true;
	document.forms[0].comapp_cbsid.readOnly = true;
	document.forms[0].comapp_div_city.readOnly = true;
	document.forms[0].comapp_div_dist.readOnly = true;
	document.forms[0].comapp_div_state.readOnly = true;
	
	//document.all.idsearch.style.visibility="hidden";
	//document.all.idsearch.style.position="absolute";
	document.forms[0].hideditflag.value="Y";
	varNewEntry = "Y";
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].hidBeanGetMethod.value="getDivisionDetails";
		document.forms[0].action=appURL+"action/comappdivision.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
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
  
function doDelete()
{
	//if(trim(document.forms[0].comapp_customer_id.value) == "")
 	//{
 		//ShowAlert(121,'Customer ID');
 		//document.forms[0].comapp_customer_id.focus();
 		//return;
 	//}
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
			document.forms[0].hidAction.value ="Delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateDivisionDetails";
			document.forms[0].hidBeanGetMethod.value="getDivisionDetails";	
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidSourceUrl.value="action/comappdivision.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
    }
	else
	{
		ShowAlert(158);
	}
}

function onloading()
{	  
	if(arrRow>0)
	{
		
		alert("Minority details are not entered in Customer Profile -> Demographics tab for the "+varStrAppid+" Kindly enter to proceeed further");
		return;
	   
	}
	disableFields(true);

	if(document.forms[0].readFlag.value=="r")
	{
		disableCommandButtons(true,true,true,true,true,false);
		
	}
	else
	{
         if(appstatus=="true")
	      {
  	  	   disableCommandButtons(true,true,true,true,true,false);
	      }
	     else
	      {
	 	   disableCommandButtons(false,true,true,true,true,false);
	      }
	}
	document.forms[0].hidAction.value ="";
	document.all.id_dinnumb.style.visibility="hidden";
	document.all.id_dinnumb.style.position="absolute";

	document.all.pguar1.style.display="none";
	document.all.pguar2.style.display="none";

	document.all.idchif1.style.display="none";
	document.all.idchif2.style.display="none";
}


function showSearchCity(val1)
{
	if(val1 == "SISTER" && document.forms[0].cmdsave.disabled==false)
	{
		if(document.forms[0].comapp_cbsid.value=="")
		{
			var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?sister="+val1;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}
}
function showDistSearch(val)
{  	
	var varstate = document.forms[0].hid_state.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].comapp_div_city.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].comapp_div_city.focus();
		return;
	}
	else		
	{
		if((document.forms[0].comapp_cbsid.value=="") || ((document.forms[0].comapp_cbsid.value!="")&&(document.forms[0].comapp_div_dist.value=="")))
		{
		    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);
		}
	}
	}
	
	
}
function showCustIdSearch()
{
	if(document.forms[0].cmdsave.disabled==false)
	{

		if(document.forms[0].comapp_divisiontype.value=="")
		{
			alert("Select Concern Type");
			document.forms[0].comapp_divisiontype.focus();
			return;
		}
		else if(document.forms[0].comapp_divisionSubtype.value=="")
		{
			alert("Select Sub Concern Type");
			document.forms[0].comapp_divisionSubtype.focus();
			return;
		}
	var varQryString = appURL + "action/com_SisterConcernSearch.jsp";
	var title = "ADD";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
	}
}
function callCalender(fname)
{
 	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	}
}

function concernChange(val)
{
	/*var concerntype=document.forms[0].comapp_divisiontype.value;

	if(concerntype=="D")
	{
		document.forms[0].comapp_divisionSubtype.length=3;
	 	document.forms[0].comapp_divisionSubtype.options[1] = new Option('Managing Director','MANAGD');
	 	document.forms[0].comapp_divisionSubtype.options[2] = new Option('Executive Director','EXECD');
        document.forms[0].comapp_divisionSubtype.options[3] = new Option('Director','D');
	}
	else if(concerntype=="PT")
	{
		document.forms[0].comapp_divisionSubtype.length=2;
	 	document.forms[0].comapp_divisionSubtype.options[1] = new Option('Managing Partner','MANAGP');
	 	document.forms[0].comapp_divisionSubtype.options[2] = new Option('Partner','PART');
	}
	else if(concerntype=="SP")
	{
		document.forms[0].comapp_divisionSubtype.length=2;
	 	document.forms[0].comapp_divisionSubtype.options[1] = new Option('Proprietor','PROP');
	 	document.forms[0].comapp_divisionSubtype.options[2] = new Option('Proprietress','PROPS');
	}
	else if(concerntype=="OT")
	{
		document.forms[0].comapp_divisionSubtype.length=5;
	 	document.forms[0].comapp_divisionSubtype.options[1] = new Option('President','PRES');
	 	document.forms[0].comapp_divisionSubtype.options[2] = new Option('Secretary','SEC');
        document.forms[0].comapp_divisionSubtype.options[3] = new Option('Treasurer','TRE');
        document.forms[0].comapp_divisionSubtype.options[4] = new Option('Members','MEM');
        document.forms[0].comapp_divisionSubtype.options[5] = new Option('Others','OTH');
	}
	else if(concerntype=="K")
	{
		document.forms[0].comapp_divisionSubtype.length=3;
	 	document.forms[0].comapp_divisionSubtype.options[1] = new Option('Karta','KART');
	 	document.forms[0].comapp_divisionSubtype.options[2] = new Option('Co- Parcener','COPAR');
        document.forms[0].comapp_divisionSubtype.options[3] = new Option('Members','KMEM');
	}
	
	if(concerntype=="D" ||concerntype=="PT" || concerntype=="SP" || concerntype=="OT" || concerntype=="K")
	{
		document.all.subtype1.style.visibility="visible";
		document.all.subtype1.style.position="relative";
		document.all.subtype2.style.visibility="visible";
		document.all.subtype2.style.position="relative";
	}
	else
	{
		document.all.subtype1.style.visibility="hidden";
		document.all.subtype1.style.position="relative";
		document.all.subtype2.style.visibility="hidden";
		document.all.subtype2.style.position="relative";
	}*/

	if(document.forms[0].comapp_divisiontype.value!="")
	{

		var varType=document.forms[0].comapp_divisiontype.value;
		if(varType=="D")
		{
			document.all.id_dinnumb.style.visibility="visible";
			document.all.id_dinnumb.style.position="relative";
		}
		else
		{	
			document.all.id_dinnumb.style.visibility="hidden";
			document.all.id_dinnumb.style.position="absolute";
		}

		if(varType=="O"||varType=="D"||varType=="SP"||varType=="PT"||varType=="T"||varType=="K"||varType=="PA"||varType=="OT")
		{
			document.all.pguar1.style.display="table-cell";
			document.all.pguar2.style.display="table-cell";

			document.all.idchif1.style.display="table-cell";
			document.all.idchif2.style.display="table-cell";
		}
		else
		{	
			document.all.pguar1.style.display="none";
			document.all.pguar2.style.display="none";
			
			document.all.idchif1.style.display="none";
			document.all.idchif2.style.display="none";
		}

		if(varType=="Division")
		{
			varType="193";
		}
		else if(varType=="Sister concern")
		{
			varType="194";
		}
		else if(varType=="Group concern")
		{
			varType="195";
		}
		else if(varType=="O")
		{
			varType="196";
		}
		else if(varType=="D")
		{
			varType="197";
		}
		else if(varType=="SP")
		{
			varType="198";
		}
		else if(varType=="PT")
		{
			varType="199";
		}
		else if(varType=="T")
		{
			varType="200";
		}
		else if(varType=="K")
		{
			varType="201";
		}
		else if(varType=="PA")
		{
			varType="202";
		}
		else if(varType=="OT")
		{
			varType="203";
		}
		else
		{
			varType="0";
		}
	
		document.all.ifrm.src=appURL+"action/ifrmgrpconcernsubtype.jsp?hidBeanGetMethod=getGrpConcernType&hidBeanId=commappmaster&strconcerntype="+varType+"&strSubType="+val;
	}
	else
	{
		document.forms[0].comapp_divisionSubtype.length=1;
	 	document.forms[0].comapp_divisionSubtype.options[0] = new Option('select','');
	}
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()" class="bgcolor">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmpri" method="post" class="normal">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Sister Concerns</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="9"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<% } else {  %>

<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="29" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="29"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="29"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; Sister Concerns</td>
	</tr>
  </table>
 <%} else if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
  <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Groups / Management Peoples</td>
    </tr>
  </table> 
  <%} else if(strapptype.equalsIgnoreCase("R")){ %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Groups / Management Peoples</td>
    </tr>
  </table> 
  <%} %>
<lapschoice:application />
	
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
	<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="29"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>


<% }  %>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="2"
					class="outertable">
					<tr>
						<td width="10%" nowrap="nowrap">Concern type<span
							class="mantatory">*&nbsp;</span></td>
						<td width="19%"><select name="comapp_divisiontype" size="1" onchange="concernChange('')"
							tabindex="1">
							<option Selected="selected" value="">--Select--</option>
							<option value="Division">Division</option>
							<option value="Sister concern">Sister Concern</option>
							<option value="Group concern">Group Concern</option>
							<option value="O">Share Holders</option>
							<option value="D">Directors</option>
							<option value="SP">Sole Proprietor</option>
							<option value="PT">Partner</option>
							<option value="T">Trustee</option>
							<option value="K">Karta</option>
						    <option value="PA">Power of Attorney</option>
							<option value="OT">Others</option>
						</select></td>
						
						<td width="10%" nowrap="nowrap">Concern Sub type<span class="mantatory">*&nbsp;</span></td>
						<td width="19%"><select name="comapp_divisionSubtype"
							size="1" tabindex="1">
							<option Selected="selected" value="">--Select--</option>

						</select></td>
						<td width="10%" nowrap="nowrap">Account to be operated by<span class="mantatory">*&nbsp;</span></td>
						<td width="19%">
								<select name="selaccoperby" size="1" tabindex="1">
									<option value="S" Selected>--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select>
					</td>
					</tr>
					<tr>
						<td>Customer ID</td>
						<td><input type="text" name="comapp_customer_id" maxlength="20" size="25">
						<span id="idsearch" >
						<a href="#" onClick="showCustIdSearch()" style="cursor:hand" tabindex="22">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a>
						</span>
						
						</td>
						<td width="11%">CBS Customer ID</td>
						<td align="left" width="25%"><input type="text"
							name="comapp_cbsid" size="30" maxlength="75"
							onKeyPress="notAllowSplChar()"></td>
						
						<td width="11%">Concern Name</td>
						<td align="left" width="25%"><input type="text"
							name="comapp_div_name" size="30" maxlength="75"
							onKeyPress="notAllowSplChar()"></td>
					</tr>
					<tr>
					<td rowspan="2">Address</td>
					<td rowspan="2"> <textarea
							name="comapp_div_address" cols="50" rows="4"
							style="text-align: left;" onkeypress="notAllowSplChar();textlimit(this,999)" onKeyUp="textlimit(this,999)"
							wrap="VIRTUAL">                                
                                </textarea></td>
						<td align="left" width="10%">City</td>
						<td width="19%"><input align="left" type="text"
							name="comapp_div_city" size="25" style="text-align: left;"
							onKeyPress="notAllowSplChar();allowAlphabets()">
							<input type="hidden" name="hid_city" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>">
										<a href="#" onClick="showSearchCity('SISTER')" style="cursor:hand" tabindex="22">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0"></a></td>
											
						<td>District</td>
										<td><input type="text" name="comapp_div_dist" size="25"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()">
										&nbsp;<a href="#"
													onClick="showDistSearch('SISTER');"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></a>
											<input type="hidden" name="hid_dist" size="5" value=""></td>
						</tr>
						<tr>					
						<td width="11%">State</td>
						<td width="25%"><input align="left" type="text"
							name="comapp_div_state" size="30" maxlength="30"
							style="text-align: left;" onKeyPress="notAllowSplChar();allowAlphabets()">
						<input type="hidden" size="5" name="hid_state" value="">
							
							</td>
						<td width="10%"><%=ApplicationParams.getZipName()%><font
							color="#FF0000"><b>*</b></font></td>
						<td align="left" width="25%"><input type="text"
							name="comapp_div_pin" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>"
							style="text-align: left;" onKeyPress="allowInteger()"
							OnBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
						</td>
						
					</tr>
					<tr>
					<td rowspan="2">Banker</td>
					<td rowspan="2"><textarea name="comapp_banker" cols="50" rows="4" style="text-align: left;" onkeypress="notAllowSplChar();textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL">                                
                        </textarea></td>
						<td align="left" width="10%">Phone No.</td>
						<td width="19%"><input type="text" name="comapp_div_phone"
							size="20" maxlength="20" style="text-align: left;"
							onKeyPress="allowPhone()"></td>
						<td width="11%">Fax</td>
						<td width="25%"><input type="text" name="comapp_div_fax"
							size="20" maxlength="20" style="text-align: left;"
							onKeyPress="allowPhone()"></td>
						
					</tr>
					<tr>
					<td width="10%" align="left">Relationship among themselves &nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td width="19%">
					<input type="text" name="txt_relation" size="40" style="text-align: left;" onkeypress="notAllowSplChar()">                                
                    </td>
                    <td width="11%">Document Executant &nbsp;<span
							class="mantatory">*&nbsp;</span>&nbsp;&nbsp;&nbsp;</td>
							<td width="25%">
                   <select name="sel_docexecutant" size="1" tabindex="1">
							<option Selected="selected" value="">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select>
                    </td>
					</tr>
					<tr style="display: none;">
					<td width="10%" style="display: none;">BSR Code</td>
						<td width="25%" style="display: none"><input type="hidden" name="comapp_indcode"
							size="20" maxlength="23" style="text-align: left;" value="">
						<input type="text" name="comapp_companyid" size="30"
							maxlength="15" style="text-align: left;"
							onKeyPress="notAllowSpace()" tabindex="7">
						<b><span onClick="callDescHelp('systerconcern')"
							style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex="7"></span></b></td>
					</tr>
					<tr id="id_dinnumb">
						<td> DIN number  &nbsp;<span class="mantatory">*&nbsp;</span></td>
						<td> <input type="text" name="txt_DINnumber"> </td> 
					</tr>	
					<tr id="">
						<td id="idchif1"> Chief Promoter &nbsp;<span class="mantatory">*&nbsp;</span></td>
						<td id="idchif2"> 
							<select name="sel_chf_promoter">
								<option value="" selected>--Select--</option>
								<option value="Y">Yes</option>
								<option value="N">No</option>
							</select>
				 		</td> 
						<td>Group/associate entities of promoter(s) have been into NPA category in past 1 year	
						 &nbsp;<span class="mantatory">*&nbsp;</span></td>
						<td> 
							<select name="sel_chk_npa">
								<option value="" selected>--Select--</option>
								<option value="Y">Yes</option>
								<option value="N">No</option>
							</select>
				 		</td> 
					</tr>
					<tr>
				 		<td id="pguar1"> Whether Personal Guarantee Available &nbsp;<span class="mantatory">*&nbsp;</span></td>
						<td id="pguar2"> 
							<select name="sel_personal_guarantee">
								<option value="" selected>--Select--</option>
								<option value="Y">Yes</option>
								<option value="N">No</option>
							</select>
				 		</td> 
					</tr>	
				</table>
				</td>
			</tr>
			<tr>
				<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
										<tr class="dataHeader">
										<td align="left" colspan="3">Rating Details</td>
										</tr>
										<tr>
										<td align="center" width="30%">Rating Grade</td>
										<td align="center" width="30%">Rating as on</td>
										<td align="center" width="30%">Rating Type</td>
										</tr>
										<tr>
										<td align="center"><input type="text" name="txt_ratinggrade1" onkeypress=""   maxlength="55" value="<%=Helper.correctNull((String)hshValues.get("txt_ratinggrade1")) %>"></td>
										<td align="center" nowrap><input type="text" name="txt_ratingdate1"
										size="12" TABINDEX="6" maxlength="10"
										value="<%=Helper.correctNull((String) hshValues.get("txt_ratingdate1"))%>"
										onBlur="checkDate(this);">
											<a alt="Select date from calender"
												href="javascript:callCalender('txt_ratingdate1')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												width="21" height="18" border="0"></a></td>
										<td align="center"><select name="rating_type1">
										<option value="s" selected>--Select--</option>
										<option value="A">Audited</option>
										<option value="E">Estimated</option>
										<option value="U">Unaudited</option>
										<option value="P">Projection</option>
										</select></td>
										</tr>
<!--										<tr>-->
<!--										<td align="center"><input type="text" name="txt_ratinggrade2"   maxlength="55" onkeypress="" value="<%=Helper.correctNull((String)hshValues.get("txt_ratinggrade2")) %>"></td>-->
<!--											<td align="center" nowrap><input type="text" name="txt_ratingdate2"-->
<!--												size="12" TABINDEX="6" maxlength="10"-->
<!--												value="<%=Helper.correctNull((String) hshValues.get("txt_ratingdate2"))%>"-->
<!--												onBlur="checkDate(this);">-->
<!--											<a alt="Select date from calender"-->
<!--												href="javascript:callCalender('txt_ratingdate2')"><img-->
<!--												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"-->
<!--												width="21" height="18" border="0"></a></td>-->
<!--										<td align="center"><select name="rating_type2">-->
<!--										<option value="s" selected>--Select--</option>-->
<!--										<option value="A">Audited</option>-->
<!--										<option value="E">Estimated</option>-->
<!--										<option value="U">Unaudited</option>-->
<!--										<option value="P">Projection</option>-->
<!--								</select></td>-->
<!--							</tr>-->
							</table>
						</td>
					</tr>
		</table>
		<br>
	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
		
		<lapschoice:combuttonnew
			btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<% }  else { %>
		
	<div style="display: none; ">
		<lapschoice:combuttonnew
			btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	</div>		
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } %>
	
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="98.3%" border="0" cellspacing="1" cellpadding="3" align="center"
					class="outertable">
					<tr align="center" class="dataheader">
						<td width="3.3%">S.no</td>
						<td width="30%">Concern Name</td>
						<td width="10%">Customer ID</td>
						<td width="25%">Concern Type</td>
						<td width="25%">Concern Sub Type</td>
						<td width="30%">Group Name</td>
						<td width="10%">Document Executant</td>
<!--						<td width="15%">City</td>-->
<!--						<td width="15%">State</td>-->
					</tr>
					<%if (vecRow!=null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
					<tr class="datagrid">
						<td align="center"><%=i+1%></td>
						<td><b><a
							href="javascript:selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(1))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(3))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(4))%>','<%=Helper.correctNull((String)vecCol.get(5))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(6))%>','<%=Helper.correctNull((String)vecCol.get(7))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(8))%>','<%=Helper.correctNull((String)vecCol.get(9))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(10))%>','<%=Helper.correctNull((String)vecCol.get(11))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(12))%>','<%=Helper.correctNull((String)vecCol.get(13))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(14))%>','<%=Helper.correctNull((String)vecCol.get(15))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(16))%>','<%=Helper.correctNull((String)vecCol.get(17))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(18))%>','<%=Helper.correctNull((String)vecCol.get(19))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(20))%>','<%=Helper.correctNull((String)vecCol.get(21))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(22))%>','<%=Helper.correctNull((String) vecCol.get(23))%>'
                            	,'<%=Helper.correctNull((String) vecCol.get(24))%>','<%=Helper.correctNull((String) vecCol.get(25))%>'
			                 	,'<%=Helper.correctNull((String) vecCol.get(26))%>','<%=Helper.correctNull((String) vecCol.get(27))%>',
                            	'<%=Helper.correctNull((String) vecCol.get(28))%>','<%=Helper.correctNull((String) vecCol.get(29))%>',
                            	'<%=Helper.correctNull((String) vecCol.get(30))%>','<%=Helper.correctNull((String) vecCol.get(31))%>'
                            	,'<%=Helper.correctNull((String) vecCol.get(32))%>')">
						<%=Helper.correctNull((String) vecCol.get(1)).toUpperCase()%></a></b></td>
						<td  align="center"><%=Helper.correctNull((String) vecCol.get(22))%><input type="hidden" name="txt_hidcbsid" value="<%=Helper.correctNull((String) vecCol.get(22))%>"></td>
						<%
						String strTemp="";
						if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("O")) {strTemp="Share Holders";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("D")) {strTemp="Directors";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("SP")) {strTemp="Sole Proprietor";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("PT")) {strTemp="Partner";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("OT")) {strTemp="Others";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("T")) {strTemp="Trustee";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("K")) {strTemp="Karta";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("PA")) {strTemp="Power of Attorney";}
						else{strTemp=Helper.correctNull((String) vecCol.get(10)); } %>
						<td><%=strTemp%></td>
						<td><%=Helper.correctNull((String) vecCol.get(29))%></td>
						<td><%=Helper.correctNull((String) vecCol.get(23))%></td>
						<td align="center"><%if(Helper.correctNull((String) vecCol.get(26)).equalsIgnoreCase("Y")){%>Yes<%}else{ %>No<%} %></td>
<!--						<td width="15%"><%//=Helper.correctNull((String) vecCol.get(4))%></td>-->
<!--						<td width="15%"><%//=Helper.correctNull((String) vecCol.get(6))%></td>-->
					</tr>

					<%}%>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
<!--						<td width="15%">&nbsp;</td>-->
<!--						<td width="15%">&nbsp;</td>-->
					</tr>
				</table>
				</td>
			</tr>

			<%} else {%>
			<tr class="datagrid">
				<td align="center" colspan="5">No Data Found</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>

<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="comapp_sno" value=""> 
	
	<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>">
	<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>"> 
	
	<input type="hidden" name="comapp_div_id"
	value="<%=Helper.correctNull((String)hshValues.get("comapp_div_id"))%>">
<input type="hidden" name="exist"
	value="<%=Helper.correctNull((String)hshValues.get("existing"))%>">
<input type="hidden" name="scode" value="yy"> <input
	type="hidden" name="hiddivcity"> <input type="hidden"
	name="hiddivstate"> <input type="hidden" name="hidappexist"
	value="<%=Helper.correctNull((String)request.getParameter("hidappexist"))%>">
		<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
			<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
		<% } %>
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">  
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
<input type="hidden" name="hid_grpname"	value="">
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe>
</form>
</body>
</html>
