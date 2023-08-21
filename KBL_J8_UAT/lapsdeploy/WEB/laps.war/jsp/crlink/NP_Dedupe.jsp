<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />  
<lapschoice:handleerror />
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

ArrayList arrRow = (ArrayList)hshValues.get("arrRow"); 
ArrayList arrCol=new ArrayList();

ArrayList arrRow1 = (ArrayList)hshValues.get("arrRow1"); 
ArrayList arrCol1=new ArrayList();

String strDedupeflag=Helper.correctNull((String)hshValues.get("strDedupeflag"));
String strActionflag=Helper.correctNull((String)hshValues.get("strActionflag"));
String strSegment=Helper.correctNull((String)hshValues.get("strSegment"));

%>

<html>
<head>
<title>National Portal  - Dedupe Check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
<script><!--	
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varselnew ="<%=Helper.correctNull((String)hshValues.get("NP_ISNEW"))%>";

function doClose()
{
	window.close();
}	

function doDedupe(val1,val2,val3,val4,val5,dif,col,valname)
{
	document.forms[0].hid_dob.value=val1;
	document.forms[0].hid_dr.value=val2;
	document.forms[0].hid_adhar.value=val3;
	document.forms[0].hid_pan.value=val4;
	document.forms[0].hid_voter.value=val5;

	if(dif == 'coapp1')
	{
		document.forms[0].hid_sel1.value=document.forms[0].sel_New1.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_coapp_vi1.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_coapp_cbs1.value;
		
	}else if(dif == 'coapp2')
	{
		document.forms[0].hid_sel1.value=document.forms[0].sel_New2.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_coapp_vi2.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_coapp_cbs2.value;
		
	}else {
		document.forms[0].hid_sel1.value=document.forms[0].sel_New.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_vi.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_cbs.value;
	}
	document.forms[0].hid_dif.value=dif;
	document.forms[0].hid_col.value=col;
	document.forms[0].hid_name.value=valname;	
	document.forms[0].hid_dedupe.value="D";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="updateNPDedupeChk";
	document.forms[0].action=appURL+"action/NP_Dedupe.jsp";
	document.forms[0].submit();
}

function calplacevalue(val6,val7,dif,col)
{
	
		if(dif == 'coapp1')
		{
			document.forms[0].txt_coapp_vi1.value = val6;
			document.forms[0].txt_coapp_vi1.readOnly=true;
			document.forms[0].txt_coapp_cbs1.value = val7;
			document.forms[0].txt_coapp_cbs1.readOnly=true;
			document.forms[0].sel_New1.value = "N";
			document.forms[0].sel_New1.disabled=true;
			
		}else if(dif == 'coapp2')
		{
			
			document.forms[0].txt_coapp_vi2.value = val6;
			document.forms[0].txt_coapp_vi2.readOnly=true;
			document.forms[0].txt_coapp_cbs2.value = val7;
			document.forms[0].txt_coapp_cbs2.readOnly=true;
			document.forms[0].sel_New2.value = "N";
			document.forms[0].sel_New2.disabled=true;
			
		}else {
			document.forms[0].txt_vi.value=val6;
			document.forms[0].txt_vi.readOnly=true;
			document.forms[0].txt_cbs.value=val7;
			document.forms[0].txt_cbs.readOnly=true;
			document.forms[0].sel_New.value="N";
			document.forms[0].sel_New.disabled=true;
		}
	
}

