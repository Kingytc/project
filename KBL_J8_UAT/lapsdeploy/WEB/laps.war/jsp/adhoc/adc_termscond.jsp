<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
ArrayList arrFacilityTerm = (ArrayList)hshValues.get("arrFacilityTerm");
ArrayList arrFacilityTermType = (ArrayList)hshValues.get("arrFacilityTermType");
ArrayList arrFacilityIdVal = (ArrayList)hshValues.get("arrFacilityIdVal");
ArrayList arrFacilityTermStatus = (ArrayList)hshValues.get("arrFacilityTermStatus");

ArrayList arrFacilityTermApp = (ArrayList)hshValues.get("arrFacilityTermApp");
ArrayList arrFacilityTermTypeApp = (ArrayList)hshValues.get("arrFacilityTermTypeApp");
ArrayList arrFacilityIdAppVal = (ArrayList)hshValues.get("arrFacilityIdAppVal");
ArrayList arrFacilityTermStatusapp = (ArrayList)hshValues.get("arrFacilityTermStatusapp");


String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
//out.print(strCategoryType);
String strCatName="";
if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP"))
{
	
	strCatName="Corporate";
	
}
else if(strCategoryType.equals("OPS"))
{
	strCatName="Tertiary";
}

ArrayList arrFacilityTermMaster = (ArrayList)hshValues.get("arrFacilityTermMaster");

int j=0;

