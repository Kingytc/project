<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
 if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
HashMap ht=(HashMap)hshValues.get("hsh1");
HashMap htab=(HashMap)hshValues.get("hsh2");
ArrayList vec = null;
int vecsize=0;
 if (ht != null)
 {  
	 vec = (ArrayList)ht.get("vecVal");   
 }
if(vec!=null)
{
	vecsize =vec.size();	
}
ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
int vecrowsize =0;
String strgenid="";
if(htab.size()>0 && htab != null)
{	
	vecRow = (ArrayList)htab.get("vecRow");
	
	if(vecRow !=null)
	{
		vecrowsize = vecRow.size();
	}	
}
HashMap hshMap = new HashMap();
hshMap = (HashMap) hshValues.get("hsh1");
%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" >
        var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";      
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varrecordflag ="<%=Helper.correctNull((String)hshMap.get("recordflag"))%>";
function chkmon()
{
var aaa  = document.forms[0].hidDescVal4.value;
if (aaa>31)
{
	alert("Maximum 31 days in a month !!!");
	document.forms[0].hidDescVal4.value="";
	document.forms[0].hidDescVal4.focus();	
}
}
function whileLoading()
{	 	
	document.forms[0].units.disabled=true;
	disableFields(true);
	document.forms[0].hidparam.value="TechnicalFeasibility^Nameoftheproducts^ManufacturingProcessInBrief^Noofworkingdaysinmonth^Noofshiftsinday";
	document.forms[0].hidTabName.value="TechnicalFeasibility";
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function disableFields(val)
	{		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{			
		if(document.forms[0].elements[i].type=="select-one")
			{			
			document.forms[0].elements[i].disabled=val;		  
			}	if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
			{
				document.forms[0].elements[i].readOnly=val;		  
			}			
		}
	}
function doDelete()
{
//	document.forms[0].hidVal.value="Delete";
	if(varrecordflag == "Y"){
	if(ConfirmMsg("101"))
    {
	document.forms[0].hidVal.value="Delete";
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="removeLocationalData";
	document.forms[0].hidSourceUrl.value="/action/ssiab10_technicalfeasb.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
    }
	}
}
  
  function doCancel()
	{
		
	if(ConfirmMsg(102))
	{
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].hidBeanId.value="arrears";
				document.forms[0].action=appUrl+"action/ssiab10_technicalfeasb.jsp";
				document.forms[0].hidOtherMethod.value="getSSIProductData";
				document.forms[0].hidMethod.value="getGeneralData";
				document.forms[0].submit();
	}
	}

function doClose()
{
	if(ConfirmMsg(100))
	{
		 document.forms[0].action=appUrl+"action/agrpage.jsp";
		 document.forms[0].submit();
	 }
}

 function doEdit()
  { 	
	disableFields(false);
	enableButtons(true,false,false,false,true);	
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	document.forms[0].hidVal.value ="edit";	
	document.forms[0].hidDescVal1.focus();
 }
   function doSave()
 {
		var appUrl="<%=ApplicationParams.getAppUrl()%>";	
		document.forms[0].hidBeanGetMethod.value="updateSSIAB10Data";
		document.forms[0].hidRecordflag.value=varrecordflag;
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].action=appUrl+"action/ssiab10_technicalfeasb.jsp";	
		document.forms[0].submit();
 }
