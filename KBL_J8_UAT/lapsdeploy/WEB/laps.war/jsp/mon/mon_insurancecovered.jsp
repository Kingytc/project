<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap) 
			{
				hshValues = (java.util.HashMap) objValues;
			}

			ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vec != null) {
				vecsize = vec.size();
			}
			if (vecrec != null) {
				vecrecsize = vecrec.size();
			}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
	String strmsod=Helper.correctNull((String)request.getParameter("mon_msod"));
	if(!strmsod.equalsIgnoreCase(""))
	{
		strmsod=Helper.correctNull((String)hshValues.get("mon_msod"));
	}			
	String strstock=Helper.correctNull((String)request.getParameter("mon_stock"));
	if(!strstock.equalsIgnoreCase(""))
	{
		strstock=Helper.correctNull((String)hshValues.get("mon_stock"));
	}
	String strbkdebts=Helper.correctNull((String)request.getParameter("mon_bkdebts"));
	if(!strbkdebts.equalsIgnoreCase(""))
	{
		strbkdebts=Helper.correctNull((String)hshValues.get("mon_bkdebts"));
	}
	String strqpr=Helper.correctNull((String)request.getParameter("mon_qpr"));
	if(strqpr.equalsIgnoreCase(""))
	{
		strqpr=Helper.correctNull((String)hshValues.get("mon_qpr"));
	}
%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var cbsid ="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>";
var mon_accno ="<%= Helper.correctNull((String)request.getParameter("mon_accno"))%>";
var mon_month ="<%= Helper.correctNull((String)request.getParameter("mon_month"))%>";
var mon_year ="<%= Helper.correctNull((String)request.getParameter("mon_year"))%>";
var strcbsname ="<%= Helper.correctNull((String)request.getParameter("strcbsname"))%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdprint.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;
		 document.forms[0].cmdprint.disabled=true;	 
		 disableFields(false);
	}
	if(val=="nodata")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;		 
		 document.forms[0].cmdclose.disabled=false;
		 document.forms[0].cmdprint.disabled=true;	 
		 //disableFields(false);
	}
}

function onLoading()
{
	if("<%=vecsize%>" == 0)
	{
		disableCommandButtons("nodata");
	}
	else
	{
		disableCommandButtons("load");
		disableFields(true);
	}
	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"controllerservlet";		
		document.forms[0].hidBeanMethod.value="updateDataInsurancecovered";
		document.forms[0].hidBeanGetMethod.value="getDataInsurancecovered";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_insurancecovered.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="mon_insurancecovered.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateDataInsurancecovered";
		document.forms[0].hidBeanGetMethod.value="getDataInsurancecovered";
		document.forms[0].action=appUrl +"action/mon_insurancecovered.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	
	    document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateDataInsurancecovered";
		document.forms[0].hidBeanGetMethod.value="getDataInsurancecovered";
		document.forms[0].hidSourceUrl.value="/action/mon_insurancecovered.jsp";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit();
	}



function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		/*if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}*/
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
	/*document.forms[0].txt_insuamount.readOnly=true;
	document.forms[0].txt_insuno.readOnly=true;
	document.forms[0].txt_insuexpirydate.readOnly=true;
	document.forms[0].sel_endorsed.readOnly=true;*/
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}

