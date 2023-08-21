<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

 <%  //   out.println("-----"+hshValues);
	ArrayList vecData = (ArrayList)hshValues.get("vecData");
	int size=0,intQuarter=0,intYear=0;
	if(vecData!=null)
	{
		size = vecData.size();
	}
String	strQisType = Helper.correctNull((String)hshValues.get("qistype"));
String	strYear = Helper.correctNull((String)hshValues.get("year"));
String	strQuarter = Helper.correctNull((String)hshValues.get("quarter"));
if(!strYear.trim().equals(""))
{
	intYear = Integer.parseInt(strYear);
}
if(!strQuarter.trim().equals(""))
{
	intQuarter = Integer.parseInt(strQuarter);
}
String strCompId =   Helper.correctNull((String)hshValues.get("comapp_id"));
String strCompDesc = Helper.correctNull((String)hshValues.get("comapp_name"));
if(strCompId.trim().equals(""))
{
	strCompId = Helper.correctNull((String)request.getParameter("comapp_id"));
}
if(strCompDesc.trim().equals(""))
{
	strCompDesc = Helper.correctNull((String)request.getParameter("comapp_name"));
}
%>

<html>
<head>
<title>QIS Analysis</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var qistype="<%=strQisType%>";



function  doPrint()
{
	if((document.forms[0].qistype.value=="")||(document.forms[0].qistype.value=="S"))
	{
		ShowAlert('111',"Qis Type");
		//document.forms[0].qistype.focus();
		return;
		
	}
	else if((document.forms[0].year.value=="")||(document.forms[0].year.value=="S"))
	{	
		ShowAlert('111',"Year");
		//document.forms[0].year.focus();
		return;
		
	}
	else if((document.forms[0].quarter.value=="")||(document.forms[0].quarter.value=="S"))
	{	
		ShowAlert('111',"Period");
		//document.forms[0].quarter.focus();
		return;
		
	}
var comapp_id=document.forms[0].comapp_id.value;
var comapp_name=document.forms[0].comapp_name.value;
//var cmadesc=document.forms[0].cmadesc.value;
var qistype=document.forms[0].qistype.value;
var quarter=document.forms[0].quarter.value;
var year=document.forms[0].year.value;

	

	var url = appUrl+"action/qisanalysisprn.jsp?hidBeanId=qis&hidBeanGetMethod=getQisAna&comapp_id="+comapp_id+"&comapp_name="+comapp_name+"&qistype="+qistype+"&quarter="+quarter+"&year="+year;	
	//alert(url);
	
		var title = "QisAnalysis";
	var prop = "scrollbars=yes,width=775,height=450,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);

}

function callChange()
{
	
	if( (document.forms[0].qistype.value=="H1") || (document.forms[0].qistype.value=="H2") )
	{
		document.forms[0].quarter.length=3;
		document.forms[0].quarter.options[0].value="S";
		document.forms[0].quarter.options[0].text="<-- Select -->";
		document.forms[0].quarter.options[1].value="1";
		document.forms[0].quarter.options[1].text="I";
		document.forms[0].quarter.options[2].value="2";
		document.forms[0].quarter.options[2].text="II";
	}
	else
	{
		document.forms[0].quarter.length=5;
		document.forms[0].quarter.options[0].value="S";
		document.forms[0].quarter.options[0].text="<-- Select -->";
		document.forms[0].quarter.options[1].value="1";
		document.forms[0].quarter.options[1].text="I";
		document.forms[0].quarter.options[2].value="2";
		document.forms[0].quarter.options[2].text="II";
		document.forms[0].quarter.options[3].value="3";
		document.forms[0].quarter.options[3].text="III";
		document.forms[0].quarter.options[4].value="4";
		document.forms[0].quarter.options[4].text="IV";
	}
}
  

function qislist()
{	
	callDisable(false);
	if((document.forms[0].qistype.value=="")||(document.forms[0].qistype.value=="S"))
	{
		ShowAlert('111',"Qis Type");
		document.forms[0].qistype.focus();
		return;
		
	}
	else if((document.forms[0].year.value=="")||(document.forms[0].year.value=="S"))
	{	
		ShowAlert('111',"Year");
		document.forms[0].year.focus();
		return;
		
	}
	else if((document.forms[0].quarter.value=="")||(document.forms[0].quarter.value=="S"))
	{	
		ShowAlert('111',"Period");
		document.forms[0].quarter.focus();
		return;
		
	}
 	document.forms[0].hidBeanId.value="qis";
	document.forms[0].hidBeanGetMethod.value = "getQisAna";
//	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].action.value="/action/qisanalysis.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function qis()
{
		if(document.forms[0].cmdedit.disabled==true)
		{
			ShowAlert('103');			
			return;
		 }		
	document.forms[0].hidBeanId.value="qis";
	document.forms[0].hidBeanGetMethod.value = "";
	document.forms[0].action=appUrl+"action/qisdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

 
function doSave()
{
		
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/qisanalysis.jsp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].submit();
 	 
}

function doClose()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	document.forms[0].action =appUrl+"action/corppge.jsp";
	document.forms[0].submit();
}

