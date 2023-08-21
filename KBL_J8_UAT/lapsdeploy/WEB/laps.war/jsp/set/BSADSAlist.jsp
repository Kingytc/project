<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
%>
<html>
<title>LAPS ::: BSA / DSA List</title>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
	
function onselect1()
{
	if (document.forms[0].selradio[0].checked==true)
	{
		document.forms[0].stype.value = document.forms[0].selradio[0].value
	}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
}
	
function searchData()
{
	if (trim(document.forms[0].txt_ser.value)=="")
	{
		alert("Enter Search Text");
		return;
	}	
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getBSADSAList";
	document.forms[0].stype.value ="N" ;
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/BSADSAlist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, 
val14, val15, val16, val17, val18, val19, val20, val21, val22, val23, val24, val25, val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,val40,val41,val42,val43,
val44,val45,val46,val47,val48,val49,val50,val51,val52,val53,val54,val55,val56,val57,val58,val59,val60,val61,val62,val63,val64,val65,val66,val67,val68)
{	
	if(from_link == "BSADSAmaster")
	{
		window.opener.ClearFields();
			window.opener.document.forms[0].hidAgentID.value = val2;
			window.opener.document.getElementById("idagentid").innerHTML=val2;
			
			window.opener.document.forms[0].txt_name.value = val3;
			window.opener.document.forms[0].hidapp_name.value = val3;
			window.opener.document.forms[0].txt_address1.value = val4;
			window.opener.document.forms[0].txt_address2.value = val5;
			window.opener.document.forms[0].txt_city.value = val6;
			window.opener.document.forms[0].txt_state.value=val7;
			window.opener.document.forms[0].txt_country.value=val8;		
			window.opener.document.forms[0].txt_zip.value = val9;	
			window.opener.document.forms[0].sel_applt_constitutionnew.value = val10;			
			window.opener.document.forms[0].txt_nonindname.value = val11;
			window.opener.document.forms[0].txt_mobile.value = val12;
			window.opener.document.forms[0].txt_telephone.value = val13;
			window.opener.document.forms[0].txt_email.value = val14;
			window.opener.document.forms[0].txt_pannum.value = val15;		
			window.opener.document.forms[0].txt_keyperson.value = val16;		
			window.opener.document.forms[0].txt_designkeyperson.value = val17;
			window.opener.document.forms[0].sel_banktype.value = val18;
			window.opener.document.forms[0].txt_bankname.value = val19;
			window.opener.document.forms[0].txt_branch.value = val20;
			window.opener.document.forms[0].txt_ifsccode.value = val21;
			window.opener.document.forms[0].txt_accno.value = val22;
			window.opener.document.forms[0].txt_empaneldet.value = val23;
			window.opener.document.forms[0].txt_empaneledon.value = val24;
			window.opener.document.forms[0].txt_empanelsince.value = val25;		
			window.opener.document.forms[0].txt_expirydate.value = val26;
			window.opener.document.forms[0].sel_action.value = val27;
			window.opener.document.forms[0].txt_reference.value = val28;
			window.opener.document.forms[0].txt_dob.value = val29;

			window.opener.document.forms[0].sel_whtempanalled.value = val30;
			window.opener.document.forms[0].txt_pastexp.value = val31;
			window.opener.document.forms[0].sel_officepremises.value = val32;
			window.opener.document.forms[0].txt_regis.value = val33;
/*
			var bankname_temp =val34.split("@");	
			for(var i=1;i<bankname_temp.length-1;i++)
			{
				var selValue=bankname_temp[i];
				for(var j=0;j<window.opener.document.forms[0].sel_bankname.options.length;j++)
				{
					if(window.opener.document.forms[0].sel_bankname.options[j].value==selValue)
					{
						window.opener.document.forms[0].sel_bankname.options[j].selected=true;
					}
				}		
			}
			var dsaservices_temp =val35.split("@");	
			for(var i=1;i<dsaservices_temp.length-1;i++)
			{
				var selValue=dsaservices_temp[i];
				for(var j=0;j<window.opener.document.forms[0].sel_dsaservice.options.length;j++)
				{
					if(window.opener.document.forms[0].sel_dsaservice.options[j].value==selValue)
					{
						window.opener.document.forms[0].sel_dsaservice.options[j].selected=true;
					}
				}		
			}
			*/
			if(val1=="BSA")
			{
				window.opener.BSAfields();
				window.opener.whetheremp();
			}
			else
			{
				window.opener.DSAfields();	
			}
			window.opener.nonindvFields();
			
			window.opener.document.forms[0].hidreraregnodisp.value = val36;
			window.opener.reraregnodisp();	

			window.opener.document.forms[0].hidbanknamedisp.value = val34;
			window.opener.document.forms[0].hidbankcodedisp.value = val37;
			window.opener.document.forms[0].hidempdatedisp.value = val25;
			window.opener.banknamedisp();	
			
			window.opener.document.forms[0].hiddsaservbankdisp.value = val35;
			window.opener.document.forms[0].hiddsaservcodedisp.value = val38;
			window.opener.dsaservbankdisp();	

			window.opener.document.forms[0].txt_referenceno.value = val39;

			window.opener.document.forms[0].hidcity.value = val40;
			window.opener.document.forms[0].hidstate.value = val41;
			window.opener.document.forms[0].hidperapp_country.value = val42;
			window.opener.document.forms[0].hid_LeadBankcode.value = val43;
			window.opener.document.forms[0].sel_region.value = val44;
			window.opener.document.forms[0].sel_type.value = val45;
			window.opener.document.forms[0].txt_dealershipregno.value = val46;
			window.opener.document.forms[0].txt_regdatefrom.value = val47;
			window.opener.document.forms[0].txt_regdateto.value = val48;
			window.opener.document.forms[0].txtfield1.value = val49;
			window.opener.document.forms[0].txtfield2.value = val50;
			window.opener.document.forms[0].txtfield3.value = val51;
			window.opener.document.forms[0].txtfield4.value = val52;
			window.opener.document.forms[0].txtfield5.value = val53;
			window.opener.document.forms[0].masterfield1.value = val54;
			window.opener.document.forms[0].masterfield2.value = val55;
			window.opener.document.forms[0].masterfield3.value = val56;
			window.opener.document.forms[0].masterfield4.value = val57;
			window.opener.document.forms[0].masterfield5.value = val58;
			window.opener.document.forms[0].txtfieldval1.value = val59;
			window.opener.document.forms[0].txtfieldval2.value = val60;
			window.opener.document.forms[0].txtfieldval3.value = val61;
			window.opener.document.forms[0].txtfieldval4.value = val62;
			window.opener.document.forms[0].txtfieldval5.value = val63;
			window.opener.document.forms[0].selmasterfield1.value = val64;
			window.opener.document.forms[0].selmasterfield2.value = val65;
			window.opener.document.forms[0].selmasterfield3.value = val66;
			window.opener.document.forms[0].selmasterfield4.value = val67;
			window.opener.document.forms[0].selmasterfield5.value = val68;

			
			window.opener.enableButtons(true, false, true, true, true);
			window.close();
	}
	else if(from_link == "LAR")
	{
		var expirydate=val26;
		var currentdate=currdate;

		var expirydt=expirydate.substring(0,2);
		var expirymon=expirydate.substring(3,5);
		var expiryyr=expirydate.substring(6,10);
		var currdt=currentdate.substring(0,2);
		var currmon=currentdate.substring(3,5);
		var curryr=currentdate.substring(6,10);
		var currdatenew=new Date(curryr,currmon,currdt);
		var expirydatenew=new Date(expiryyr,expirymon,expirydt);
		var datediff=expirydatenew - currdatenew;
		var daydiff=datediff/(60*60*24*1000);
		if(daydiff<0)
		{
			alert("Agent's Validity expired");
			return;
		}

		window.opener.document.forms[0].hidAgentID.value = val2;
		window.opener.document.forms[0].txt_name.value = val3;
		window.opener.document.forms[0].sel_leadregion.value = val44;
		window.close();
	}	

	window.close();
}