function doUpdate(val8,val1,val2,val3,val4,val5,dif,col)
{

	if(dif == 'app')
	{
		
		document.forms[0].sel_New.disabled=false;
		if(document.forms[0].sel_New.value=="0")
		{
			alert("Please Select the New Applicant");
			document.forms[0].sel_New.focus();
			return;
		}
		if(document.forms[0].sel_New.value == 'N')
		{
			if(document.forms[0].txt_vi.value=="")
			{
				alert("Please search the LAPS ID");
				document.forms[0].txt_vi.focus();
				return;
			}
		
			if(document.forms[0].txt_cbs.value=="")
			{
				//alert("Please Enter the CBS ID");
				//document.forms[0].txt_cbs.focus();
				//return;
			}
		}
	}
	if(dif == 'coapp1')
	{
		if(document.forms[0].sel_New1.value=="0")
		{
			alert("Please Select New Applicant");
			document.forms[0].sel_New1.focus();
			return;
		}
		if(document.forms[0].sel_New1.value=="N")
		{
			if(document.forms[0].txt_coapp_vi1.value=="")
			{
				alert("Please search the LAPS ID");
				document.forms[0].txt_coapp_vi1.focus();
				return;
			}
		
			if(document.forms[0].txt_coapp_cbs1.value=="")
			{
				//alert("Please Enter the CBS ID");
				//document.forms[0].txt_coapp_cbs[col].focus();
				//return;
			}
		}
	}
	if(dif == 'coapp2')
	{
		if(document.forms[0].sel_New2.value=="0")
		{
			alert("Please Select New Applicant");
			document.forms[0].sel_New2.focus();
			return;
		}
		
		if(document.forms[0].sel_New2.value=="N")
		{
			if(document.forms[0].txt_coapp_vi2.value=="")
			{
				alert("Please search the LAPS ID");
				document.forms[0].txt_coapp_vi2.focus();
				return;
			}
		
			if(document.forms[0].txt_coapp_cbs2.value=="")
			{
				//alert("Please Enter the CBS ID");
				//document.forms[0].txt_coapp_cbs[col].focus();
				//return;
			}
		}
	}
	document.forms[0].hid_dif.value=dif;
	document.forms[0].hid_dob.value=val1;
	document.forms[0].hid_dr.value=val2;
	document.forms[0].hid_adhar.value=val3;
	document.forms[0].hid_pan.value=val4;
	document.forms[0].hid_voter.value=val5;


	if(dif == 'coapp1')
	{
		document.forms[0].hid_sel1.value=document.forms[0].sel_New1.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_coapp_vi1.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_coapp_cbs1.value;
		
	}else if(dif == 'coapp2')
	{
		document.forms[0].hid_sel1.value=document.forms[0].sel_New2.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_coapp_vi2.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_coapp_cbs2.value;
		
	}else {
		document.forms[0].hid_sel1.value=document.forms[0].sel_New.value;
		document.forms[0].hid_appid.value=document.forms[0].txt_vi.value;
		document.forms[0].hid_cbs.value=document.forms[0].txt_cbs.value;
	}

	document.forms[0].hid_name.value=val8;
	document.forms[0].hid_dedupe.value="U";
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="updateNPDedupeChk";
	document.forms[0].action=appURL+"action/NP_Dedupe.jsp";
	document.forms[0].submit();
	window.opener.callCancel();
}



function doUndo(val8,val9,val1,val2,val3,val4,val5,dif,col)
{
		/*if(dif == 'coapp')
		{
			if(document.forms[0].txt_coapp_vi[col].value == '' && (document.forms[0].sel_New1[col].value == 'N' || document.forms[0].sel_New1[col].value == '0'))
			{
				alert("Kindly Dedupe the Lead")
				return;
			}else{
				document.forms[0].hid_sel1.value=document.forms[0].sel_New1[col].value;
				document.forms[0].hid_appid.value=document.forms[0].txt_coapp_vi[col].value;
				document.forms[0].hid_cbs.value=document.forms[0].txt_coapp_cbs[col].value;
			}
		}else
		{
			if(document.forms[0].txt_vi.value == '' && (document.forms[0].sel_New.value == 'N' || document.forms[0].sel_New.value == '0'))
			{
				alert("Kindly Dedupe the Lead")
				return;
			}else{
				document.forms[0].hid_sel1.value=document.forms[0].sel_New.value;
				document.forms[0].hid_appid.value=document.forms[0].txt_vi.value;
				document.forms[0].hid_cbs.value=document.forms[0].txt_cbs.value;
			}
		}*/
		document.forms[0].hid_dif.value=dif;
		document.forms[0].hid_dob.value=val1;
		document.forms[0].hid_dr.value=val2;
		document.forms[0].hid_adhar.value=val3;
		document.forms[0].hid_pan.value=val4;
		document.forms[0].hid_voter.value=val5;
		
		document.forms[0].sel_New.disabled=false;
		document.forms[0].hid_name.value=val8;
		document.forms[0].hid_dedupe.value="N";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="updateNPDedupeChk";
		document.forms[0].action=appURL+"action/NP_Dedupe.jsp";
		document.forms[0].submit();
}

