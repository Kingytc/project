<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<html>
<head>
<title>Setuprate</title>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

<%

//String strType = Helper.correctNull(request.getParameter("hidval"));
String strWrkflowtype="setuprate";


String code=Helper.correctNull(request.getParameter("prd_code"));

String  slno="",fromamount="",toamount="",interest="";
String 	strMaxLen="";
String val="";
String val1="";
int size=0;
	ArrayList v = (ArrayList) hshValues.get("vecData");
	

	
	int vecsize=0;
if(v!=null)
{
	vecsize =v.size();

}
%>

</script>
<script >

var appUrl="<%//=ApplicationParams.getAppUrl()%>";

function setData()
	{
		doAfterEdit();
	}

function doAfterEdit()
	{
		
		disableCommandButtons("load");
		disableFields(true);
	}

function disableCommandButtons(val)

	{
		//alert(val);
	  if(val=="load")
	  {
		 
		  document.forms[0].cmdEdit.disabled=false;
		  document.forms[0].cmdApply.disabled=true;
		  document.forms[0].cmdCancel.disabled=true;
		  document.forms[0].cmdClose.disabled=false;
	  }
	  if(val=="Edit")
	  {
		 document.forms[0].cmdEdit.disabled=true;
		 document.forms[0].cmdApply.disabled=false;
		 document.forms[0].cmdCancel.disabled=false;
		 document.forms[0].cmdClose.disabled=true;
		 	disableFields(false);
	  }
	  for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=false;
			}
			
		}
	}

function doEdit()
	{
		disableCommandButtons("edit");
		disableFields(false);
	}



function doSave()
	{	
		

		var myinttot = 0;
		var mytotot = 0;
		
		for (i=0;i<5;i++)
		{
			var slno = i +1;

			if(document.forms[0].fromamount[i].value!=""|| document.forms[0].fromamount[i].value=="0.00")
			{
				
				
				if(document.forms[0].toamount[i].value==""|| document.forms[0].toamount[i].value=="0.00")
				{
					alert("Enter To amount for serial No "+slno)
					document.forms[0].toamount[i].focus();
					return false;
				}
			
				if(document.forms[0].interest[i].value=="" ||document.forms[0].interest[i].value=="0.00" )
				{
					alert("Enter Interest for serial No "+slno)
					document.forms[0].interest[i].focus();
					return false;
				}
			
				if(parseFloat(document.forms[0].toamount[i].value) < parseFloat(document.forms[0].fromamount[i].value))
				{
					alert("To amount cannot be lesser than From amount of serial No "+slno)
					document.forms[0].toamount[i].focus();
					return false;
				}
			 myinttot =  myinttot + parseFloat(document.forms[0].interest[i].value)
			 mytotot = parseFloat(document.forms[0].toamount[i].value)
		  
			 }

			
		
		}
		
		if(myinttot > 100)
		{
		alert("Total intrest is greater than 100%.Total interest cannot be more than 100%");
		return false;
		}		
		code="<%=code%>";
		document.forms[0].cmdApply.disabled = true;
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
		document.forms[0].action=appUrl+"controllerservlet?code="+code;
		/*alert(document.forms[0].selid.value);
		document.forms[0].selid.value=parseInt((document.forms[0].selid.value))+1;*/
//alert(document.forms[0].selid.value);
		document.forms[0].submit();

	}
function setDesc()
	{	
		
		if(document.forms[0].selid.selectedIndex > 1)
		{
		//document.forms[0].hiddesc.value = parseInt(document.forms[0].selid.value)+1;	
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
		}
		else
		{
		
		//document.forms[0].hiddesc.value = "0";
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if (document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].value = "";		  
			}	
			}
		}
	}

function disval()
	{
		val="<%=val%>";
		//val = document.forms[0].hiddesc.value 
var x;
		if (val != "")
		{
			
		x=eval(val);
						
		}
		else 
		{
			x=0;
		}
		if (x==0)
		{
					document.forms[0].selid.selectedIndex = x; 
		}
		else
		{
					document.forms[0].selid.selectedIndex = x+1;
		}

	/*	if (x != "")

		{
			
		}	else
		{
		document.forms[0].selid.selectedIndex = 2;
		}*/
	}
function getValue()
	{

			//document.forms[0].hidval.value="get";
			document.forms[0].action = appUrl+"action/setuprate.jsp";
			document.forms[0].hidBeanId.value="setuprate";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
			document.forms[0].submit();
   }

function doCancel()
	{
		if(ConfirmMsg(102))
		{
		code="<%=code%>";
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
		document.forms[0].action=appUrl+"controllerservlet?code="+code;
		document.forms[0].submit();
		}
		enableButtons(false,true,true,false);
	}


