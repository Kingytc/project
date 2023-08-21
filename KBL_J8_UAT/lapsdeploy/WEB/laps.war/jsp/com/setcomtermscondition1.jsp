
<%@ page import="com.sai.laps.helper.*,java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />

<%
   if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
    ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (ArrayList)hshValues.get("vecData");
	}

	
   %>
<html>

<head>
<title>Terms &amp; Conditions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
</STYLE>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">


<script language="javascript" >

var appUrl="<%=ApplicationParams.getAppUrl()%>";


var headid = "<%=Helper.correctNull((String)hshValues.get("head"))%>";
var facid = "<%=Helper.correctNull((String)hshValues.get("type"))%>";


var mode1= "<%=Helper.correctNull((String)hshValues.get("mode"))%>";
 



function whileLoading()
{
		
	
	

	if(mode1=="G")
	{
		document.forms[0].facility_head.disabled=true;
		document.forms[0].facility.disabled=true;
		document.forms[0].doc_mode[0].checked=true;
	}
	else if(mode1=="S")
	{
			
		document.forms[0].doc_mode[1].checked=true;
	}
	else
	{
		document.forms[0].facility_head.disabled=true;
		document.forms[0].facility.disabled=true;
	}
		
	
	if((headid!="")&&(facid!=""))
	{
		disableFields(true);
		enableButtons(false,false,true,true,true,false);
	
	}

	else
	{
	disableFields(true);
	enableButtons(true,true,true,true,true,false);
	}

 	len = document.forms[0].facility_head.length;
	for(k=0;k<len;k++)
	{
		arr = document.facility.facility_head.options[k].value.split("-");


		if(arr!=null)
		{
			if(arr[0]==headid)
			{
				document.facility.elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
if(headid!="")
	{
	
document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+headid+"&value=subsel&hidMethod=getFacility&factid="+facid+"&strtype=facility";


	}			
			

}


function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
	{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;	
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;		

	}

function disableFields(val)
	{
		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].readOnly=val;		  
			}
			
		}

	}




  function doCancel()
	{
			
			if(ConfirmMsg(102))
		{				
			
				document.forms[0].action=appURL+"action/setcomtermscondition.jsp";				
				document.forms[0].submit();		

		}
		
	
	}


	function makeNull()
{
		for(var i=0;i<document.forms[0].elements.length;i++)
				{
					if(document.forms[0].elements[i].type=="textarea")
					{							
							document.forms[0].elements[i].value="";		  
												
					}
			
				}

}

  function placeValues(termsno)
	{

	
	if(termsno!="")
	{				
		
			if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";

		if(mode=="G")
		{
			document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&facility_head="+headid+"&facility="+facid+"&mode=G";
		}
		else
		{
			document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&facility_head="+headid+"&facility="+facid+"&mode=S";
		}

	}
	enableButtons(true,false,true,false,false,false);	
	}


  function doNew()
  {
						
				if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";

		if(mode=="G")
		{
		
					
		
					 makeNull();
					 disableFields(false);
					enableButtons(true,true,false,false,true,true);	
					document.forms[0].hidVal.value="insert";
					document.forms[0].mode.value="G";
					document.forms[0].termscondition.focus();

		}
		else
	  {
					
			if(document.forms[0].facility_head.value=="-")
				 {
						alert("select Facility Head");
						document.forms[0].facility_head.focus();
						return;
				 }
					if(document.forms[0].facility.value=="-")
				 {
						alert("select Facility Type");
						document.forms[0].facility.focus();
						return;
				 }
					

					 makeNull();
					 disableFields(false);
					enableButtons(true,true,false,false,true,true);	
					document.forms[0].hidVal.value="insert";
					document.forms[0].mode.value="S";
					document.forms[0].termscondition.focus();
	  }




		 
   }

   function doClose()
{
	
	if(ConfirmMsg(100))
		{
	document.forms[0].action = appUrl + "action/facilitynav.jsp";
	document.forms[0].submit();
		}

}

 function doEdit()
  {
 		var flag=false;
				
				if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";

		if(mode=="S")
		{
		
			if((document.forms[0].facility.value=="")||(document.forms[0].facility.value=="-"))
				 {
					alert("select Facility Type");
					document.forms[0].facility.focus();
					return;
				 }
		}

					
		for(var i=0;i<document.forms[0].elements.length;i++)
				{
		
											
						if((document.forms[0].elements[i].checked)&&(document.forms[0].elements[i].name=="termsel"))
						{
								flag=true;
								break;
						}
												
				}
			
			


		if(flag)
	  {
		disableFields(false);
		enableButtons(true,true,false,false,true,true);	
		document.forms[0].hidVal.value ="edit";	
		document.forms[0].termscondition.focus();
	  }
	  else
	 {
		  alert("select terms and condition to edit");
	 }

	

 }

  function doDelete()
	{
			
				if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";

			if(mode=="S")
			{
				document.forms[0].mode.value="S";
			}
			else
			{
				document.forms[0].mode.value="G";
			}
			
			if(ConfirmMsg(101))
			{		
				
				document.forms[0].hidVal.value ="delete";	
				document.forms[0].hidBeanGetMethod.value="UpdateComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";
				document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
				document.forms[0].submit();	

			}
	}




   function doSave()
 {
 	if(checktrim(document.forms[0].termscondition.value)=="")
	{
		  ShowAlert(111,'conditions');
		  document.forms[0].termscondition.focus();

	}

	else
	 {
				if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";

		if(mode=="S")
		{
			document.forms[0].mode.value="S";
		}
		else
		 {
			document.forms[0].mode.value="G";
		 }

				document.forms[0].cmdapply.disabled = true;		
				document.forms[0].hidBeanGetMethod.value="UpdateComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";
				document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
				document.forms[0].submit();
	}
		
 }