function onload()
{
	document.forms[0].txt_vi.readOnly=true;
	document.forms[0].txt_cbs.readOnly=true;
	if(varselnew != '')
	{
		document.forms[0].sel_New.value=varselnew;
		if(document.forms[0].txt_vi.value != '')
		{
			document.forms[0].sel_New.disabled=true;
		}
	}else{
		document.forms[0].sel_New.value="0";
	}

	  <%if(arrRow1!=null && arrRow1.size()>0)
		{ 
			int k=0;
			for(int i=0;i<arrRow1.size();i++)
			{
				arrCol1=(ArrayList)arrRow1.get(i);
				if(i==0){
				if(!Helper.correctNull((String)arrCol1.get(7)).equalsIgnoreCase(""))
				{
				%>
			document.forms[0].sel_New1.value="<%=Helper.correctNull((String)arrCol1.get(7))%>";
		 <%
		 if(!Helper.correctNull((String)arrCol1.get(6)).equalsIgnoreCase("")){
		 %>
		 document.forms[0].sel_New1.disabled=true;
			
		 <%}}else{%>
			 document.forms[0].sel_New1.value="0";
		 <% }} else if(i==1){
			 if(!Helper.correctNull((String)arrCol1.get(7)).equalsIgnoreCase(""))
				{
		 %>
				
		 document.forms[0].sel_New2.value="<%=Helper.correctNull((String)arrCol1.get(7))%>";
		 <%
		 if(!Helper.correctNull((String)arrCol1.get(6)).equalsIgnoreCase("")){
		 %>
		 document.forms[0].sel_New2.disabled=true;
			
		 <%}}else{%>
			 document.forms[0].sel_New2.value="0";
		 <% }}}}%>
		 
		 

		 for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=true;
			}	  
		}
}

function searchlist(flag,dif,col,disFlag)
{
	if(disFlag == '0' || disFlag == '')
	{
		var vflag='';
		if(dif == 'app')
		{
			if(document.forms[0].sel_New.value == 'Y')
			{
				vflag = 'N';
			}else{
				vflag = 'Y';
			}
		}else if(dif == 'coapp1')
		{
			if(document.forms[0].sel_New1.value == 'Y')
			{
				vflag = 'N';
			}else{
				vflag = 'Y';
			}
		}else
		{
			if(document.forms[0].sel_New2.value == 'Y')
			{
				vflag = 'N';
			}else{
				vflag = 'Y';
			}
		}
		if(vflag == 'Y')
		{
			var varQryString = appURL+"action/NP_Searchlist.jsp?hidBeanId=NationalPortal&hidBeanGetMethod=getNPSearchList&NPflag="+flag+"&col="+col+"&dif="+dif;
			var title = "NationalPortal";
			var prop = "scrollbars=yes,width=650,height=400";	
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);	
		}
	}
}

function chkselNew(val21,val22)
{
	if(val21 == 'app')
	{
		if(document.forms[0].sel_New.value== 'Y' && document.forms[0].txt_vi.value != '')
		{
			alert("Laps ID is already available");
			document.forms[0].sel_New.value = '0';
			return;
		}
	}else if(val21 == 'coapp1')
	{
		if(document.forms[0].sel_New1.value== 'Y' && document.forms[0].txt_coapp_vi1.value != '')
		{
			alert("Laps ID is already available");
			document.forms[0].sel_New1.value = '0';
			return;
		}
	}else{
		if(document.forms[0].sel_New2.value== 'Y' && document.forms[0].txt_coapp_vi2.value != '')
		{
			alert("Laps ID is already available");
			document.forms[0].sel_New2.value = '0';
			return;
		}
	}
}

--></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">

