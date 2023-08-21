<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
 if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
HashMap ht=(HashMap)hshValues.get("hsh3"); // for other (table) land&building
HashMap htab=(HashMap)hshValues.get("hsh2");// for general hs2
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
// for general values
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
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strcat="";
if(!strCategoryType.equalsIgnoreCase(""))
{
	if(strCategoryType.equalsIgnoreCase("OPS"))
	{
		strcat="Tertiary";
	}
	else 
	{
		strcat="Corporate";
	}		
}%>
<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>"; 
var varRecordflag = "<%=Helper.correctNull((String)ht.get("recordflag"))%>";
function whileLoading()
{
	disableFields(true);
	document.forms[0].hidparam.value="Absencecivicrestrictions^Marketproduct^Availabilitywater^Availabilitytransport^Proximitysourcerawmaterials^Availabilitypower^Availabilitylabour^Whetherclearanceobtainedauthority";
	document.forms[0].hidTabName.value="ExistProposed";
	document.forms[0].hidOtherMethod.value="getSSIExistProposedData";
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
			if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
			{
				document.forms[0].elements[i].readOnly=val;		  
			}			
		}
	}
function doDelete()
{
	document.forms[0].hidVal.value="Delete";
	if(varRecordflag == "Y")
	{
	if(ConfirmMsg("101"))
    {
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="removeLocationalData";
	document.forms[0].hidSourceUrl.value="/action/ssiab10_exist_propos.jsp";
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
			document.forms[0].action=appUrl+"action/ssiab10_exist_propos.jsp";
			document.forms[0].hidOtherMethod.value="getSSIExistProposedData";
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
	document.forms[0].hidVal.value ="edit";	
	document.forms[0].hidAction.value="Update";
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidDescVal1.focus();
 }
 function doSave()
 {
	 var appUrl="<%=ApplicationParams.getAppUrl()%>"; 	
	 	document.forms[0].hidRecordflag.value = varRecordflag;
		document.forms[0].hidBeanGetMethod.value="updateSSIAB10Data";
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].action=appUrl+"action/ssiab10_exist_propos.jsp";	
		document.forms[0].submit();
 }
</script>
</head>
<body  onload="javascript:whileLoading()">
<form name="existpropos" method="post" class="normal">
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
            <td class="page_flow">Home -&gt; <%=strcat %> -&gt;  Application -&gt; Tech. Feasibility -&gt; Locational Advantage</td>
          </tr>
	</table>       
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
<lapschoice:Techfeasibilitytab tabid="2" typessi='<%=strSSIType%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr> 
                             <td valign="top"></td>
							<%
							ArrayList vecCol1= new ArrayList();
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
						vecCol =(ArrayList)vecRow.get(0);
						vecCol1 =(ArrayList)vecRow.get(1);
					%>
                            <tr> 
                              <td width="22%">Absence of civic restrictions</td>					
                              <td width="32%"> 
                                <input type="text" name="hidDescVal1" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                              <td width="27%">Proximity 
                                to the source of raw materials</td>
									<% vecCol =(ArrayList)vecRow.get(1);%>
                              <td width="19%"> 
                                <input type="text" name="hidDescVal2" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Market for the product</td>
									<% vecCol =(ArrayList)vecRow.get(2);%>
                              <td width="32%"> 
                                <input type="text" name="hidDescVal3" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                              <td width="27%">Availability of Power</td>
								  <% vecCol =(ArrayList)vecRow.get(3);%>
                              <td width="19%"> 
                                <input type="text" name="hidDescVal4" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Availability of Water</td>
								  <% vecCol =(ArrayList)vecRow.get(4);%>
                              <td width="32%"> 
                                <input type="text" name="hidDescVal5" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                              <td width="27%">Availability of Labour</td>
								  <% vecCol =(ArrayList)vecRow.get(5);%>
                              <td width="19%"> 
                                <input type="text" name="hidDescVal6" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Availability of Transport</td>
								  <% vecCol =(ArrayList)vecRow.get(6);%>
                              <td width="32%"> 
                                <input type="text" name="hidDescVal7" size="25" maxlength="50" value="<%=vecCol.get(0)%>">
                              </td>
									<% vecCol =(ArrayList)vecRow.get(7);%>
									
                              <td width="27%">Whether clearance has obtained from pollution control authority?</td>
                              <td width="19%"> 
                                <input type="text" size="25" maxlength="50"  name="hidDescVal8" value="<%=vecCol.get(0)%>">
                              </td>
                              </tr>
					<%}else{%>  
						<tr> 
                              <td width="22%">Absence of civic restrictions</td>
					
                              <td width="32%"> 
                                <input type="text" name="hidDescVal1" size="25" maxlength="50" value="">
                              </td>
                              <td width="27%">Proximity 
                                to the source of raw materials</td>
									
                              <td width="19%"> 
                                <input type="text" name="hidDescVal2" size="25" maxlength="50" value="">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Market 
                                for the product</td>
									
                              <td width="32%"> 
                                <input type="text" name="hidDescVal3" size="25" maxlength="50" value="">
                              </td>
                              <td width="27%">Availability 
                                of Power</td>
								 
                              <td width="19%"> 
                                <input type="text" name="hidDescVal4" size="25" maxlength="50" value="">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Availability 
                                of Water</td>
								 
                              <td width="32%"> 
                                <input type="text" name="hidDescVal5" size="25" maxlength="50" value="">
                              </td>
                              <td width="27%">Availability 
                                of Labour</td>
								  
                              <td width="19%"> 
                                <input type="text" name="hidDescVal6" size="25" maxlength="50" value="">
                              </td>
                            </tr>
                            <tr> 
                              <td width="22%">Availability 
                                of Transport</td>
								  
                              <td width="32%"> 
                                <input type="text" name="hidDescVal7" size="25" maxlength="50" value="">
                              </td>
								  
                              <td width="27%">Whether 
                                clearance has obtained from pollution control 
                                authority?</td>
                              <td width="19%"> 
                                <input type="text" size="25" maxlength="50" value="" name="hidDescVal8">
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
                <tr>
                  <td>
                    <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="5" valign="middle"><b>Land &amp; Building</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="20%" align="center"></td>
                              <td width="18%" align="center"><b>Existing</b></td>
                              <td width="21%" align="center"><b>Proposed</b></td>
                              <td width="21%" align="center"><b>Existing</b></td>
                              <td width="20%" align="center"><b>Proposed</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td align="center">&nbsp;</td>
                              <td colspan="2" align="center">Area 
                                / Plinth Area (in Sq. meters)</td>
                              <td colspan="2" align="center">Value 
                                (Rs. in 000's)</td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="20%">Factory 
                                Land </td>
                              <%
								 ArrayList g1=null;
					if(vecsize >0)
					{
						g1 =(ArrayList)vec.get(0);%>
                              <td width="18%" align="center"> 
                                <input type="text" name="FLExA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(0))%>" onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FLPrA" size="15"  maxlength="10" value="<%=Helper.correctNull((String)g1.get(1))%>"  onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FLExV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(2))%>"  onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="FLPrV" size="15"  maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(3))%>" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="18%">Factory 
                                Bldg. </td>
                              <% g1 =(ArrayList)vec.get(1); %>
                              <td width="18%" align="center"> 
                                <input type="text" name="FBExA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(0))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FBPrA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(1))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FBExV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(2))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="FBPrV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(3))%>" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="20%">Ancillary 
                                Bldg. </td>
                              <% g1 =(ArrayList)vec.get(2); %>
                              <td width="18%" align="center"> 
                                <input type="text" name="ABExA" size="15"  maxlength="10" value="<%=Helper.correctNull((String)g1.get(0))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="ABPrA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(1))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="ABExV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(2))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="ABPrV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(3))%>" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="20%">Open 
                                Storage space</td>
                              <% g1 =(ArrayList)vec.get(3); %>
                              <td width="18%" align="center"> 
                                <input type="text" name="OSExA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(0))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="OSPrA" size="15" maxlength="10" value="<%=Helper.correctNull((String)g1.get(1))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="OSExV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(2))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="OSPrV" size="15" maxlength="8" style="Text-align:right" value="<%=Helper.correctNull((String)g1.get(3))%>" onKeyPress="allowNumber(this)">
                              </td>
                              <%}else{%>
                              <td width="18%" align="center"> 
                                <input type="text" name="FLExA" size="15"  maxlength="10"  value="" onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FLPrA" size="15"  maxlength="10" value=""  onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FLExV" size="15" maxlength="8" style="Text-align:right" value=""  onKeyPress="allowNumber(this)" >
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="FLPrV" size="15" maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="18%">Factory 
                                Bldg. </td>
                              <td width="18%" align="center"> 
                                <input type="text" name="FBExA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FBPrA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="FBExV" size="15"  maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="FBPrV" size="15"  maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="20%">Ancillary 
                                Bldg. </td>
                              <td width="18%" align="center"> 
                                <input type="text" name="ABExA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="ABPrA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="ABExV" size="15" maxlength="8" style="Text-align:right"  value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="ABPrV" size="15" maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="20%">Open 
                                Storage space</td>
                              <td width="18%" align="center"> 
                                <input type="text" name="OSExA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="OSPrA" size="15" maxlength="10" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="21%" align="center"> 
                                <input type="text" name="OSExV" size="15" maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <td width="20%" align="center"> 
                                <input type="text" name="OSPrV" size="15" maxlength="8" style="Text-align:right" value="" onKeyPress="allowNumber(this)">
                              </td>
                              <%}%>
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
  </table><br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidVal">
<input type="hidden" name="hidDesc1" value="Absencecivicrestrictions">
<input type="hidden" name="hidDesc2" value="Marketproduct">
<input type="hidden" name="hidDesc3" value="Availabilitywater">
<input type="hidden" name="hidDesc4" value="Availabilitytransport">
<input type="hidden" name="hidDesc5" value="Proximitysourcerawmaterials">
<input type="hidden" name="hidDesc6" value="Availabilitypower">
<input type="hidden" name="hidDesc7" value="Availabilitylabour">
<input type="hidden" name="hidDesc8" value="Whetherclearanceobtainedauthority">
<input type="hidden" name="hidTotalDesc" value="8">
<input type="hidden" name="otherGenTable" value="UpdateSSIExistProposedData">
<input type="hidden" name="genTable" value="yes">
</form>
</body>
</html>