function callCalender(name,i,size)
	{
	if(document.forms[0].cmdedit.disabled==true)
		{
			if(size==1)
			{
				showCal(appUrl,'txt_insuexpirydate')
			}
			else
			{
				showCal(appUrl,name);
			}	
		}
	}
	
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}	
function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_insurancecovered.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	/*else if(url=="com_takeoverworking.jsp")
	{
		document.forms[0].hidBeanId.value="comproposal";
	}*/
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
}
function doPrint(page)
  {
  	var print="print";
	var url = "<%= ApplicationParams.getAppUrl()%>action/"+page+"?hidBeanId=mmrcommon&hidBeanGetMethod=getDataInsurancecovered&cbsid="+cbsid+"&mon_accno="+mon_accno+"&mon_month="+mon_month+"&mon_year="+mon_year+"&strcbsname="+strcbsname+"&print="+print+"&mmrno="+document.forms[0].mmrno.value;
	var title = "InsuranceReport";
	var prop = "scrollbars=yes,width=850,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function showPolicy(l)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
		var flag = "y";
		var index = l;
		var size =	"<%=vecsize%>";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/mon_searchinsurancepolicy.jsp?hidBeanGetMethod=getInsuranceno&hidBeanId=Register&appno="+mon_accno+"&flag="+flag+"&cbsid="+cbsid+"&index="+index+"&size="+size;					
		var title = "Organization";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(purl,title,prop);
		}
}
</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:monthlymonitortag pageid="5"/>
					</td>
				</tr>
					<tr>
					<td class="Page_Flow">
						Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt; MSOD-&gt; Insurance
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
						<lapschoice:MonthlyMonitor />
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
          <tr> 
            <td width="20%"  align="center"  class="sub_tab_inactive"  id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Account-Wise Details</a></b> </td>
           <%if(Helper.correctNull((String)hshValues.get("mon_msod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  align="center" class="sub_tab_active"  id="prin"><b>MSOD
               </b></td>
           <%} 
              if( Helper.correctNull((String)hshValues.get("mon_qpr")).equalsIgnoreCase("y")){%>
            <td width="20%"  align="center"  class="sub_tab_inactive" id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}

		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
						<lapschoice:MonMSODTag  msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="7"/>
						<lapschoice:Monitor strSource="MMR"/>
        
<table width="98%" border="0" cellpadding="5" cellspacing="0"	class="outertable border1" align="center">
	<tr>
		<td>
		   <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">			
			  <tr>
				  <td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
					   <tr>
						 <td valign="top" height="76">
						    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							  <tr>
								<td valign="top" class="cellcontainer">
									<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
										<tr height="22" align="center" class="dataHeader">
											<td nowrap width="5%" align="center"><b>No</b></td>
											<td nowrap width="15%" align="center" ><b>Details <br>of<br> Security Cover</b></td>
											<td nowrap width="15%" align="center"><b>Insurance Amount</b></td>
											<td nowrap width="20%" align="center"><b>Insurance No</b></td>
											<td nowrap width="15%" align="center"><b>Expiry Date</b></td>
											<td nowrap width="15%" align="center"><b>Whether endorsed in <br>Bank's favour<br> with Bank's Clause</b></td>
											<td nowrap width="15%" align="center"><b>Whether Policies <br>submitted <br>to Bank</b></td>
											<td nowrap width="15%" align="center"><b>Remarks</b></td>
										</tr>
									<%if (vecrecsize > 0 && vecsize>0)
									{
										if(vecrecsize==vecsize)
										{
												for (int l = 0; l < vecsize; l++) 
												{
													out.println();
												//if (l < vecsize) {
													g1 = (ArrayList) vec.get(l);
													g2 = (ArrayList) vecrec.get(l);
													
													//out.println("----------------g1" +g1);
													//out.println("----------------g2" +g2);
									%>
									<tr class="dataGrid">
												<td width="5%" valign="center" align="center"><%=l + 1%></td>
												<td width="15%" align="center" >
													<%=Helper.correctNull((String) g1.get(0))%>
													<input type="hidden" name="txt_staticdataid"
													value="<%=Helper.correctNull((String)g1.get(0))%>" readOnly>
												</td>
												<td width="15%" align="center" >
													<input type="text" name="txt_insuamount" size="20" 
													maxlength="15"  onKeyPress="allowInteger()"
													value="<%=Helper.correctNull((String)g2.get(4))%>" readOnly>
													<!--<lapschoice:CurrencyTag name="txt_insuamount[<%=l%>]" size="20" 
													maxlength="15"  onKeyPress="allowInteger()"
													value="<%=Helper.correctNull((String)g2.get(4))%>" />-->
												</td>
												<td width="20%" align="center" >
													<input type="text" name="txt_insuno" size="20" 
													maxlength="15"  onKeyPress="allowInteger()"
													value="<%=Helper.correctNull((String)g2.get(10))%>" readOnly>
													<a href="#"
													onClick="showPolicy(<%=l%>)" style="cursor:hand" tabindex="22"><font size="1"
													face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="14"></font></a>
												</td>
												<td width="15%" align="center" > 
											        <input type="text" name="txt_insuexpirydate" size="12"
													maxlength="10"  
													value="<%=Helper.correctNull((String)g2.get(5))%>"  readOnly>
									        			<!-- <a alt="Select date from calender" href="#"
															onClick="callCalender('txt_insuexpirydate[<%//=l%>]','<%//=l%>','<%//=vecsize%>')"
															onMouseOver="window.status='Date Picker';return true;"
															onMouseOut="window.status='';return true;"><img
															src="<%//=ApplicationParams.getAppUrl()%>img/calen.gif"
															border=0 alt="Select date from calender" ></a> -->
												</td>
						<td width="20%" align="center" >
						<%String str11 = Helper.correctNull((String) g2.get(6));%>
											<!-- <select  name="sel_endorsed" value="">-->
										<%if (str11.equalsIgnoreCase("n"))
											str11	=	"No";
										if (str11.equalsIgnoreCase("y"))
											str11	=	"Yes";
										%>
											<!-- <option value="n" selected>No</option>-->
											<input type="text" name="sel_endorsed" size="5" value="<%=str11%>" readOnly>
										
											
										
										
										
										
					    </td>
						<td width="15%" align="center" > 
									 <%String str2 = Helper.correctNull((String) g2.get(7));%>
									 <select  name="sel_policies" >
									<%if (str2.equals("n"))
									{%>
									<option value="n" selected>No</option>
									<%}
									else 
									{%>
									<option value="n">No</option>
									<%
									}
									%>
									<%if (str2.equals("y"))
									{%>
									<option value="y" selected>Yes</option>
									<%}
									else 
									{%>
									<option value="y">Yes</option>
									<%
									}
									%>
								    </select>
						</td>
												<td valign="center" width="15%" >
													<textarea name="txt_insuremarks" cols="20" rows="2" 
													onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)g2.get(8))%></textarea>
												</td>
										
										<%					
					//}
												}
												}
											}
											if (vecrecsize == 0 && vecsize == 0)
											{
												for (int l = 0; l < vecsize; l++) 
												{
													//if (l < vecsize) {
														g1 = (ArrayList) vec.get(l);

														%>
									<tr class="dataGrid">
												<td width="15%" align="center" >
													<input type="text" name="txt_insuamount" size="20" style="text-align:right"
													maxlength="15"  onKeyPress="allowInteger()"
													value="" readOnly>
												</td>
												<td width="15%" align="center" >
													<input type="text" name="txt_insuno" size="20" style="text-align:right"
													maxlength="15"  onKeyPress="allowInteger()"
													value="" readOnly>
												</td>
												
                              <td width="15%" align="center" > 
                                <input type="text" name="txt_insuexpirydate2" size="12"
													maxlength="10"  
													value=""  readOnly>
                                <!-- <a alt="Select date from calender" href="#"
														onClick="callCalender('txt_insuexpirydate[<%//=l%>]','<%//=l%>','<%//=vecsize%>')"
														onMouseOver="window.status='Date Picker';return true;"
														onMouseOut="window.status='';return true;"><img
														src="<%//=ApplicationParams.getAppUrl()%>img/calen.gif"
														border=0 alt="Select date from calender" tabindex=""></a> -->
                              </td>
												<td width="20%" align="center"> 
											       <!--<select  name="sel_endorsed">
											         <option value="0" selected>No</option>
											          <option value="1">Yes</option>
											        </select>-->
											        <input type="text" name="sel_endorsed" size="5"
													maxlength="5"  
													value=" " readOnly>
											      </td>
											      
											      <td width="15%"> 
											        <select  name="sel_policies" valign="center" >
											         <option value="0" selected>No</option>
											          <option value="1">Yes</option>
											        </select>
											        
											      </td>
												<td valign="center"  width="15%" >
													<textarea name="txt_insuremarks" cols="20" rows="2" 
													onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea>
												</td>
										
											<%//}
												}
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
		</td>
	</tr>
</table>
    
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial_Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<lapschoice:hiddentag pageid='<%=PageId%>'/> 

<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">

<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
</form>
</body>
</html>