</head>
<body onload="onload();">	
<form name="national_portal" method="post" class="normal">
	
 <table  width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
        <td >
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td colspan="2" align="center"><b>NP Dedupe Check</b></td>
             </tr>
          </table>
          <br/>
          <table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable border1">
             <tr class="dataheader">
             	  <td width="12%" align="center">Applicant/Co-applicant Name</td>
	              <td width="8%" align="center">Date of Birth</td>
	              <td width="10%" align="center">Driving License</td>
	              <td width="10%" align="center">Aadhar Number</td>
	              <td width="8%" align="center">PAN</td>
	              <td width="10%" align="center">Voter ID</td>
	              <td width="5%" align="center">DEDUPE</td>
	              <td width="5%" align="center">New Applicant</td>
	              <td width="16%" align="center">LAPS ID</td>
	              <td width="16%" align="center">CBS ID</td>
	              <td width="5%" align="center">Update/Undo</td>
	         </tr>
	
	         <tr>
	         	 <td width="12%" align="center">&nbsp;App - <%=Helper.correctNull((String)hshValues.get("NP_NAME"))%></td>
	             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NPPD_DOB"))%></td>
	             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NP_DRIVING"))%></td>
	             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NP_ADHAR"))%></td>
	             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NP_PAN"))%></td>
	             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)hshValues.get("NP_VOTE"))%></td>
	             <td width="5%">
	             	<%if(Helper.correctNull((String)hshValues.get("NP_ISDEDUPE")).equalsIgnoreCase("Y")) {%>
	             		<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle disabled="disabled"></td>
	            	<%}else{ %>
	            		<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle onClick="doDedupe('<%=Helper.correctNull((String)hshValues.get("NPPD_DOB"))%>','<%=Helper.correctNull((String)hshValues.get("NP_DRIVING"))%>','<%=Helper.correctNull((String)hshValues.get("NP_ADHAR"))%>','<%=Helper.correctNull((String)hshValues.get("NP_PAN"))%>','<%=Helper.correctNull((String)hshValues.get("NP_VOTE"))%>','app','0','<%=Helper.correctNull((String)hshValues.get("NP_NAME"))%>')"></td>
	            	<%} %>
	             <td width="5%" align="center">&nbsp;
		             <select name="sel_New" onChange="chkselNew('app','0')">
			             <option value="0">Select</option>
			             <option value="Y">YES</option>
						 <option value="N">NO</option>
	             	</select></td>
	             <td width="16%" align="center"><input type="text" name="txt_vi" value="<%=Helper.correctNull((String)hshValues.get("NP_LAPSID"))%>"><span onClick="searchlist('laps','app','0','<%=Helper.correctNull((String)hshValues.get("NP_ISNEW"))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
	             <td width="16%" align="center"><input type="text" name="txt_cbs" value="<%=Helper.correctNull((String)hshValues.get("NP_CBSID"))%>" ><span onClick="searchlist('cbs','app','0','<%=Helper.correctNull((String)hshValues.get("NP_ISNEW"))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
	             <td width="5%">
	             		<%if(!Helper.correctNull((String)hshValues.get("NP_ISNEW")).equalsIgnoreCase("")) {%>
	             			<input type="button" name="cmdclose" value="Update" class=buttonStyle  disabled="disabled"><br/>
	             			<input type="button" name="cmdUndo" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)hshValues.get("NP_NAME"))%>','<%=Helper.correctNull((String)hshValues.get("NP_LAPSID"))%>','<%=Helper.correctNull((String)hshValues.get("NPPD_DOB"))%>','<%=Helper.correctNull((String)hshValues.get("NP_DRIVING"))%>','<%=Helper.correctNull((String)hshValues.get("NP_ADHAR"))%>','<%=Helper.correctNull((String)hshValues.get("NP_PAN"))%>','<%=Helper.correctNull((String)hshValues.get("NP_VOTE"))%>','app','0')"></td>
	             		 <%}else{ %>
		             		<input type="button" name="cmdclose" value="Update" class=buttonStyle onClick="doUpdate('<%=Helper.correctNull((String)hshValues.get("NP_NAME"))%>','<%=Helper.correctNull((String)hshValues.get("NPPD_DOB"))%>','<%=Helper.correctNull((String)hshValues.get("NP_DRIVING"))%>','<%=Helper.correctNull((String)hshValues.get("NP_ADHAR"))%>','<%=Helper.correctNull((String)hshValues.get("NP_PAN"))%>','<%=Helper.correctNull((String)hshValues.get("NP_VOTE"))%>','app','0')"><br/>
					 		<%if(!Helper.correctNull((String)hshValues.get("NP_LAPSID")).equalsIgnoreCase("")) {%>
					 			<input type="button" name="cmdUndo" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)hshValues.get("NP_NAME"))%>','<%=Helper.correctNull((String)hshValues.get("NP_LAPSID"))%>','<%=Helper.correctNull((String)hshValues.get("NPPD_DOB"))%>','<%=Helper.correctNull((String)hshValues.get("NP_DRIVING"))%>','<%=Helper.correctNull((String)hshValues.get("NP_ADHAR"))%>','<%=Helper.correctNull((String)hshValues.get("NP_PAN"))%>','<%=Helper.correctNull((String)hshValues.get("NP_VOTE"))%>','app','0')"></td>
					 		 <%}else{ %>
					 			<input type="button" name="cmdUndo" value="Undo" disabled="disabled"  class=buttonStyle></td>
             			<%}} %>
             			
             			
             </tr>
             
          <br/>
          
          
            <%if(arrRow1!=null && arrRow1.size()>0)
				{ 
					int k=0;
					for(int i=0;i<arrRow1.size();i++)
					{
						arrCol1=(ArrayList)arrRow1.get(i);
						
				if(i==0){	%>
			         <tr>
			         	 <td width="12%" align="center">CoApp&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol1.get(0))%></td>
			             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(1))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(2))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(3))%></td>
			             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(4))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(5))%></td>
			             <td width="5%">
			             
			             <%if(Helper.correctNull((String)arrCol1.get(9)).equalsIgnoreCase("Y")) {%>
		             		<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle disabled="disabled"></td>
		            	<%}else{ %>
			             	<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle onClick="doDedupe('<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp1','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(0))%>')"></td>
			            <%}%>
			             <td width="5%" align="center">&nbsp;
				             <select name="sel_New1" onChange="chkselNew('coapp1',<%=k%>)">
					             <option value="0">Select</option>
					             <option value="Y">YES</option>
								 <option value="N">NO</option>
			             	</select></td>
			             <td width="16%" align="center"><input type="text" name="txt_coapp_vi1"  value="<%=Helper.correctNull((String)arrCol1.get(6))%>"><span onClick="searchlist('laps','coapp1','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(7))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
			             <td width="16%" align="center"><input type="text" name="txt_coapp_cbs1"  value="<%=Helper.correctNull((String)arrCol1.get(8))%>" ><span onClick="searchlist('cbs','coapp1','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(7))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
			             <td width="5%">
			             
			             <%if(!Helper.correctNull((String)arrCol1.get(7)).equalsIgnoreCase("")) {%>
	             			<input type="button" name="cmdclose" value="Update" class=buttonStyle  disabled="disabled"><br/>
			             	<input type="button" name="cmdclose" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp1','<%=k%>')"></td>
			             <%}else{ %>
			             	<input type="button" name="cmdclose" value="Update" class=buttonStyle onClick="doUpdate('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp1','<%=k%>')"><br/>
						 		<%if(!Helper.correctNull((String)arrCol1.get(6)).equalsIgnoreCase("")) {%>
						 			<input type="button" name="cmdclose" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp1','<%=k%>')"></td>
						 		 <%}else{ %>
						 			<input type="button" name="cmdclose" value="Undo" disabled="disabled"  class=buttonStyle></td>
		             		<%}} k=k+1;%>
		             </tr>
		             
		           <%}else if(i==1)
		            {%>
		                  <tr>
			         	 <td width="12%" align="center">CoApp&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol1.get(0))%></td>
			             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(1))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(2))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(3))%></td>
			             <td width="8%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(4))%></td>
			             <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrCol1.get(5))%></td>
			             <td width="5%">
			             
			             <%if(Helper.correctNull((String)arrCol1.get(9)).equalsIgnoreCase("Y")) {%>
		             		<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle disabled="disabled"></td>
		            	<%}else{ %>
			             	<input type="button" name="cmddedupe" value="Dedupe" class=buttonStyle onClick="doDedupe('<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp2','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(0))%>')"></td>
			            <%}%>
			             <td width="5%" align="center">&nbsp;
				             <select name="sel_New2" onChange="chkselNew('coapp2',<%=k%>)">
					             <option value="0">Select</option>
					             <option value="Y">YES</option>
								 <option value="N">NO</option>
			             	</select></td>
			             <td width="16%" align="center"><input type="text" name="txt_coapp_vi2"  value="<%=Helper.correctNull((String)arrCol1.get(6))%>"><span onClick="searchlist('laps','coapp2','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(7))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
			             <td width="16%" align="center"><input type="text" name="txt_coapp_cbs2"  value="<%=Helper.correctNull((String)arrCol1.get(8))%>" ><span onClick="searchlist('cbs','coapp2','<%=k%>','<%=Helper.correctNull((String)arrCol1.get(7))%>')" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="7"></span></td>
			             <td width="5%">
			             
			             <%if(!Helper.correctNull((String)arrCol1.get(7)).equalsIgnoreCase("")) {%>
	             			<input type="button" name="cmdclose" value="Update" class=buttonStyle  disabled="disabled"><br/>
			             	<input type="button" name="cmdclose" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp2','<%=k%>')"></td>
			             <%}else{ %>
			             	<input type="button" name="cmdclose" value="Update" class=buttonStyle onClick="doUpdate('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp2','<%=k%>')"><br/>
						 		<%if(!Helper.correctNull((String)arrCol1.get(6)).equalsIgnoreCase("")) {%>
						 			<input type="button" name="cmdclose" value="Undo" class=buttonStyle onClick="doUndo('<%=Helper.correctNull((String)arrCol1.get(0))%>','<%=Helper.correctNull((String)arrCol1.get(6))%>','<%=Helper.correctNull((String)arrCol1.get(1))%>','<%=Helper.correctNull((String)arrCol1.get(2))%>','<%=Helper.correctNull((String)arrCol1.get(3))%>','<%=Helper.correctNull((String)arrCol1.get(4))%>','<%=Helper.correctNull((String)arrCol1.get(5))%>','coapp2','<%=k%>')"></td>
						 		 <%}else{ %>
						 			<input type="button" name="cmdclose" value="Undo" disabled="disabled"  class=buttonStyle></td>
		             		<%}} %>
		             </tr>
		            
		            
		            
		          <%  } %>
		             
		             
		             
		             
             <%}} %>
           </table> 
       </td>
   </tr>
