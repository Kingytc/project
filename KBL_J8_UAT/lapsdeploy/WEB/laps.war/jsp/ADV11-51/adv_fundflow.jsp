<%@include file="../share/directives.jsp"%>
<%	
String strPage=Helper.correctNull((String)request.getParameter("pageval"));
	ArrayList vecData =null;
	String []strCurrYear = new String[4];
	String []strPrevYear = new String[4];
	String []strCurrFinancialType = new String[4];
	String []strPrevFinancialType = new String[4];
	int totnoofyears =0;
	int totalsize =0;
	if(hshValues.size()>0 && hshValues != null)
	{
		totalsize = Integer.parseInt((String)hshValues.get("totvalue"));
		totnoofyears = Integer.parseInt((String)hshValues.get("totalnoofyears"));
	}
	if(hshValues.size()>0 && hshValues != null)	
	{
		for(int j=0; j<4;j++)
		{
			strCurrYear[j]= Helper.correctNull((String)hshValues.get("fincurryear"+Integer.toString(j+1)));	
			strPrevYear[j]= Helper.correctNull((String)hshValues.get("finprevyear"+Integer.toString(j+1)));	
			if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("A"))
			{
			strCurrFinancialType[j]= "Audited";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("U"))
			{
			strCurrFinancialType[j]= "Unaudited";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("E"))
			{
			strCurrFinancialType[j]= "Estimated";
			}
			else if(Helper.correctNull((String)hshValues.get("fincurrtype"+Integer.toString(j+1))).equals("P"))
			{
			strCurrFinancialType[j]= "Projection";
			}
			else
			{
			strCurrFinancialType[j]= "";
			}
			strPrevFinancialType[j]= Helper.correctNull((String)hshValues.get("finprevtype"+Integer.toString(j+1)));	
		}
	}
	else
	{
		for(int j=0; j<4;j++)
		{
			strCurrYear[j]="";
			strPrevYear[j] = "";
			strCurrFinancialType[j] ="";
			strPrevFinancialType[j] ="";
		}
	}
	String strcmaindex=Helper.correctNull((String)request.getParameter("hidcmano1"));
	if(strcmaindex.equalsIgnoreCase(""))
	{
	strcmaindex=Helper.correctNull((String)hshValues.get("cma_index"));
	}%>
<html>
<head>
<title>Fund Flow</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varyearfrom = "<%=totnoofyears%>";
function onloading()
{
	var sel_divID="<%=Helper.correctNull((String)hshValues.get("sel_divID"))%>";			
	document.forms[0].sel_divID.value=sel_divID;
	disableFields(true);
}
function onPrev()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)-3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)-3;
		document.forms[0].action = appUrl+"action/comdynamicfundflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}
function onNext()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)+3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)+3;
		document.forms[0].action = appUrl+"action/comdynamicfundflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/"+"comproposalsearch.jsp";
		document.forms[0].submit();
	}	
}
function callAssess(page,flowtype)
{		
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDataFinancials";	
	document.forms[0].submit();	 
}
function doPrint()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;

	if(document.forms[0].identity.value == "")
	{
		var purl = appUrl+"action/comfundflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=FU&appno="+appno+"&yearfrom="+yearfrom;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";

        	}
	       else
	       {
		var purl = appUrl+"action/comfundflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=FU&appno="+appno;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
		xpos = (screen.width - 700) / 2;
		ypos = (screen.height - 550) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
	}
		window.open(purl,title,prop);
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false)
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
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doSave()
{	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_divID.value="0";
	document.forms[0].hidEditMode.value="U";
	document.forms[0].hidBeanGetMethod.value="insertData";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].action=appURL+"action/adv_fundflow.jsp";	
	document.forms[0].submit();		
}
function doCancel()
{     
if(ConfirmMsg(102))
{  
           document.forms[0].hidBeanGetMethod.value="insertData";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].action=appURL+"action/adv_fundflow.jsp";
			document.forms[0].hidSourceUrl.value="adv_fundflow.jsp";
			document.forms[0].submit();
}		
}
function doDelete()
{
	var con=ConfirmMsg('152');
	if(con)
	{
		document.forms[0].hidEditMode.value="D";
		document.forms[0].hidBeanGetMethod.value="insertData";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].action=appURL+"action/adv_fundflow.jsp";
		document.forms[0].hidSourceUrl.value="adv_fundflow.jsp"	
		document.forms[0].submit();
	}
}
function IRBRating()
{
	document.forms[0].action="action/ramreports.jsp";
	document.forms[0].submit();
}
function callRating(page,flowtype)
{
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="LapsToRam";
	document.forms[0].hidBeanGetMethod.value="getRAMParameters";	
	document.forms[0].submit();	 
}
</script>
</head>
<body onload="onloading()">
<form name="frm" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td> 
			  <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
			  <jsp:param name="pageid" value="13" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
	          </jsp:include>       
	        </td>
          </tr>
          <tr>
          	<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal-&gt; Financials -&gt;Fund Flow</td>
          </tr>
        </table>  
        <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>	
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td valign="top" colspan="2">
        <table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
           <td class="sub_tab_inactive"><b><a href="javascript:gotoTabpage(appURL,'ops_generatefinanalysis.jsp')">Generate Financial Analysis</a></b>
          	</td>
          	<td class="sub_tab_inactive"><b><a href="javascript:callAssess('adv_financials.jsp','FI')">Financial Indicators</a></b>
            </td>
            <td class="sub_tab_inactive"> 
             <b><a href="javascript:callAssess('adv_financials.jsp','RA')">Ratios</a></b>
            </td>
            <td class="sub_tab_inactive"> 
             <b><a href="javascript:callAssess('adv_financials.jsp','MPBF1')">Working Capital</a></b>
            </td>
            <td class="sub_tab_active"> 
             <b>Fund Flow</b>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
