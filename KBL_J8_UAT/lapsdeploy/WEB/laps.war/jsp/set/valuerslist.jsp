<%@ include file="../share/directives.jsp"%>
<%
ArrayList g1 =  new ArrayList();
String strFromLink = Helper.correctNull((String)request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String)hshValues.get("svalue"));
String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
String reappraisalowner = Helper.correctNull((String)hshValues.get("nameidapp"));
%>
<html>
<title>LAPS ::: Valuers List</title>
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
var reappraisalowne = "<%=reappraisalowner%>";
	
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
	document.forms[0].hidBeanGetMethod.value="getValuerMasterList";
	document.forms[0].stype.value ="N" ;
	document.forms[0].svalue.value = document.forms[0].txt_ser.value;
	document.forms[0].action=appUrl+"action/valuerslist.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function getSelectedValue(val1, val2, val3, val4, val5, val6, val7, val8, val9, val10, val11, val12, val13, 
val14, val15, val16, val17, val18, val19, val20, val21, val22, val23, val24, val25, val26,val27,val28,val29,val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,val40)
{	
	//alert(val31);
	var valappraiser = document.forms[0].appraiser.value;
	if(document.forms[0].appraiser.value == "")
	{
	if(from_link == "ValuersMaster1" || from_link == "ValuersMaster")
	{
		if(val22=="Y")
		{			
			alert(val3 +" is Blacked List");
			if(from_link == "ValuersMaster1")
			{	
				window.opener.ClearFields();
				window.opener.clearrows("idorgName");
				window.opener.document.forms[0].hidbranchCode.value = val1;
				//window.opener.document.forms[0].hidExorgcode.value = val1;
				window.opener.document.forms[0].hidbranchname.value = val32;
				window.opener.orgnamesearchdisp(val38,val39,val40);

				if(val33!="")
				{
					var str_type_temp=val33.split("@");
					for(var i=0;i<str_type_temp.length-1;i++)
					{
						var selValue=str_type_temp[i];
						for(var j=0;j<window.opener.document.forms[0].sel_securitytype.options.length;j++)
						{
							if((window.opener.document.forms[0].sel_securitytype.options[j].value)==selValue)
							{
								window.opener.document.forms[0].sel_securitytype.options[j].selected=true;
							}
						}
					}
				}
				if(val35!="")
				{
					window.opener.clearrows("tabid_locvalued");
					window.opener.document.forms[0].hidValuerLocation.value = val35;
					window.opener.addLocValuedDisp();
				}
				else
				{
					window.opener.clearrows("tabid_locvalued");
				}
			}		
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].hidmastid.value = val2;
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;		
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_zip1.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;		
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
			window.opener.document.forms[0].txt_emailid.value = val18;
			window.opener.document.forms[0].hidseqno.value = val26;
			if(val23== "01/01/1900")
			{
				val23="";
			}
			window.opener.document.forms[0].txt_empaneledon.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			if(val22=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
			}
			else
			{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
			}
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
			window.opener.document.forms[0].sel_CategoryCode.value = val34;
				
			if(window.opener.document.appform.sel_blacklist.value=="Y")
	        {
				window.opener.document.all.t1.style.visibility="Visible";
				window.opener.document.all.t2.style.visibility="Visible";	
				if(window.opener.document.appform.txt_blacklistdate.value=="01/01/1900")
				{
					window.opener.document.appform.txt_blacklistdate.value="";
				}
			}
	        else if(window.opener.document.appform.sel_blacklist.value=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";			
			}
			window.opener.enableButtons(true, true, true, true, true);
			window.close();
		}
		else
		{
			if(from_link == "ValuersMaster1")
			{	
				window.opener.ClearFields();
				window.opener.clearrows("idorgName");
				window.opener.document.forms[0].hidbranchCode.value = val1;
				//window.opener.document.forms[0].hidExorgcode.value = val1;
				window.opener.document.forms[0].hidbranchname.value = val32
				window.opener.orgnamesearchdisp(val38,val39,val40);

				if(val33!="")
				{
					var str_type_temp=val33.split("@");
					for(var i=0;i<str_type_temp.length-1;i++)
					{
						var selValue=str_type_temp[i];
						for(var j=0;j<window.opener.document.forms[0].sel_securitytype.options.length;j++)
						{
							if((window.opener.document.forms[0].sel_securitytype.options[j].value)==selValue)
							{
								window.opener.document.forms[0].sel_securitytype.options[j].selected=true;
							}
						}
					}
				}
				if(val35!="")
				{
					window.opener.clearrows("tabid_locvalued");
					window.opener.document.forms[0].hidValuerLocation.value = val35;
					window.opener.addLocValuedDisp();
				}
				else
				{
					window.opener.clearrows("tabid_locvalued");
				}
			}
			window.opener.document.forms[0].hidsno.value = val2;
			window.opener.document.forms[0].hidmastid.value = val2;
			window.opener.document.forms[0].txt_name.value=val3;
			window.opener.document.forms[0].txt_address1.value=val4;		
			window.opener.document.forms[0].txt_address2.value = val5;	
			window.opener.document.forms[0].txt_address3.value = val6;			
			window.opener.document.forms[0].hidcity.value = val7;
			window.opener.document.forms[0].hidstate.value = val8;
			window.opener.document.forms[0].txt_zip.value = val9;
			window.opener.document.forms[0].txt_zip1.value = val9;
			window.opener.document.forms[0].txt_country.value = val10;		
			window.opener.document.forms[0].txt_offphone.value = val11;		
			window.opener.document.forms[0].txt_offfaxno.value = val12;
			window.opener.document.forms[0].txt_resphone.value = val13;
			window.opener.document.forms[0].txt_resmobileno.value = val14;
			window.opener.document.forms[0].txt_contactperson.value = val15;
			window.opener.document.forms[0].txt_contactmobilephone.value = val16;
			window.opener.document.forms[0].txt_emailid.value = val18;
			if(val23== "01/01/1900")
			{
				val23="";
			}
			window.opener.document.forms[0].txt_empaneledon.value = val19;
			window.opener.document.forms[0].txt_action.value = val20;		
			window.opener.document.forms[0].txt_comments.value = val21;	
			window.opener.document.forms[0].txt_desig1.value = val17;
			window.opener.document.forms[0].sel_blacklist.value = val22;
			window.opener.document.forms[0].txt_city.value = val24;
			window.opener.document.forms[0].txt_state.value = val25;
			window.opener.document.forms[0].hidseqno.value = val26;
			if(val22=="N")
			{
				window.opener.document.all.t1.style.visibility="hidden";	
				window.opener.document.all.t2.style.visibility="hidden";		
				window.opener.document.forms[0].txt_blacklistdate.value ="";
			}
			else
			{
				window.opener.document.forms[0].txt_blacklistdate.value = val23;		
			}
			window.opener.document.forms[0].txt_sancrefno.value = val27;	
			window.opener.document.forms[0].txt_expdateofsanc.value = val28;
			window.opener.document.forms[0].txt_detofsecdep.value = val29;
			window.opener.document.forms[0].txt_dofjewelappr.value = val30;
			window.opener.document.forms[0].txt_cbscustid.value = val31;
			window.opener.document.forms[0].sel_CategoryCode.value = val34;
			
			window.opener.enableButtons(true, false, true, true, false);
			window.close();
		}	
	}
	else if(from_link == "ValuerEntry")
	{
	
		if(val22=="Y")
		{
			alert(val3 +" is Blacked List");
			window.opener.document.forms[0].hidsno.value = "";
			window.opener.document.forms[0].hidmastid.value = "";
			window.opener.document.forms[0].txt_name.value="";		
			return;
		}
		else
		{			
			window.opener.document.forms[0].hidsno.value = val26;
			window.opener.document.forms[0].hidmastid.value = val26;
			window.opener.document.forms[0].txt_name.value=val3;		
			window.close();
		}	
	}	
	}
	else
	{
	if(document.forms[0].appraiser.value == "appraiser")
	{
		if(val20=="2" || eval(val36)<0)
		{
			alert("Jewel Appraiser Empanelment expired/Disabled in Masters");
			return;
		}
		if(eval(val36)<=90)
		{
			alert("Jewel appraiser empanelment is expiring on "+val37+". Kindly renew the same within the due date.");
		}
		window.opener.document.forms[0].txt_appraisername.value = val3;
		window.opener.document.forms[0].hidAppraiserID.value = val31;
	}else if(document.forms[0].appraiser.value == "reappraiser") 
	{
		if(val20=="2" || eval(val36)<0)
		{
			alert("Jewel Appraiser Empanelment expired/Disabled in Masters");
			return;
		}
		if(eval(val36)<=90)
		{
			alert("Jewel appraiser empanelment is expiring on "+val37+". Kindly renew the same within the due date.");
		}
	    if(reappraisalowne==val31)
	    {
		    alert("Jewel appraiser who has originally done appraisal cannot reappraise");
		    return;
	    }
	    else
	    {
		window.opener.document.forms[0].txt_appraisername.value = val3;
        window.opener.document.forms[0].txt_appraisernameid.value = val31;
	    }

	}
	}
	window.close();
}
	function doClose()
	{
		window.close();
	}


	function callOnload(){
		  
           <%if(Helper.correctNull((String)request.getParameter("hidAppVal")).equalsIgnoreCase("J")){%>
           		document.all.idcbsrad.style.display="table-cell";
           <%}else{%>
          		 document.all.idcbsrad.style.display="none";
          		document.forms[0].rad[0].checked=true;
           <%}%>
        
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
              <td><input type="radio" name="rad" onClick="" style="border-style: none" value="Name">&nbsp;Appraiser Name</td>
              <td id="idcbsrad"><input type="radio" name="rad" onClick="" style="border-style: none" value="CBSID">&nbsp;CBS ID</td>
                              
                      
                  <td width="20%" id="cell_appraisername1"> 
                    <input type="text" name="txt_ser" maxlength="50" size = "20" value="<%=strvalue%>" onKeyPress="notAllowSplChar()" 
                    onblur="radioCheck()">
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
                 	     <td width="15%">Sl. No.</td>
                 	     <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{%>
						<td width="15%">CBS ID</td>
						<%} %>
                 	     <td width="60%">Appraiser /Valuer Name</td>
               	  		 <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
						{%>
						<td width="20%">Category Code</td>
						<%} %>
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
						if(strFromLink.equalsIgnoreCase("ValuersMaster"))
						{
						%>
		                  <tr class="datagrid">
		                    <td  width="15%">
		                    <%=l+1%>&nbsp;</td>
		                    <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{%>
						<td width="15%"><%=Helper.correctNull((String)g1.get(30))%></td>
						<%} %>
		                    <td width="60%" ><a href="javascript:getSelectedValue(
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(0))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(1))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(2))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(3))))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(4))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(5))))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(6))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(7))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(8))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(9))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(10))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(11))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(12))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(13))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(15))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(16))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(17))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(18))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(19))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(20))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(21))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(22))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(23))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(24))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(25))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(26))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(27))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(28))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(29))%>','<%=Helper.correctNull((String)g1.get(30))%>'
								,'<%=Helper.correctNull((String)g1.get(31))%>','<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>','<%=Helper.correctNull((String)g1.get(34))%>'
								,'<%=Helper.correctNull((String)g1.get(37))%>','<%=Helper.correctNull((String)g1.get(27))%>'
								,'<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>','<%=Helper.correctNull((String)g1.get(40))%>'
								
								)" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
						
							<% if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
							{%>
							<td width="20%"><%=Helper.correctNull((String)g1.get(33))%></td>
							<%} %>	
								
		                  </tr>
		                  <%
						}
						else
						{
							if(!Helper.correctNull((String)g1.get(19)).equalsIgnoreCase(""))
							{
						%>
							<tr class="datagrid">
		                    <td  width="15%">
		                    <%=++i%>&nbsp;</td>
		                         <%
                 	     if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("J"))
						{ %>
						<td width="15%"><%=Helper.correctNull((String)g1.get(30))%></td>
						<%} %>
		                    <td width="60%" ><a href="javascript:getSelectedValue(
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(0))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(1))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(2))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(3))))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(4))))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(((String)g1.get(5))))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(6))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(7))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(8))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(9))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(10))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(11))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(12))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(13))%>',
		                    	'<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(14)))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(15))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(16))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(17))%>',
		                    	'<%=Helper.replaceForJavaScriptString((String)g1.get(18))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(19))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(20))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(21))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(22))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(23))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(24))%>', '<%=Helper.replaceForJavaScriptString((String)g1.get(25))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(26))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(27))%>',
								'<%=Helper.replaceForJavaScriptString((String)g1.get(28))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(29))%>',
								'<%=Helper.correctNull((String)g1.get(30))%>','<%=Helper.correctNull((String)g1.get(31))%>',
								'<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>',
								'<%=Helper.correctNull((String)g1.get(34))%>','<%=Helper.correctNull((String)g1.get(37))%>','<%=Helper.correctNull((String)g1.get(27))%>'
								,'<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>','<%=Helper.correctNull((String)g1.get(40))%>')" align="center"><b><%=Helper.correctNull((String)g1.get(2))%></b></a></td>
		                
		                <% if(Helper.correctNull((String)hshValues.get("hidAppVal")).equalsIgnoreCase("V"))
							{%>
							<td width="20%"><%=Helper.correctNull((String)g1.get(33))%></td>
							<%} %>	
		                  </tr>
						<%
							}
						}
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
<input type ="hidden" name="strfrom" value="<%=strFromLink%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type ="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>">
<input type ="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="hidAppVal" value="<%=Helper.correctNull((String)request.getParameter("hidAppVal"))%>">
<input type="hidden" name="appraiser" value="<%=Helper.correctNull((String)hshValues.get("appraiser"))%>">

</form>
</body>
</html>