</table>	
<br/>
<br/>
<br/>
		<%if(strActionflag.equalsIgnoreCase("Y") && strDedupeflag.equalsIgnoreCase("D")){ %>
		
		<table  width="90%" border="0" cellspacing="0" cellpadding="3" align="center">
		    <tr> 
		        <td align="center"><b>Search Results in LAS:</b><br/> 
					<table width="80%" border="1" cellspacing="0" cellpadding="2" class="outertable border1">
						<tr class="dataheader">
							<td align="center">DOB</td>
							<td align="center">Driving Licence</td>
							<td align="center">Aadhar No.</td>
							<td align="center">PAN NO.</td>
							<td align="center">Voter ID</td>
							<td align="center">LAPS ID</td>
							<td align="center">CBS ID</td>
						</tr>
						<tr>
							<td align="center"><input type="radio"  name="rad_chck"  value="" onClick="calplacevalue('<%=Helper.correctNull((String)hshValues.get("PERAPP_ID")) %>','<%=Helper.correctNull((String)hshValues.get("PERAPP_CBSID")) %>','<%=Helper.correctNull((String)hshValues.get("hid_dif")) %>','<%=Helper.correctNull((String)hshValues.get("hid_col")) %>')"> &nbsp;<%=Helper.correctNull((String)hshValues.get("PERAPP_DOB")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_DRIVINGLICENCENUMBER")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_AADHAAR")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_PANNO")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_VOTERID")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_ID")) %></td>
							<td align="center"><%=Helper.correctNull((String)hshValues.get("PERAPP_CBSID")) %></td>
						</tr>
					</table>	
				</td>
			</tr>
		</table>			
						
		<%}else if(strActionflag.equalsIgnoreCase("N")){ %>
			<table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable border1">
				<tr valign="middle">
					<td align="center">No Records Found</td>
				</tr>
			</table>	
		<%} %>
		<br/>
		<br/>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="1">
			<tr valign="middle">
				<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>		
	<input type="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidBeanId" value=""> 
	<input type="hidden" name="hidBeanMethod" value=""> 
	<input type="hidden" name="hidSourceUrl" value="">
	<input type="hidden" name="hidAction" value="">
	
<input type="hidden" name="hidref" value="<%=Helper.correctNull((String)hshValues.get("strrefno")) %>">
<input type="hidden" name="hid_dedupe" value="">
<input type="hidden" name="hid_dob" value="">
<input type="hidden" name="hid_dr" value="">
<input type="hidden" name="hid_adhar" value="">
<input type="hidden" name="hid_pan" value="">
<input type="hidden" name="hid_voter" value="">
<input type="hidden" name="hid_name" value="">
<input type="hidden" name="hidAppType" value="">
<input type="hidden" name="hid_dif" value="">
<input type="hidden" name="hid_col" value="">
<input type="hidden" name="hid_appid" value="">
<input type="hidden" name="hid_sel1" value="">
<input type="hidden" name="hid_cbs" value="">
 <input type="hidden" name="hid_appid1" value="">
<input type="hidden" name="hid_cbsid" value="">
<input type="hidden" name="SegType" value="<%=Helper.correctNull((String)hshValues.get("strSegment")) %>">

</form>
</body>
</html>