</script>
</head>
<body onload="javascript:whileLoading()">
<form name="technical" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
           <td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Tech. Feasibility -&gt; Product Details 
 </td>
          </tr>
  </table>  
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>   
<lapschoice:Techfeasibilitytab tabid="1" typessi='<%=strSSIType%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td>				 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr> 
                              <td width="35%">Feasibility Report</td>
                            </tr>
                            <%if(hshValues.size()>0 && hshValues != null && vecrowsize >0){
						vecCol =(ArrayList)vecRow.get(0);%>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal1" cols="125" wrap="VIRTUAL" rows="5"><%=Helper.correctNull((String)vecCol.get(0))%> </textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%">Name 
                                of the product(s) including by-products & its 
                                use</td>
                            </tr>
                            <% vecCol =(ArrayList)vecRow.get(1);%>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal2" cols="125" wrap="VIRTUAL" rows="5"><%=Helper.correctNull((String)vecCol.get(0))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%">Manufacturing 
                                Process, in brief</td>
                            </tr>
                            <% vecCol =(ArrayList)vecRow.get(2);%>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal3" cols="125" wrap="VIRTUAL" rows="5"><%=Helper.correctNull((String)vecCol.get(0))%></textarea>
                              </td>
                            </tr>
                            <%}else{%>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal1" cols="125" wrap="VIRTUAL" rows="5"> </textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%">Name 
                                of the product(s) including by-products & its 
                                use </td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal2" cols="125" wrap="VIRTUAL" rows="5"> </textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%">Manufacturing 
                                Process, in brief</td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="hidDescVal3" cols="125" wrap="VIRTUAL" rows="5"></textarea>
                              </td>
                            </tr>
                            <%}%>
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td colspan="4"><b>Capacity 
                                      of Units / Quantity in kg. / Volume in litres</b></td>
                                  </tr>
                                  <tr> 
                                    <td width="24%" align="center"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                                        <tr> 
                                          <td valign="top"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                               <tr> 
                                                <td valign="top"> 
                                                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
                                                    <tr> 
                                                      <td> 
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                                                          <tr align="center" class="dataheader"> 
                                                            <td width="3%"><b>S.No</b></td>
                                                            <td width="24%"><b>Description of the Product/s</b></td>
                                                            <td width="15%"><b>Units</b></td>
                                                            <td width="15%"><b>Licensed</b></td>
                                                            <td width="13%"><b>Installed</b></td>
                                                            <td width="13%"><b>Operating</b></td>
                                                          </tr>
                                                          <%ArrayList g1=null;					
					 for (int l=0;l<3;l++)
					 {						
						int colSize=0;						 
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)vec.get(l);
							if(g1!=null)
							{
							   colSize = g1.size();
       						}
						 }											
						 if(colSize>0)	
						  {%>
                                                          <tr class="datagrid"> 
                                                            <td align="center" width="3%"><%=l+1%></td>
                                                            <td width="24%" align="center" valign="middle"> 
                                                              <input type="text" name="products" size="30"  value="<%=Helper.correctNull((String)g1.get(2))%>" maxlength="75">
                                                              </td>
                                                            <td width="15%" align="center"> 
                                                              <select name="units">
                                                                <option value="">Select</option>
                                                                <option value="Ton"
								<%
									if((Helper.correctNull((String)g1.get(3))).equals("Ton"))
									out.println("selected");
								%>
								>Ton</option>
                                <option value="Litres"
							<%	if((Helper.correctNull((String)g1.get(3))).equals("Litres"))
									out.println("selected");
							%>
							>Litres</option>
                            <option value="Numbers" 
							<%	
								if((Helper.correctNull((String)g1.get(3))).equals("Numbers"))
									out.println("selected");
							%>
								>Numbers</option>
                                                              </select>
                                                            </td>
                                                            <td width="15%" align="center"> 
                                                              <input type="text" name="licenced" size="15" value="<%=Helper.correctNull((String)g1.get(4))%>" onKeyPress="allowNumber(this)" maxlength="12">
                                                            </td>
                                                            <td width="13%" align="center"> 
                                                              <input type="text" name="installed" size="15" value="<%=Helper.correctNull((String)g1.get(5))%>" onKeyPress="allowNumber(this)" maxlength="12">
                                                            </td>
                                                            <td width="13%" align="center"> 
                                                              <input type="text" name="operating" size="15" value="<%=Helper.correctNull((String)g1.get(6))%>" onKeyPress="allowNumber(this)" maxlength="12">
                                                            </td>
                                                          </tr>
                                                          <%
						
								}
						else
						 {
					%>
                                                          <tr class="datagrid"> 
                                                            <td align="center" width="3%"><%=l+1%></td>
                                                            <td width="24%" align="center" valign="middle"> 
                                                              <input type="text" name="products" size="30" value="" maxlength="99">
                                                              </td>
                                                            <td width="15%" align="center"> 
                                                              <select name="units">
                                                                <option>Select</option>
                                                                <option>Ton</option>
                                                                <option>Litres</option>
                                                                <option>Numbers</option>
                                                              </select>
                                                            </td>
                                                            <td width="15%" align="center"> 
                                                              <input type="text" name="licenced" size="15"  onKeyPress="allowNumber(this)" maxlength="12">
                                                            </td>
                                                            <td width="13%" align="center"> 
                                                              <input type="text" name="installed" size="15" onKeyPress="allowNumber(this)"  maxlength="6">
                                                            </td>
                                                            <td width="13%" align="center"> 
                                                              <input type="text" name="operating" size="15" onKeyPress="allowNumber(this)"  maxlength="6">
                                                            </td>
                                                          </tr>
                                                          <%}}%>
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
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                                  <tr> 
                                    <td width="25%">No. 
                                      of working days in a month and</td>
                                    <%
					if(vecrowsize >0)
					{
						vecCol =(ArrayList)vecRow.get(3);
					%>
                                    <td width="12%"> 
                                      <input type="text" name="hidDescVal4" size="5" maxlength="2" value= "<%=Helper.correctNull((String)vecCol.get(0))%>" onKeyPress="allowNumber(this)" onBlur="chkmon()">
                                    </td>
                               <td width="15%">No. 
                                of shifts in a day</td><%									  vecCol =(ArrayList)vecRow.get(4);%>
                                    <td width="48%"> 
                                      <input type="text" name="hidDescVal5" size="5" maxlength="1" value= "<%=Helper.correctNull((String)vecCol.get(0))%>" onKeyPress="allowNumber(this)">
                                    </td>
                                    <%
					}
					else
					 {
					%>
                                    <td width="12%"> 
                                      <input type="text" name="hidDescVal4" size="5" value= "" maxlength="2" onKeyPress="allowNumber(this)" onBlur="chkmon()">
                                    </td>
                                    <td width="15%">No. 
                                      of shifts in a day</td>
                                    <td width="48%"> 
                                      <input type="text" name="hidDescVal5" size="5" value= "" maxlength="1" onKeyPress="allowNumber(this)">
                                    </td>
                                    <%
					}
					
					%>
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
      </td>
    </tr>
  </table>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>  
  <input type="hidden" name="hidVal">
  <input type="hidden" name="hidDesc1" value="TechnicalFeasibility">
  <input type="hidden" name="hidDesc2" value="Nameoftheproducts">
  <input type="hidden" name="hidDesc3" value="ManufacturingProcessInBrief">
  <input type="hidden" name="hidDesc4" value="Noofworkingdaysinmonth">
  <input type="hidden" name="hidDesc5" value="Noofshiftsinday">
  <input type="hidden" name="hidTotalDesc" value="5">
  <input type="hidden" name="otherGenTable" value="UpdateSSIProductData">
  <input type="hidden" name="genTable" value="yes">
</form>
</body>
</html>
