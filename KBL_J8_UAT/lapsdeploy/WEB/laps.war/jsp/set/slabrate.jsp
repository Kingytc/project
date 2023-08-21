<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld" %>
<lapschoice:handleerror />
<html>
<head>
<title>SLAB RATE</title>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
<%
String strWrkflowtype="setuprate";
String code=Helper.correctNull(request.getParameter("prd_code"));
String val="";
ArrayList v = (ArrayList) hshValues.get("vecData");
String strprdcode = Helper.correctNull(Helper.correctNull((String)hshValues.get("prd_code")));
int vecsize=0;
if(v!=null)
{
	vecsize =v.size();

}
%>

</script>
<script >

var appUrl="<%//=ApplicationParams.getAppUrl()%>";
var prdcode = "<%=strprdcode%>";

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
		 
		  document.forms[0].cmdedit.disabled=false;
		  document.forms[0].cmdsave.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdclose.disabled=false;
	  }
	  if(val=="Edit")
	  {
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmdclose.disabled=true;
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
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].prd_code.value=prdcode;
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/slabrate.jsp";
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
		document.forms[0].hidBeanGetMethod.value="getData";
		//document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
		document.forms[0].action=appUrl+"action/slabrate.jsp?code="+code;
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
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

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
		if(!document.forms[0].cmdsave.disabled)
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

function doEdit()
{
	disableCommandButtons('Edit');
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="javacscript:loadValues()">
<form name="documentsfrm" method="post" class="normal" >
  <lapstab:setproductstab tabid="8" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt;
         Setup -&gt; Retail &amp; Agriculture Products -&gt;  
        Products -&gt; Interest and Terms -&gt; Slab Rate</td>
    </tr>
  </table>

<%--   <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="2" cellpadding="3" align="left">
          <tr> 
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setproducts.jsp')" >Products</a></b></font></td>
            <td height="2" width="9%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF"><a href="javascript:callOtherTab('produsedby.jsp')" >Used 
              By</a></font></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdauth.jsp')" >Authority</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprddoc.jsp')" >Documents</a></b></font></td>
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdworkflow.jsp')" >Flowpoints</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodprocesscharges.jsp')" >Charges 
              </a></b></font></td>
            <td height="2" nowrap width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodsanclimit.jsp')" >Delegated Powers</a></b></font></td>
            <td height="2" width="13%" bgcolor="#71694F" align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Int. 
              &amp; Terms </font></b></font></td>
            <td height="2" width="19%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodinterest.jsp')" >Repayment 
              Capacity</a></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
--%>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
      <td valign="top" height="133"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="4">
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
                      <tr> 
                                          <td colspan="6"><fieldset> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
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
                    <table width="37%" border="0" cellspacing="3" cellpadding="3" class="outertable">
                      <tr > 
                        <td width="25%" align="center" <%if(!strWrkflowtype.equals("fixed") || strWrkflowtype.equals("") ){%>
                                                 class="sub_tab_inactive"<%}%> ><b> <a href="javascript:callFlowtype('fixed')" >Fixed Rate</a></b></td>
                        <td width="25%" align="center" <%if(!strWrkflowtype.equals("floating")){%>
                                                  class="sub_tab_inactive"<%}%>><b> <a href="javascript:callFlowtype('floating')" >Floating Rate</a></b></td>
                         
                        <td width="25%" nowrap align="center" <%if(!strWrkflowtype.equals("combo")){%>
                                                  class="sub_tab_inactive"<%}%>><b> <a href="javascript:callFlowtype('combo')" >Combo 
                          Rate</a></b></td>
                        
						<td width="25%" align="center" <%if(strWrkflowtype.equals("setuprate")){%>
                                                  class="sub_tab_active"<%}%>><b> Slab Rate</b></td>
                      </tr>
                    </table>

                          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                            <tr> 
                              <td width="50%"> 
                                <table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                        <tr class="dataheader" align="center"> 
                                          
                                    <td width="12%">S.No</td>
                                          <td width="32%">From Amount</td>
                                          <td width="31%">To Amount</td>
                                          <td width="25%">Interest 
                                            (%)</td>
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

                      <tr class="datagrid"> 
                        <td width="5%" align="center"><%=l+1%></td>
                        <td width="35%" align="center"> 
                          <lapschoice:CurrencyTag  name="fromamount"
						value='<%=Helper.correctNull((String)g1.get(0))%>' size="15" style="text-align:right" maxlength="10" />
                        </td>
							
						<td width="35%" align="center"> 
                        <lapschoice:CurrencyTag  name="toamount" 
						 value='<%=Helper.correctNull((String)g1.get(1))%>' size="15" style="text-align:right"  maxlength="10" />
                        </td>
						
						<td width="35%" align="center"> 
                        <input type="text"  name="interest" 
						 value="<%=Helper.correctNull((String)g1.get(2))%>" size="6" style="text-align:right" onkeypress="allowNumber(this)"  onblur="roundtxt(this);checkPercentage(this)" maxlength=5>
                        </td>
                     </tr>
                       <%}
							
							  else  
									
							  {%>
                        <tr class="datagrid"> 
                        <td width="10%" align="center"> <%=l+1%> 
                        </td>
							<td width="15%" align="center"> 
                                <lapschoice:CurrencyTag  name="fromamount"
											 size="15"  
											 maxlength="10" style="text-align:right"/>
                                       </td>
                                    <td width="15%" align="center"> 
                                     <lapschoice:CurrencyTag  name="toamount"
											 size="15"  
										 maxlength="10" style="text-align:right"/>
                                       </td>
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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />


  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name=hidtype value="">
<input type="hidden" name="wrk_flowtype1" value="<%=strWrkflowtype%>">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("prdCode"))%>" >
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hidval" >
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
