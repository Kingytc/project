<%@include file="../share/directives.jsp"%>
<% ArrayList vecData =null;
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
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varyearfrom = "<%=totnoofyears%>";
function onloading()
{
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
function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
} 
</script>
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frm" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top">
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="8" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />			
              </jsp:include>
            </td>
          </tr>
        </table>
        <span class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Fund Flow<br></span>
        <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>   
          <lapschoice:FinAnalysisTag tabid="4" />
      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
              <tr> 
                <td>
                  <table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable linebor">
                    <tr align="center" class="dataheader"> 
                      <%if( totalsize >0){%>
                      <td width="40%"><b>Particulars</b></td>
       
                      <td width="15%" valign="bottom"><b>&nbsp;<%=strCurrYear[0]%></b></td>
                      <td width="15%" valign="bottom"><b>&nbsp;<%=strCurrYear[1]%></b></td>
                      <td width="15%" valign="bottom"><b>&nbsp;<%=strCurrYear[2]%></b></td>
                      <td width="15%" valign="bottom"><b>&nbsp;<%=strCurrYear[3]%></b></td>
                    </tr>
                    <tr class="dataheader"> 
                      <td width="40%" align="center">&nbsp;</td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[0]%></td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[1]%></td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[2]%></td>
                      <td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[3]%></td>
                    </tr>
		<%}else{%>
       <%}%>
                    <%if(hshValues.size()>0 && hshValues != null && totalsize >0){
		 				for(int i=0;i<totalsize;i++)
						{
			  				if( hshValues.get("RowType"+Integer.toString(i+1)).equals("HE"))
							{%>
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
                      <td width="40%"><%=hshValues.get("Label"+Integer.toString(i+1))%> 
                        </td>
                      <td  width="15%" align="right"><%=vecData.get(0)%></td>
                      <td  width="15%" align="right"><%=vecData.get(1)%></td>
                      <td width="15%" align="right"><%=vecData.get(2)%></td>
                      <td width="15%" align="right"><%=vecData.get(3)%></td>
                    </tr>
                    <%}}}else{%>
                    <tr class="datagrid"> 
                      <td align="center" colspan="5">NO DATA FOUND&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <%}%>
                  </table>
                </td>
              </tr>
            </table>            
          </td>
        </tr>
      </table>
      <br>
      <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
        <tr> 
          <td> 
            <table border="0" cellspacing="0" cellpadding="3" class="outertable">
              <tr>
			 <td><%if( totalsize >0)
				{		
				if (Integer.parseInt((String)hshValues.get("yearfrom")) > 1  )
				{%>
				&lt;&lt; <a href="javascript:onPrev()"><b>Previous</b></a> 
			<%}%>
            </td>
			<td> &nbsp; 
             <%if ((Integer.parseInt((String)hshValues.get("yearfrom"))+3) < totnoofyears  ){%>
				<a href="javascript:onNext()" class="blackfont"><b>Next</b></a> 
				&gt;&gt; 
             <%}}%>
            </td>
                <td align="right"> 
                 <lapschoice:combuttonnew btnnames='Print' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>  
			  </td> 
              </tr>
            </table>
          </td>
        </tr>
      </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="yearfrom" value="<%=hshValues.get("yearfrom")%>">
<input type="hidden" name="flowtype" value="FU">
<input type="hidden" name="totvalue" value="">
<input type="hidden" name="uptovalue" value="">
<input type="hidden" name="fromvalue" value="">
<input TYPE="hidden" value = "10" name="hidTotal">
<input TYPE="hidden" value = "" name="identity">
<input type="hidden" name="access" value ="B">
<input type="hidden" name="cmdsave" disabled>
<input type="hidden" name="hidcmano1" value="<%=strcmaindex%>">
</form>

</body>
</html>