function doClose()
	{
		window.close();
	}


	function callOnload()
	{
		  
                  
	}

	function radioCheck(){
		 if(document.forms[0].rad[0].checked==false && document.forms[0].rad[1].checked==false ){
			 alert("Please Select Either Appraiser Name or CBSID");
			 return;
		 }
	}
		
</SCRIPT>
</head>
<body onload="callOnload()">
	<form name="productlisthelp" method="post" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td> <br>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
          <tr> 
            <td>Search By 
             
              
              
              <table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable" align="center">
              
              <tr> 
              <td><input type="radio" name="rad" onClick="" style="border-style: none" value="Name">&nbsp;BSA / DSA Name</td>

                  <td width="20%" id="cell_appraisername1"> 
                    <input type="text" name="txt_ser" maxlength="50" size = "20" value="<%=strvalue%>" onKeyPress="notAllowSplChar()" 
                    onblur="">
                  </td>
                  
                  
                  <td width="20%" align = "center" > 
                    <input type=button  class="buttonStyle"  value="Search" name="search" tabindex="20" onClick="searchData()">
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                      <tr class="dataheader"> 
                 	     <td width="10%">Sl. No.</td>
                 	     <td width="20%">Agent ID</td>
                 	     <td width="70%">BSA/DSA/OTHER's Name</td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
                <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
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
						%>
		                  	<tr class="datagrid">
		                    <td width="10%"><%=l+1%></td>
		                    <td width="20%"><a href="javascript:getSelectedValue(
		                    	'<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
		                    	'<%=Helper.correctNull(Helper.correctNull(((String)g1.get(2))))%>','<%=Helper.correctNull(Helper.correctNull(((String)g1.get(3))))%>',
		                    	'<%=Helper.correctNull(Helper.correctNull(((String)g1.get(4))))%>','<%=Helper.correctNull(Helper.correctNull(((String)g1.get(5))))%>',
		                    	'<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.correctNull((String)g1.get(7))%>',
		                    	'<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
		                    	'<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
		                    	'<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
		                    	'<%=Helper.correctNull(Helper.correctNull((String)g1.get(14)))%>','<%=Helper.correctNull((String)g1.get(15))%>',
		                    	'<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
		                    	'<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
								'<%=Helper.correctNull((String)g1.get(20))%>', '<%=Helper.correctNull((String)g1.get(21))%>',
								'<%=Helper.correctNull((String)g1.get(22))%>', '<%=Helper.correctNull((String)g1.get(23))%>',
								'<%=Helper.correctNull((String)g1.get(24))%>', '<%=Helper.correctNull((String)g1.get(25))%>',
								'<%=Helper.correctNull((String)g1.get(26))%>','<%=Helper.correctNull((String)g1.get(27))%>',
								'<%=Helper.correctNull((String)g1.get(28))%>','<%=Helper.correctNull((String)g1.get(29))%>',
								'<%=Helper.correctNull((String)g1.get(30))%>','<%=Helper.correctNull((String)g1.get(31))%>',
								'<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>',
								'<%=Helper.correctNull((String)g1.get(34))%>','<%=Helper.correctNull((String)g1.get(35))%>',
								'<%=Helper.correctNull((String)g1.get(36))%>','<%=Helper.correctNull((String)g1.get(37))%>',
								'<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>',
								'<%=Helper.correctNull((String)g1.get(40))%>','<%=Helper.correctNull((String)g1.get(41))%>',
								'<%=Helper.correctNull((String)g1.get(42))%>','<%=Helper.correctNull((String)g1.get(43))%>',
								'<%=Helper.correctNull((String)g1.get(44))%>','<%=Helper.correctNull((String)g1.get(45))%>',
								'<%=Helper.correctNull((String)g1.get(46))%>','<%=Helper.correctNull((String)g1.get(47))%>',
								'<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)g1.get(48)))%>','<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)g1.get(49)))%>',
								'<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)g1.get(50)))%>','<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)g1.get(51)))%>',
								'<%=Helper.replcaeNewLine(Helper.correctDoubleQuotesHtml((String)g1.get(52)))%>','<%=Helper.correctNull((String)g1.get(53))%>',
								'<%=Helper.correctNull((String)g1.get(54))%>','<%=Helper.correctNull((String)g1.get(55))%>',
								'<%=Helper.correctNull((String)g1.get(56))%>','<%=Helper.correctNull((String)g1.get(57))%>',
								'<%=Helper.correctNull((String)g1.get(58))%>','<%=Helper.correctNull((String)g1.get(59))%>',
								'<%=Helper.correctNull((String)g1.get(60))%>','<%=Helper.correctNull((String)g1.get(61))%>',
								'<%=Helper.correctNull((String)g1.get(62))%>','<%=Helper.correctNull((String)g1.get(63))%>',
								'<%=Helper.correctNull((String)g1.get(64))%>','<%=Helper.correctNull((String)g1.get(65))%>',
								'<%=Helper.correctNull((String)g1.get(66))%>','<%=Helper.correctNull((String)g1.get(67))%>')"
								 align="center"><b><%=Helper.correctNull((String)g1.get(1))%></b></a></td>
		                    <td width="70%"><%=Helper.correctNull((String)g1.get(2))%></td>
		                  </tr>
		                  <%
				     }
				}
					if (inside.equals("N"))
					{
						%>
					 <tr class="datagrid">
                        <td width="15%">&nbsp;</td>
                        <td width="85%">&nbsp;</td>
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
                      <tr class="datagrid">
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                      </tr>                 
                  <%}%>
                </table>
              </div>
        </table>
      </td>
    </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type ="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>">
<input type ="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>">
<input type ="hidden" name="strScode" value="<%=Helper.correctNull((String)hshValues.get("strLeadScode"))%>">
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="hidAppVal" value="<%=Helper.correctNull((String)request.getParameter("hidAppVal"))%>">
<input type="hidden" name="appraiser" value="<%=Helper.correctNull((String)hshValues.get("appraiser"))%>">

</form>
</body>
</html>