function onloading()
{	 
	if(qistype=="")		
	document.forms[0].qistype.value ="S";
	else
	document.forms[0].qistype.value = qistype;
 	disableControls(false,true,true,false);
	callDisable(true);
	callChange();
}


function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);	
}
function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=one;		  
		}

	}
}

function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	//document.forms[0].cmdapply.disabled=bcmdApply;	
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);	
}
function onCancel()
{ 

	if (ConfirmMsg("102"))	
	{

			if((document.forms[0].qistype.value=="")||(document.forms[0].qistype.value=="S")||(document.forms[0].year.value=="S")||(document.forms[0].quarter.value=="S")||(qistype==""))
	{
		disableControls(false,true,true,false);
		callDisable(true);
		callChange();
		return;
	}

//		document.forms[0].hidBeanId.value="comratingana";
		document.forms[0].action=appUrl+"action/qisanalysis.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}




</script>
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form method="post" name="qisana">
  <jsp:include page="../share/menus.jsp" flush="true"/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="18"><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="MS Sans Serif">-&gt;</font><i> Corporate </i> <i> 
        Corporate -&gt; QIS Analysis</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
    
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <%
int strWidth=0;
int tabWidth=0;
int tableWidth;
 if(strWidth == 1)
{
	tableWidth = 15;
}
else if(strWidth == 2)
{
tableWidth = 30;
}
else
{
tableWidth=60;
}
%>
            </td>
          </tr>
        </table>Borrower Name : <%=Helper.correctNull((String)hshValues.get("comapp_name"))%>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
		  <tr> 
            <td valign="bottom"> 
              <table width="70%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr>  <td width="36%" align="center" bgcolor="#EEEAE3" height="2"><font face="MS Sans Serif" size="1"><a href="Javascript:qis()" class="blackfont"><b>QIS </b></a></font></td>
				<td width="27%" align="center" height="2" bgcolor="#71694F"><b><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>QIS Analysis</b></font></b></td>
                 
                  
                </tr>
              </table>
            </td>
          </tr>
<td>
		   <table width="100%" border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td width="7%" align="center"><font size="1" face="MS Sans Serif">Qis 
                                Type </font> </td>
                  <td width="20%" > <select name="qistype" onchange="callChange()" >
                                  <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                                  Select --&gt;</font></option>
                                  <option value="QIS" ><font size="1" face="MS Sans Serif">QIS-II </font></option>
                                  <option value="H1"><font size="1" face="MS Sans Serif">Half - Yearly Form -IIIA</font></option>
                                  <option value="H2"><font size="1" face="MS Sans Serif"> Half - Yearly Form -IIIB</font></option>
                                 
                                </select>
                    
                  </td>
                  <td width="5%"> Year <select name="year"  >
                                  <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                                  Select --&gt;</font></option>
								  <%for(int i=2000;i<=2025;i++)
								  {
									  if(intYear==i)
									  {
								  %>
								 <option selected value="<%=i%>" ><font size="1" face="MS Sans Serif"><%=i%>-<%=i+1%> </font></option>
							<%}else
									  {%>
                                  <option value="<%=i%>" ><font size="1" face="MS Sans Serif"><%=i%>-<%=i+1%> </font></option>
								  <%}}%>
                                 
                                </select>                   <b><font size="1" face="MS Sans Serif"> </font></b>  </td>
                  <td width="10%"> 
                     
                  </td>
                  <td width="3%"> </td>

				  <td width="20%">                      <b>Period<font size="1" face="MS Sans Serif"> <select name="quarter"  >
                                  <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                                  Select --&gt;</font></option>
									<%if(intQuarter==1)
									  {%>
									  <option selected value="1" ><font size="1" face="MS Sans Serif">I </font></option>
									  <%}else
									  {%>
			                          <option value="1" ><font size="1" face="MS Sans Serif">I </font></option>
									  <%}%>
								<%if(intQuarter==2)
									  {%>
									  <option selected value="2" ><font size="1" face="MS Sans Serif">II </font></option>
									  <%}else
									  {%>
			                          <option value="2" ><font size="1" face="MS Sans Serif">II </font></option>
									  <%}%>
								<%if(intQuarter==3)
									  {%>
									  <option selected value="3" ><font size="1" face="MS Sans Serif">III</font></option>
									  <%}else
									  {%>
			                          <option value="3" ><font size="1" face="MS Sans Serif">III </font></option>
									  <%}%>
								<%if(intQuarter==4)
									  {%>
									  <option selected value="4" ><font size="1" face="MS Sans Serif">IV</font></option>
									  <%}else
									  {%>
			                          <option value="4" ><font size="1" face="MS Sans Serif">IV </font></option>
									  <%}%>

									  
                                </select> </font></b>  <input type="button" name="go" value="GO" onClick="qislist()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif">
  </td>
             
                   
             
                </tr>
              </table>
			  </td>
			  </tr>
			  <tr>
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" >
 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0"  height="100%">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                  <tr> 
                                    <td width="5%" bgcolor="#71694F"> 
                                      <div align="left"><font  color="#FFFFFF">S.no</font></div>
                                    </td>
                                    <td width="40%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">Particulars</font></td>
<%								if(strQisType.trim().equals("QIS"))
{
%>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									Current Year(Holding)
									</font></td>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									 Current Year(Amount)
									</font></td>

                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									 Estimates (Holding)
									</font></td>
						    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									 Estimates (Amount)
									</font></td>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">  
										Actuals (Holding)
                                      </font></td>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                       Actuals (Amount)</font></td>

<%}
	else
	{%>
     <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									Last Year(Actuals)
									</font></td>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									 Current Year(Budget)
									</font></td>

                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									 Estimates  
									</font></td>
						    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">
									  Actuals
									</font></td>
                                    <td width="20%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">  
										Estimate
                                      </font></td>

	<%}%>
                                  </tr>
                                  <%
 	 for(int i=0;i<size;i++)
	 {
		ArrayList vecVal = (ArrayList)vecData.get(i);
		 if(vecVal!=null)
		 {
			 String strQisId = Helper.correctNull((String)vecVal.get(0));
			 String strRowType = Helper.correctNull((String)vecVal.get(1));
			 if(strRowType.trim().equals("H"))
			 {
			 %>

                                  <tr>
                                    <td width="5%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"></font></td>
                                    <td width="40%" align="left" bgcolor="#F5F3EF"> 
                                      <font size="1" face="MS Sans Serif"> <%=Helper.correctNull((String)vecVal.get(3)) %></font></td>
                                    <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      </font> </td>
									  
                                     <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      </font> </td>      
									 
                                     <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      </font> </td>      
                                     <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      </font> </td>      

									  <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
                                       </font> </td>
									  <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 

                                      </font> </td>

								  </tr>

			 <%}
			 else
			 {
 	%>
                                  <tr>
                                    <td width="5%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"><%=i+1%>.</font></td>

                                    <td width="40%" align="left" bgcolor="#F5F3EF">
                                      <font size="1" face="MS Sans Serif"> <%=Helper.correctNull((String)vecVal.get(3)) %></font></td>

                                    <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                     <font size="1" face="MS Sans Serif">
											  <%=Helper.correctNull((String)vecVal.get(4)) %>  </font> </td>
			                <td width="20%" bgcolor="#F5F3EF" align="center">
						     <font size="1" face="MS Sans Serif">
                                    <%=Helper.correctNull((String)vecVal.get(5)) %>  </font> </td>
                                     <td width="20%" bgcolor="#F5F3EF" align="center">
                                      <font size="1" face="MS Sans Serif">
                                    <%=Helper.correctNull((String)vecVal.get(6)) %>  </font> </td>
									  <td width="20%" bgcolor="#F5F3EF" align="center">
                                      <font size="1" face="MS Sans Serif">
                                    <%=Helper.correctNull((String)vecVal.get(7)) %>  </font> </td>

									  <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
<%=Helper.correctNull((String)vecVal.get(8)) %> 
                                      </font> </td>

<%								if(strQisType.trim().equals("QIS"))
{
%>
									  <td width="20%" bgcolor="#F5F3EF" align="center"> 
                                      <font size="1" face="MS Sans Serif"> 
<%=Helper.correctNull((String)vecVal.get(9)) %> 
                                      </font> </td>
<%}%>
								  </tr>

<%
			 }	 }
}
%>                             </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br>
                    <input type="hidden" name="count" value="<%=size%>">
                    <input type="hidden" name="hidBeanGetMethod" value="getQisAna">
                    <input type="hidden" name="hidBeanId" value="qis">
                    <input type="hidden" name="hidSourceUrl" value="/action/qisanalysis.jsp" >
					  <input type="hidden" name="hidBeanMethod" >
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" onClick="onEdit()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" >
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  onClick="onCancel()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="doClose()"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
			  </td>
           </tr>
		   <tr align="center">
		   <td width="0" align="center"> 
              <div align="center"> 
                <input type="button" name="cmdprint" value="Print" onClick="doPrint()"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
			  </td>
           </tr>
        </table>
      </td>
    </tr>
  </table>
   <input type="hidden" name="comapp_id" value="<%=strCompId%>">
<input type="hidden" name="comapp_name" value="<%=strCompDesc%>">
 </form>
</body>
</html>