function doClose()
	{
		if( ConfirmMsg(100) )
		{
		document.forms[0].hidBeanGetMethod.value = "";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setsearchproducts.jsp";
		document.forms[0].submit();
			//document.forms[0].action =appUrl+"action/setproductmain.jsp";
			//document.forms[0].submit();
		}
	}


function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				document.forms[0].elements[i].readOnly=val;		  
				
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;
		  
			}

		}
	}

	function loadValues()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
			  
			}
			
		}
		enableButtons(false,true,true,false);
	}

function enableButtons(bool2,bool3,bool4,bool5)
{
	
	document.forms[0].cmdEdit.disabled=bool2;
	document.forms[0].cmdApply.disabled=bool3;
	document.forms[0].cmdCancel.disabled=bool4;
	document.forms[0].cmdClose.disabled=bool5;

}
function callFlowtype(type)
{
	
	if (type == "setuprate")
	{
		code=document.forms[0].prdCode.value;
		
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appURL+"controllerservlet?code="+code;
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
		
	}
	else
	{
	document.forms[0].wrk_flowtype1.value=type;
	document.forms[0].action=appUrl+"action/setintterms.jsp?wrk_flowtype1="+type;

	
	}

	document.forms[0].submit();

}

function callOtherTab(url)
	{
		if(!document.forms[0].cmdApply.disabled)
		{
			ShowAlert(103);
		}
		else
		{
			 if(url=="setproducts.jsp" ||  url=="prodinterest.jsp" || url=="prodsanclimit.jsp")
			 {
				document.forms[0].hidBeanGetMethod.value="getData";
			 }
			 if(url=="setprdauth.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
			 }
			 
			 if(url=="setprddoc.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getDocData";
			 }

			 if(url=="setprdworkflow.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getWorkflowData";
			 }

			 if(url=="setprdintterms.jsp")
			{
			//document.forms[0].hidBeanId.value="setproducts";
			//document.forms[0].hidBeanGetMethod.value="getIntTermsData";
			}

			 document.forms[0].prd_code.value=document.forms[0].prdCode.value;
			 document.forms[0].action=appUrl+"action/"+url;
			 document.forms[0].submit();
		}
	}