function getFacility(strtype)
{
		

		if(document.forms[0].facility_head.value=="-")
	{
			alert("Select facility head");
			document.forms[0].facility_head.focus();
			return;
	}

	
	if(strtype=="facility")
	{
			
		var facilityhead = document.forms[0].elements["facility_head"].value;
		arr = facilityhead.split("-");
		var parentparam =arr[0];
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility";
	}

		

		if((document.forms[0].facility.value=="")||(document.forms[0].facility.value=="-"))
				 {
						disableFields(true);
						enableButtons(true,true,true,true,true,false);
						return;
				 }
				 else
	{
				document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";				document.forms[0].action=appURL+"action/setcomtermscondition.jsp?";	
				document.forms[0].mode.value="S";
				document.forms[0].submit();	
	}
		


}


function forgetdata()
{
				
			if(document.forms[0].doc_mode[0].checked)
			mode="G";
			else
			mode="S";
		if(mode=="S")
		{
			if(document.forms[0].facility_head.value=="-")
				 {
						alert("select Facility Head");
						document.forms[0].facility_head.focus();
						return;
				 }
					if(document.forms[0].facility.value=="-")
				 {
						alert("select Facility Type");
						document.forms[0].facility.focus();
						return;
				 }
					
		}
				document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";				document.forms[0].action=appURL+"action/setcomtermscondition.jsp?";	
				document.forms[0].mode.value="S";
				document.forms[0].submit();
}


function getGenConditions()
{
	callMode();
	disableFields(true);
	enableButtons(false,false,true,true,true,false);

				document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";				document.forms[0].action=appURL+"action/setcomtermscondition.jsp?";	
				document.forms[0].mode.value="G";
				document.forms[0].submit();


}
function getFacConditions()
{
				callMode();
			document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";				document.forms[0].action=appURL+"action/setcomtermscondition.jsp?";	
				document.forms[0].mode.value="S";
				document.forms[0].submit();
}

 function callMode()
 {
	 
		var mode;

		if(document.forms[0].doc_mode[0].checked)
		mode="G";
		else if(document.forms[0].doc_mode[1].checked)
		mode="S";	
		if(mode=="G")
	 {
		document.forms[0].facility_head.disabled=true;
		document.forms[0].facility.disabled=true;		
		//document.forms[0].selfacilityhead.value='';
		//document.forms[0].selfacility.value='';
		


	 }
	 else if(mode=="S")
	 {
		document.forms[0].facility_head.disabled=false;
		document.forms[0].facility.disabled=false;
		
	 }

	

	 


 }


</script>