<tr>
 <td width="20%"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" >
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
              <tr> 
                <td>
                  <table border="0" cellspacing="0" cellpadding="3" cellspacing="0" width="100%" class="outertable linebor">
                    <tr class="dataheader"> 
                      <%
		if( totalsize >0)
		{
		%>
                      <td width="40%" align="center"><b>Particulars</b></td>
       
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[0]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[1]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[2]%> 
                        </b></td>
                      <td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[3]%></b></td>
                    </tr>
                    <tr class="dataheader"> 
                      <td width="40%" align="center">&nbsp;</td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[0]%></td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[1]%> 
                        </td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[2]%> 
                        </td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[3]%> 
                        </td>
                    </tr>
		<%
		}
		else
		{
		%>
       <%
		}
		%>
                    <%
		if(hshValues.size()>0 && hshValues != null && totalsize >0)
		{
		 for(int i=0;i<totalsize;i++)
			{
			  if( hshValues.get("RowType"+Integer.toString(i+1)).equals("HE"))
				{
		%>
                    <tr class="dataheader"> 
                      <td width="40%"><b><%=hshValues.get("Label"+Integer.toString(i+1))%></b> 
                        </td>
                      <td valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td valign="bottom" align="center" width="15%">&nbsp;</td>
                      <td valign="bottom" align="center" width="15%">&nbsp;</td>
                    </tr>
                    <%
				}
		 else if(hshValues.get("RowType"+Integer.toString(i+1)).equals("LTS"))
				{
				}
		 else
				{
				vecData =(ArrayList)hshValues.get("vecData"+Integer.toString(i+1));
		%>
                    <tr class="datagrid"> 
                      <td width="40%" ><%=hshValues.get("Label"+Integer.toString(i+1))%> 
                        </td>
                      <td align="right" width="15%"><%=vecData.get(0)%></td>
                      <td align="right" width="15%"><%=vecData.get(1)%></td>
                      <td align="right" width="15%"><%=vecData.get(2)%></td>
                      <td align="right" width="15%"><%=vecData.get(3)%></td>
                    </tr>
                    <%
				}
			}
		}
		else
		{
		%>
                    <tr class="datagrid"> 
                      <td align="center"  bgcolor="" colspan="5">NO 
                        DATA FOUND&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
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
      <br>
      
    
 </td>
 </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
        
                      <td><b>comments</b></td>
          </tr>
          <tr> 
            <td> <textarea name="branch_comments"  cols="120" rows="15" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("advnotes"))%></textarea></td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="yearfrom" value="<%=hshValues.get("yearfrom")%>">
<input type="hidden" name="flowtype" value="TERCA">
  <INPUT TYPE="hidden" name="hidEditMode"  value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
<input type="hidden" name="totvalue" value="">
<input type="hidden" name="uptovalue" value="">
<input type="hidden" name="fromvalue" value="">
<input TYPE="hidden" value = "10" name="hidTotal">
<input TYPE="hidden" value = "" name="identity">
<input type="hidden" name="access" value ="B">
  <input type="hidden" name="sel_divID">
<input type="hidden" name="hidcmano1" value="<%=strcmaindex%>">
  <input type="hidden" name="pageval" value="<%=Helper.correctNull((String)request.getParameter("pageval"))%>">
</form>

</body>
</html>