</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399;border-style: groove}
a:hover {  color: #FF3300}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body bgcolor="#EEEAE3" text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="javacscript:loadValues()">

<form name="documentsfrm" method="post" >
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home <font face="Times New Roman" size="3"><b><font face="Times New Roman" size="3"><b><i><font face="Times New Roman" size="3"><b><font face="Times New Roman" size="3"><b><font face="MS Sans Serif">-&gt;</font></b></font></b></font></i><font face="MS Sans Serif"> 
        </font> <i> Setup</i></b></font></b></font> -&gt; Products -&gt; Search 
        Products -&gt; Terms and Interest</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td> 
        <table width="95%" border="0" cellspacing="2" cellpadding="3" align="left">
          <tr> 
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setproducts.jsp')" class="blackfont">Products</a></b></font></td>
            <td height="2" width="9%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF"><a href="javascript:callOtherTab('produsedby.jsp')" class="blackfont">Used 
              By</a></font></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdauth.jsp')" class="blackfont">Authority</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprddoc.jsp')" class="blackfont">Documents</a></b></font></td>
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdworkflow.jsp')" class="blackfont">Flowpoints</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodprocesscharges.jsp')" class="blackfont">Charges 
              </a></b></font></td>
            <td height="2" width="8%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodsanclimit.jsp')" class="blackfont">Powers</a></b></font></td>
            <td height="2" width="13%" bgcolor="#71694F" align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Int. 
              &amp; Terms </font></b></font></td>
            <td height="2" width="19%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodinterest.jsp')" class="blackfont">Repayment 
              Capacity</a></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top" height="133"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" height="100%" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" height="0%">
                <tr> 
                  <td colspan="4">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3"  >
                      <tr> 
                                          <td colspan="6"><fieldset> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="3"  >
                                              <tr> 
                                                <td><lapschoice:products /></td>
                                              </tr>
                                            </table>
                                            </fieldset> </td>
                                        </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td colspan="4">
                    <table width="37%" border="0" cellspacing="3" cellpadding="3">
                      <tr bgcolor="#EEEAE3"> 
                        <td width="27%" align="center" <%if(strWrkflowtype.equals("fixed") || strWrkflowtype.equals("") ){%>
                                                  bgcolor="#71694F"<%}%> ><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("fixed")|| strWrkflowtype.equals("") ){%>
                                                  color="#71694F"<%}%> ><b> <a href="javascript:callFlowtype('fixed')" class="blackfont">Fixed Rate</a></b></font></td>
                        <td width="35%" align="center" <%if(strWrkflowtype.equals("floating")){%>
                                                  bgcolor="#71694F"<%}%>><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("floating")){%>
                                                  color="#Ffffff"<%}%>><b> <a href="javascript:callFlowtype('floating')" class="blackfont">Floating Rate</a></b></font></td>
                        <td width="38%" align="center" <%if(strWrkflowtype.equals("setuprate")){%>
                                                  bgcolor="#71694F"<%}%>><font size="1" face="MS Sans Serif" <%if(strWrkflowtype.equals("setuprate")){%>
                                                  color="#Ffffff"<%}%>><b> Step 
                          Up Rate</b></font></td>
                      </tr>
                    </table>

                          <table width="100%" border="0" cellspacing="0" cellpadding="5">
                            <tr> 
                              <td width="50%"> 
                                <table width="60%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" >
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="8">
                                        <tr bgcolor="#71694F" align="center"> 
                                          
                                    <td width="12%"><font size="1" color="#FFFFFF" face="MS Sans Serif">S.No</font></td>
                                          <td width="32%"><font size="1" color="#FFFFFF" face="MS Sans Serif">From Amount</font></td>
                                          <td width="31%"><font  color="#FFFFFF">To Amount</font></td>
                                          <td width="25%"><font size="1" color="#FFFFFF" face="MS Sans Serif">Interest 
                                            (%)</font></td>
                                        </tr>
                                     
									  <%
								ArrayList g1=null;
					 for (int l=0;l<5;l++)
					 {
					    int colSize=0;
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)v.get(l);
							if(g1!=null)
							{
							   colSize = g1.size();
       						}
						 }

						  if(colSize>0)		
						  {
 										%>

                      <tr> 
                        <td width="5%" align="center"><font size="1" face="MS Sans Serif"><%=l+1%></font></td>
                        <td width="35%" align="center"> 
                          <input type="text"  name="fromamount"
						value="<%=Helper.correctNull((String)g1.get(0))%>" size="15" style="text-align:right" onkeypress="allowNumber(this)" onblur ="roundtxt(this)"maxlength="10">
                        </td>
							
						<td width="35%" align="center"> 
                        <input type="text"  name="toamount" 
						 value="<%=Helper.correctNull((String)g1.get(1))%>"size="15" style="text-align:right" onkeypress="allowInteger(this);allowNumber(this)" onblur ="roundtxt(this)" maxlength="10">
                        </td>
						
						<td width="35%" align="center"> 
                        <input type="text"  name="interest" 
						 value="<%=Helper.correctNull((String)g1.get(2))%>" size="6" style="text-align:right" onkeypress="allowNumber(this)"  onblur="roundtxt(this);checkPercentage(this)" maxlength="5">
                        </td>
                     </tr>
                       <%}
							
							  else  
									
							  {%>
                        <tr> 
                        <td width="10%" align="center"> <font size="1" face="MS Sans Serif"><%=l+1%> 
                        </font> </td>
							<td width="15%" align="center"> <font size="1" face="MS Sans Serif"> 
                                <input type="text" name="fromamount"
											 size="15"  
											onKeyPress="allowNumber(this)" onblur ="roundtxt(this)"
											 maxlength="10" style="text-align:right">
                                      </font> </td>
                                    <td width="15%" align="center"> <font size="1" face="MS Sans Serif"> 
                                      <input type="text" name="toamount"
											 size="15"  
											 onKeyPress="allowNumber(this)"onblur ="roundtxt(this)"
										 maxlength="10" style="text-align:right">
                                      </font> </td>
                                    <td width="15%" align="center">
                                      <input type="text" name="interest" maxlength="5"
											 size="6"   onKeyPress="allowNumber(this)"  onblur="roundtxt(this);checkPercentage(this)" style="text-align:right">
                                       
                                      </td>
                                  </tr>
                                  <%	}
											  
											   }%>

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
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdEdit" value="Edit" onClick="disableCommandButtons('Edit')" class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdApply" value="Save" onClick="doSave()" class="buttonStyle">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdCancel" value="Cancel"  onCLick="doCancel()" class="buttonStyle">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" class="buttonHelp">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdClose" value="Close" onClick="doClose()" class="buttonClose">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>



  <input type="hidden" name="hidtype" value="">
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl" value="/action/setuprate.jsp">
<input type="hidden" name="wrk_flowtype1" value="<%=strWrkflowtype%>">
<input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>" >
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">


<input type="hidden" name="hidval" >
</form>
</body>
</html>