%>
<html>
<head>
<title>Terms and Conditions</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js">
</script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var flag= "<%= Helper.correctNull((String)hshValues.get("arrFacilityId")) %>";
	function disableFields(one)
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=="checkbox")
			{	
				document.forms[0].elements[i].disabled=one;		  
			}
			
		}
	
	}
	function setData(i)
	{
	
		if(document.forms[0].chk_status[i].checked == true)
		{
			document.forms[0].doc_chkstatus[i].value="Y";
		}
		else
		{
			document.forms[0].doc_chkstatus[i].value="N";
		}
		
		document.forms[0].hidcomments.value="";
		if(document.forms[0].hidterms.value=="P")
		{
			disableButton(true,true,false,false,false,true);
		}
		
		
	}


	function doNew()
	{
			if(document.forms[0].seltermid.value=="s")
		{
			alert("Select Facility");
			document.forms[0].seltermid.focus();
			return;
		}
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidtermid.value="";
		document.forms[0].txttrmdesc.value="";
		document.forms[0].txttrmdesc.readOnly=false;
		disableButton(true,true,false,false,true,true);
		document.forms[0].txttrmdesc.focus();
		
	}

	function doEdit()
	{
		if(document.forms[0].seltermid.value=="s")
		{
			alert("Select Facility");
			document.forms[0].seltermid.focus();
			return;
		}
		disableFields(false);	
		document.forms[0].hidAction.value="select";
		document.forms[0].txttrmdesc.readOnly=true;
		var len = document.forms[0].chk_status.length;
		if(len != null)
		{
			for(i=0;i<len;i++)
			{
				if(document.forms[0].hidtermtype[i].value=="P")
					document.forms[0].chk_status[i].disabled = false;
				else
					document.forms[0].chk_status[i].disabled = true;
			}
		}
		else
		{
			document.forms[0].chk_status.disabled = true;
		}
		disableButton(true,true,false,false,false,true);
	}


	function doSave()
	{
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanMethod.value="updateComFacilityTermData";
		document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
		document.forms[0].action=appUrl+"controllerservlet";
		
		if (flag=="0^0")
		{	
			document.forms[0].general.value="general";
			document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";
		}
		else
		{
			document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";
		}

		document.forms[0].method="post";
		document.forms[0].submit();
	}
	function putData(i,j,size)
	{
		if(i==0 && j==0 && size==1)
		{
			document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
			document.forms[0].doc_code.value=j;
			document.forms[0].hidtermid.value=document.forms[0].doc_code.value;
			document.forms[0].hidterms.value=document.forms[0].hidtermtype.value;
			document.forms[0].hidAction.value="change";
			if(document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].readFlag.value.toUpperCase()=="W")
			{
				disableButton(true,true,false,false,false,true);
				document.forms[0].txttrmdesc.readOnly=false;
			}
		}
		else
		{
			document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
			document.forms[0].doc_code.value=j;
			document.forms[0].hidtermid.value=document.forms[0].doc_code[i].value;
			document.forms[0].hidterms.value=document.forms[0].hidtermtype[i].value;
			document.forms[0].hidAction.value="change";
			if(document.forms[0].appstatus.value=="Open/Pending" && document.forms[0].readFlag.value.toUpperCase()=="W")
			{
				disableButton(true,true,false,false,false,true);
				document.forms[0].txttrmdesc.readOnly=false;
			}
		}
			
	}

	function loadData()
	{
		
		if(document.forms[0].seltermid.value=="0^0")
		{
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].action=appUrl+"action/adc_termscond.jsp?hidBeanGetMethod=getComFacilityTermData&appStatus="+document.forms[0].appstatus.value;
			document.forms[0].general.value="general";
	
			document.forms[0].method="post";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].action=appUrl+"action/adc_termscond.jsp?hidBeanGetMethod=getComFacilityTermData&appStatus="+document.forms[0].appstatus.value;
			document.forms[0].method="post";
			document.forms[0].submit();

		}


	}

	function doDelete()
	{
		if(document.forms[0].hidtermid.value=="")
		{
		alert("Select Terms to delete");
		return false;
		}
			
		if(trimtxt(document.forms[0].hidcomments.value)=="")
		{
			var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
			var title1 = "";
			var prop = "scrollbars=no,width=600,height=450,menubar=no";
			var xpos = 20;
			var ypos = 20;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(url,title1,prop);
			
		}
		else
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="apptermscond";
			document.forms[0].hidBeanMethod.value="updateComFacilityTermData";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
			if (flag=="0^0")
			{	
				document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";
				document.forms[0].general.value="general";
	
			}
			else
			{
				document.forms[0].hidSourceUrl.value="/action/adc_termscond.jsp";	//document.forms[0].hidSourceUrl.value=appUrl+"action/adc_termscond.jsp?hidBeanGetMethod=getComFacilityTermData";
			}

			document.forms[0].method="post";
			document.forms[0].submit();
		}
	}
	function disableButton(b1,b2,b3,b4,b5,b6)
	{
		document.forms[0].cmdadd.disabled = b1;
		document.forms[0].cmdedit.disabled = b2;
		document.forms[0].cmdapply.disabled = b3;
		document.forms[0].cmdcancel.disabled = b4;
		document.forms[0].cmddelete.disabled = b5;
		document.forms[0].cmdclose.disabled = b6;

	}

	function doCancel()
	{
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanGetMethod.value="getComFacilityTermData";
		if (flag=="0^0")	
		{
			document.forms[0].action=appUrl+"action/adc_termscond.jsp";
			document.forms[0].general.value="general";
		}
		else
			document.forms[0].action=appUrl+"action/adc_termscond.jsp";

		document.forms[0].method="post";
		document.forms[0].submit();
	}

	function callClose()
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].method="post";
			document.forms[0].action=appUrl+"action/corppge.jsp";
			document.forms[0].submit();
		}
	}

	
	
	function deleteTerms()
	{
		if(document.forms[0].seltermid.selectedIndex==0)
		{
			alert("Select Facilities");
			return;
		}
		var url;
		var appno = document.forms[0].appno.value;
		var seltermid = document.forms[0].seltermid.value;
		var seltermvalue = document.forms[0].seltermid.options[document.forms[0].seltermid.selectedIndex].text;
		if (flag=="0^0")			
					 url = "<%=ApplicationParams.getAppUrl()%>action/adc_apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Corporate&seltermid="+seltermid+"&seltermvalue="+seltermvalue+"&general=general";
				else
					 url = "<%=ApplicationParams.getAppUrl()%>action/adc_apptermsandcondexcep.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Corporate&seltermid="+seltermid+"&seltermvalue="+seltermvalue;
		
		var title1 = "Terms";
		var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title1,prop);
  	}

	function setSelect()
	{

		disableFields(true);
		if(document.forms[0].appstatus.value!="Open/Pending" && document.forms[0].appstatus.value.toUpperCase()!="op")
		{
			disableButton(true,true,true,true,true,false);			

		}
		else
		{
			disableButton(false,false,true,true,true,false);	
		}
		if("<%=Helper.correctNull((String)hshValues.get("arrFacilityId"))%>"=="")
		{
			document.forms[0].seltermid.value="s";
		}
		else
		{
		document.forms[0].seltermid.value="<%=(String)hshValues.get("arrFacilityId")%>";
		}
		if(document.forms[0].chk_status)
		{
			document.forms[0].cmdedit.disabled=false;
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
		}
	}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propoother.htm";
  var title = "TermsAndConditions";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body onLoad="setSelect()">