</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="javascript:whileLoading()">
<form name="facility" method="post">
<iframe  height="0" width="0" id="termfrm" frameborder=0 style="border:0" ></iframe> 

  <iframe  height="0" width="0" id="ifrm1" frameborder=0 style="border:0" ></iframe> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
       
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i>Home -&gt; Setup -&gt; Corporate 
              Products -&gt; Term &amp; Conditions</i></b>
			  </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" >
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
			  <tr> 
                                    <td width="20%">&nbsp;</td>
                                    <td width="24%"> <font face="MS Sans Serif" size="1"> 
                                      <input type="radio" name="doc_mode" value="G" onClick="getGenConditions()">
                                      General Terms&Conditions</font></td>
                                    <td width="30%"> <font face="MS Sans Serif" size="1"> 
                                      <input type="radio" name="doc_mode" value="S" onClick="getFacConditions()">
                                      Facility Based Terms&Conditions </font></td>
                                    <td width="41%"><font face="MS Sans Serif" size="1"></font></td>
                                  </tr>
								  <tr><td>&nbsp;</td></tr>
                <tr> 
                  <td width="15%"><font size="1" face="MS Sans Serif">Facility 
                    Head</font></td>
                  <td width="35%"> 
                     <%			 HashMap hp1 =  new HashMap();%>
                                <select name="facility_head" onChange="javascript:getFacility('facility')">
                                  <option selected value="-">----Select----</option>
                                  <%
							  HashMap h = new HashMap();
							  h.put("value","parent");
							  h.put("parent","0");
							  h.put("hidMethod","getFacility");
							  
							  hp1 = new HashMap();
						   hp1.put("BeanId","facilitymaster");
						   hp1.put("MethodName","getData");
						   hp1.put("BeanParam",h);
						  %>
                                  <laps:selecttag value="<%= hp1%>" /> 
                                </select>
                  </td>
                  <td width="10%"><font size="1" face="MS Sans Serif">Facility 
                    Type</font></td>
                  <td width="40%"> 
                     <select name="facility" onchange="javascript:forgetdata()">
                                  <option selected >----Select----</option>
                      </select>
                  </td>
                </tr>
                <tr> 
                  <td colspan="4">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5">
                      <tr> 
                        <td width="45%" bgcolor="#EEEAE3"> 
                          <textarea name="termscondition" cols="120" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                <tr> 
                  <td valign="top"> 
                    <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
                      <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
                            <tr valign="top"> 
                              <td width="14%"> 
                                <input type="button" name="cmdnew" value="New" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doNew()">
                              </td>
                              <td width="14%"> 
                                <div align="center"> 
                                  <input type="button" name="cmdedit" value="Edit" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doEdit()">
                                </div>
                              </td>
                              <td width="14%"> 
                                <div align="center"> 
                                  <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doSave()">
                                </div>
                              </td>
                              <td width="14%">
                                <input type="button" name="cmddel" value="Delete" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doDelete()">
                              </td>
                              <td width="14%"> 
                                <div align="center"> 
                                  <input type="button" name="cmdcancel" value="Cancel" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doCancel()">
                                </div>
                              </td>
                              <td width="15%"> 
                                <div align="center"> 
                                  <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doHelp()">
                                </div>
                              </td>
                              <td width="15%"> 
                                <div align="center"> 
                                  <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onclick="doClose()">
                                </div>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
				<tr>
                  <td valign="top">&nbsp; </td>
                </tr>
                <tr><td >
				<tr>
									
				 
				 <%
			if((vecData!=null)&&(vecData.size()!=0))
			{

								%>	<td colspan=2 align="center" bgcolor="#71694F" height="20"><font  color="#FFFFFF">TERMS & CONDITIONS</font></td>
									</TR>
									<%
				vecsize = vecData.size();
			
			String termsno="";

			for(int i=0;i<vecsize;i++)
			{				
				vecRow = (ArrayList)vecData.get(i);

				if(vecRow!=null)
				{	
					
					termsno = Helper.correctNull((String)vecRow.get(0));
				
								%>
                   <table width="100%" border="0" cellspacing="1" cellpadding="2">
									
                      <tr> 
                        <td bgcolor="#EEEAE3" width="5%"> 
                          <input type="radio" name="termsel" value="radiobutton" style="border-style:none" onClick="placeValues(<%= termsno %>)" >
							   
                        </td>
                        <td bgcolor="#EEEAE3" width="95%"><font size="1" face="MS Sans Serif"><%= Helper.correctNull((String)vecRow.get(1)) %></font></td>
                      </tr>
                    </table>
							<%
							}
						 }
			}
					%>
                </td></tr>
               
              </table>
            </td>
          </tr>
        </table>
        </td>
    </tr>
  </table>
<br>
			<input type="hidden" name="hidBeanId" >
			<input type="hidden" name="hidVal">
			<input type="hidden" name="hidBeanGetMethod" >
			 <input type="hidden" name="sno">
			 <input type="hidden" name="mode">
			
			
</form>
</body>
</html>