<form name="frm1" method="post">
<lapstab:applurllinksadc pageid="8" />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#EEEAE3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
<tr>
<td class="page_flow">
Home-&gt;
Corporate &amp; SME -&gt; Ad hoc Limit-&gt; Terms and Cond.
</td>
</tr>
</table>
<laps:ADCApplications/>

 
  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="350" align="center" class="outertable border1">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center" height="100%">
          <tr> 
            <td valign="top"> 
               
					
					<table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td colspan="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr>
                              <td width="29%" align="center">Select 
                                Facilities </td>
                              <td width="71%">
							  <select name="seltermid" onChange="loadData()">
							  <option value='s'><-- Select --></option>
							 <option value='0'><-- General --></option>
							 <%-- <laps:comtermscond /> --%> 
							 <laps:adhoctermscond/> 
							  </select></td>
                            </tr>
                            <tr> 
                              <td width="29%" align="center">Add 
                                Terms and Conditions</td>
                              <td width="71%"> 
                                <input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100" readonly="readOnly" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <%
						String check1=Helper.correctNull((String)hshValues.get("arrFacilityId"));
							if (check1.equals("0^0"))
							{
						%>
                      <tr bgcolor="#71694F"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" bgcolor="#71694F" colspan="3"> <b><font color="#FFFFFF">General 
                          Terms and Conditions For all Facilites</font></b></td>
                      </tr>
                      <%
							}
							else if(check1.equals(""))
							{
									
							}

							else
							{
							%>
                      <tr bgcolor="#71694F"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" bgcolor="#71694F" colspan="3"> <b><font color="#FFFFFF">Terms 
                          and Conditions for this Facility</font></b></td>
                      </tr>
                      <%
							}
							
					  
					  if(arrFacilityTerm!=null && arrFacilityTerm.size()>0)
					  {
					  j=arrFacilityTerm.size();
					  for(int i=0;i<arrFacilityTerm.size();i++)
					  {
					  %>
                      <tr bgcolor="#EEEAE3"> 
                        <input type="hidden" name=doc_code value="<%=arrFacilityIdVal.get(i)%>">
                        <td width="3%"> 
                          <!-- <input type="radio" name="sno" style="border-style:none" value="<%=arrFacilityIdVal.get(i)%>" onClick="setData()">-->
                          <input type="checkbox" name="chk_status" style="border-style:none" value="Y" <%if(((Helper.correctNull((String)arrFacilityTermStatus.get(i))).equalsIgnoreCase("Y")))
								  {%> checked<%} %> onClick="setData(<%=i%>)">
                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatus.get(i))%>">
                          <input type="hidden" name="hidsno" style="border-style:none" value="">
                          <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTerm.get(i)%>">
                          <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermType.get(i)%>">
                        </td>
                        <td align="center" colspan="3"> 
                          <div align="left">
                            <%=arrFacilityTerm.get(i)%> </div>
                        </td>
                      </tr>
                      <%
					  }
					  }
					  else
					  {
					  %>
                      <!--<tr bgcolor="#EEEAE3"> 
                        <td width="3%">&nbsp; 
                         
                        </td>
                        
                        <td width="97%" align="center"> 
                          <div align="left"><font size="1" face="MS Sans Serif"></font> &nbsp;
                            </font></div>
                        </td>
                      </tr>-->
                      <%
					  }
					  

				
					 check1=Helper.correctNull((String)hshValues.get("arrFacilityId"));
							if (check1.equals("0^0"))
							{
						

					  %>
                      <tr bgcolor="#71694F"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" bgcolor="#71694F" colspan="3"> <b><font color="#FFFFFF"> 
                          General Terms and Conditions For this Specific Borrower 
                          </font></b></td>
                      </tr>
                      <%
							}
							else if(check1.equals(""))
							{
									
							}

							else
							{
							%>
                      <tr bgcolor="#71694F"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" bgcolor="#71694F" width="69%"> <b><font color="#FFFFFF"> 
                          Terms and Conditions For this Specific Borrower </font></b></td>
                        <td align="center" bgcolor="#71694F" width="19%"><b><font color="#FFFFFF"> 
                          Modify Terms & Conditions</font></b></td>
                        
                      </tr>
                      <%
							}

					  if(arrFacilityTermApp!=null)
					  {
					  
					  for(int i=0;i<arrFacilityTermApp.size();i++)
					  {
					  %>
                      <tr bgcolor="#EEEAE3"> 
                        <td width="3%"> 
                          <input type=hidden name=doc_code value="<%=arrFacilityIdAppVal.get(i)%>">
                          <!--<input type="radio" name="sno" style="border-style:none" value="<%=arrFacilityIdAppVal.get(i)%>" onClick="setData()">-->
                          <input type="checkbox" name="chk_status" style="border-style:none" <%
						    if((Helper.correctNull((String)arrFacilityTermStatusapp.get(i))).equalsIgnoreCase("Y"))
								  {%> checked<%} %>>
                          <input type="hidden"  name="doc_chkstatus" value="<%=Helper.correctNull((String)arrFacilityTermStatusapp.get(i))%>">
                        </td>
                        <input type="hidden" name="hidsno" style="border-style:none" value="">
                        <input type="hidden" name="hidText" style="border-style:none" value="<%=arrFacilityTermApp.get(i)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrFacilityTermTypeApp.get(i)%>">
                        <td align="center" width="69%"> 
                          <div align="left">
                            <%=arrFacilityTermApp.get(i)%> </div>
                        </td>
                        <td align="center" width="19%"> 
                          <input type="hidden" name="hiddoccode" value="">
                          <input type="radio" name="rad_edit" style="border-style:none" onClick="putData(<%=(i+j)%>,<%=i%>,<%=arrFacilityTermApp.size()%>)">
                        </td>
                      </tr>
                      <%
					  }
					  }
					  else
					  {
					  %>
                      <!--<tr bgcolor="#EEEAE3"> 
                        <td width="3%">&nbsp; 
                         
                        </td>
                        
                        <td width="97%" align="center"> 
                          <div align="left"><font size="1" face="MS Sans Serif"></font> &nbsp;
                            </font></div>
                        </td>
                      </tr>-->
                      <%
					  }
					  %>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top">
            <td width="0">
              <input type="button" name="cmdadd2" value="Deleted Terms" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:150" onClick="deleteTerms()">
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdadd" value="Add" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doNew()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doEdit()">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doSave()" disabled="disabled">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doCancel()" disabled="disabled">
              </div>
            </td>
            <td width="15%"> 
              <input type="button" name="cmddelete" value="Delete" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doDelete()">
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" onClick="dohlp()" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="callClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <input type="hidden" name="hidBeanId" value="">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl" value="" >
  <input type="hidden" name="hidAction" value="" >
  <input TYPE="hidden" name="hidcomments">

  <input type="hidden" name="general">
<input type="hidden" name="rdtermid">
<input type="hidden" name="hidLoanType">
  <input type="hidden" name="cattype" value="<%=strCategoryType%>">
  
</form>
</body>

</html>
