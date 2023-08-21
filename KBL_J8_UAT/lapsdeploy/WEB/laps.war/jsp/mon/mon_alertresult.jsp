<%@include file="../share/directives.jsp"%>
<html>
<head>
<script>

var appUrl="<%=ApplicationParams.getAppUrl()%>";
function callLetter(accno,id,lrcode,extparam,extparam1,extparam2)
{
	var ltrcode=lrcode;
	if(ltrcode=="SECDOC")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
//		var url=appUrl+"action/ltr_renewaldocument.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getborrowerdetails&id="+id+"&cbsaccno="+accnumber;
		var url=appUrl+"action/ltr_renewaldocument.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getborrowerdetails&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="LCDEV")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_developmentletter.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getLCDetails&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="DUEADJ")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_adjustmentoverdues.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getloandefaulter&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
		
	}
	if(ltrcode=="GUAINV")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_paymentinvoked.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getGuarantee&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="BILDUE")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
//		var url=appUrl+"action/ltr_billpayment.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getBillDetails&id="+id+"&cbsaccno="+accnumber;
		var url=appUrl+"action/ltr_billpayment.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getBillDetails&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="LIMREN")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_renewalofcredit.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getLimitRenewalDetails&id="+id+"&cbsaccno="+accnumber+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="INSEXP")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_insurancesecurities.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getInsuranceRecovered&id="+id+"&cbsaccno="+accnumber+"&strslno="+extparam+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="STKNT")//stock statement
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_nonsubmissinstatment.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getNonsubmission&id="+id+"&cbsaccno="+accnumber+"&date="+extparam+"&alertsfor="+extparam1+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="BKDNT")//book statement
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_nonsubmissinstatmentbook.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getNonsubmission&id="+id+"&cbsaccno="+accnumber+"&date="+extparam+"&alertsfor="+extparam1+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="DRWPWR")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_drawingpoweravailprint.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getDrawingPower&id="+id+"&cbsaccno="+accnumber;
		window.open(url,title,prop);
	}
	if(ltrcode=="INSUR")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		//var url=appUrl+"action/ltr_insuranceprint.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getInsuranceRecovered&id="+id+"&cbsaccno="+accnumber+"&strslno="+extparam;
		var url=appUrl+"action/ltr_insuranceprint.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getInsuranceRecovered&id="+id+"&cbsaccno="+accnumber+"&strslno="+extparam+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	if(ltrcode=="BILOVR")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_billsoverdue.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getBillDetails&id="+id+"&cbsaccno="+accnumber+"&ltrcode="+ltrcode+"&billno="+extparam+"&billdate="+extparam1+"&billamt="+extparam2+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	
	if(ltrcode=="GENREV")
	{
		var accnumber=accno;
		document.forms[0].cbsid.value=id;
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var title = "PrintFairReport";
		var xpos = 100;
		var ypos = 55;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/ltr_generalronrenewal.jsp?&hidBeanId=monitoringletters&hidBeanGetMethod=getLimitRenewalDetails&id="+id+"&ltrcode="+ltrcode+"&revdate="+extparam+"&org_code="+document.forms[0].hidorgCode.value;
		window.open(url,title,prop);
	}
	
	
}
function loaddata()
{	var defaultcount="<%=Helper.correctNull((String)hshValues.get("defaultcount"))%>";	
	//var noncount="<%//=Helper.correctNull((String)hshValues.get("noninspectioncount"))%>";
	//var nonrenewalcount	="<%//=Helper.correctNull((String)hshValues.get("nonrenewalcount"))%>";
	//var LoanDefaultcount="<%//=Helper.correctNull((String)hshValues.get("LoanDefaultcnttotal"))%>";
	//var otherdefcnttotal="<%//=Helper.correctNull((String)hshValues.get("otherdefcnttotal"))%>";
	/*if(defcount!="")
	{
	parent.frames.document.forms[0].txt_defindoccount.value="<%//=Helper.correctNull((String)hshValues.get("cnttotal"))%>";	
	}
	if(noncount!="")
	{
	parent.frames.document.forms[0].txt_noninspcount.value="<%//=Helper.correctNull((String)hshValues.get("noninspectioncount"))%>";	
	}
	if(nonrenewalcount!="")
	{
	parent.frames.document.forms[0].txt_renewalcount.value=nonrenewalcount;
	}*/
	if(defaultcount!="")
	{
	parent.frames.document.forms[0].txt_loandefcount.value=defaultcount;
	}
	/*if(otherdefcnttotal!="")
	{
	parent.frames.document.forms[0].txt_otherdefcount.value=otherdefcnttotal;
	}*/
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="loaddata()">
<form name="srchform" method ="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
  <%
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow = new ArrayList();
	String color="";
	arrRow=(ArrayList)hshValues.get("arrAlerts");
	
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0; i<arrRow.size();i++)
		{
			
			if(Helper.correctNull((String)hshValues.get("strAsset")).equals("005") && Helper.correctNull((String)hshValues.get("strAlertfor")).equals("005"))
			{
				String acctype="";
				arrCol=(ArrayList)arrRow.get(i);
				acctype=Helper.correctNull((String)arrCol.get(3));
				if(acctype.equalsIgnoreCase("RESTR"))
				{
					color="#FFFFFF";
					acctype="RESTRUCTURED";
				}
				else if(acctype.equalsIgnoreCase("NONRS"))
				{
					color="#DEDACF";
					acctype="NORMAL";
				}
				else 
				{
					color="#DEDACF";
					acctype="-";
				}
	%>
	<tr class="dataGrid"> 
  
      <td width="37%" ><a href="javascript:callLetter('','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(6))%>')" >
      	<b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></b></a></td>
      <td width="27%" > 
        <div align="left"><b>&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</b></div>
      </td>
      <td width="15%" ><%=acctype%></td>
       </tr>
	
	
	<%
			}
			else if((Helper.correctNull((String)hshValues.get("strAsset")).equals("005")) || (!Helper.correctNull((String)hshValues.get("strAsset")).equals("005") && Helper.correctNull((String)hshValues.get("strAlertfor")).equals("003")) || (!Helper.correctNull((String)hshValues.get("strAsset")).equals("005") && Helper.correctNull((String)hshValues.get("strAlertfor")).equals("006")))
			{
				String acctype="";
			arrCol=(ArrayList)arrRow.get(i);
			////System.out.print("arrCol----->"+arrCol);
			if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("BILOVR"))
			{
				acctype=Helper.correctNull((String)arrCol.get(8));
			}
			else if((Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("DRWPWR"))||(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("STKBD")))
			{
				acctype=Helper.correctNull((String)arrCol.get(5));
			}
			else
			{
				acctype=Helper.correctNull((String)arrCol.get(5));
			}
			if(acctype.equalsIgnoreCase("RESTR"))
			{
				//color="#FFFFFF";
				acctype="RESTRUCTURED";
			}
			else if(acctype.equalsIgnoreCase("NONRS"))
			{
				//color="#DEDACF";
				acctype="NORMAL";
			}
			else 
			{
				//color="#DEDACF";
				acctype="-";
			}
	%>
    <tr class="dataGrid"> 
  
      <td width="20%" ><a href="javascript:callLetter('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(3))%>',
      '<%=((Helper.correctNull((String)arrCol.get(3)).equals("STKBD")) || Helper.correctNull((String)arrCol.get(3)).equals("BILOVR"))? Helper.correctNull((String)arrCol.get(5)):(Helper.correctNull((String)arrCol.get(3)).equals("INSUR")|| Helper.correctNull((String)arrCol.get(3)).equals("INSEXP"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=(Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")||Helper.correctNull((String)arrCol.get(3)).equals("STKBD"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")?Helper.correctNull((String)arrCol.get(7)):""%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></b></a></td>
       
      <td width="35%" > 
        <div align="left"><b>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</b></div>
      </td>
      <td width="20%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
      <td width="15%" ><%=acctype%></td>
       </tr>
      <%
			}
			else if(!Helper.correctNull((String)hshValues.get("strAsset")).equals("005") && Helper.correctNull((String)hshValues.get("strAlertfor")).equals("001"))
			{
			String acctype="";
			String strOverdue = "";
			String strSancAmt = "";
			arrCol=(ArrayList)arrRow.get(i);
			if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("BILOVR"))
			{
				acctype=Helper.correctNull((String)arrCol.get(8));
				
				strOverdue=Helper.correctDouble((String)arrCol.get(9));
				strSancAmt=Helper.correctDouble((String)arrCol.get(10));
			}
			else
			{
				acctype=Helper.correctNull((String)arrCol.get(5));
				strOverdue=Helper.correctDouble((String)arrCol.get(6));
				strSancAmt=Helper.correctDouble((String)arrCol.get(7));
			}
			if(acctype.equalsIgnoreCase("RESTR"))
			{
				//color="#FFFFFF";
				acctype="RESTRUCTURED";
			}
			else if(acctype.equalsIgnoreCase("NONRS"))
			{
				//color="#DEDACF";
				acctype="NORMAL";
			}
			else 
			{
				//color="#DEDACF";
				acctype="-";
			}
	%>
    <tr class="dataGrid"> 
      <td width="16%" ><a href="javascript:callLetter('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(3))%>',
      '<%=((Helper.correctNull((String)arrCol.get(3)).equals("STKBD")) || Helper.correctNull((String)arrCol.get(3)).equals("BILOVR"))? Helper.correctNull((String)arrCol.get(5)):(Helper.correctNull((String)arrCol.get(3)).equals("INSUR")|| Helper.correctNull((String)arrCol.get(3)).equals("INSEXP"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=(Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")||Helper.correctNull((String)arrCol.get(3)).equals("STKBD"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")?Helper.correctNull((String)arrCol.get(7)):""%>')" ><b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></b></a></td>
       
      <td width="25%" > 
        <div align="left"><b>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</b></div>
      </td>
      <td width="15%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
      <td width="11%" ><%=acctype%></td>
      <td width="11%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(strOverdue))%></td>
       <td width="11%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(strSancAmt))%></td>
       </tr>
      <%
			}
			else
			{
				String acctype="";
				
			arrCol=(ArrayList)arrRow.get(i);
		
			if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("BILOVR"))
			{
				acctype=Helper.correctNull((String)arrCol.get(8));
				
				
			}
			else if((Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("DRWPWR"))||(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("STKBD")))
			{
				acctype=Helper.correctNull((String)arrCol.get(5));
			}
			else
			{
				acctype=Helper.correctNull((String)arrCol.get(5));
			}
			if(acctype.equalsIgnoreCase("RESTR"))
			{
				//color="#FFFFFF";
				acctype="RESTRUCTURED";
			}
			else if(acctype.equalsIgnoreCase("NONRS"))
			{
				//color="#DEDACF";
				acctype="NORMAL";
			}
			else 
			{
				//color="#DEDACF";
				acctype="-";
			}
	%>
    <tr class="dataGrid"> 
  
      <td width="20%" ><a href="javascript:callLetter('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(3))%>',
      '<%=((Helper.correctNull((String)arrCol.get(3)).equals("STKBD")) || Helper.correctNull((String)arrCol.get(3)).equals("BILOVR"))? Helper.correctNull((String)arrCol.get(5)):(Helper.correctNull((String)arrCol.get(3)).equals("INSUR")|| Helper.correctNull((String)arrCol.get(3)).equals("INSEXP"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=(Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")||Helper.correctNull((String)arrCol.get(3)).equals("STKBD"))?Helper.correctNull((String)arrCol.get(6)):""%>',
      '<%=Helper.correctNull((String)arrCol.get(3)).equals("BILOVR")?Helper.correctNull((String)arrCol.get(7)):""%>')"><b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(0))%></b></a></td>
       
      <td width="32%" > 
        <div align="left"><b>&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;</b></div>
      </td>
      <td width="20%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
      <td width="15%" ><%=acctype%></td>
        <td width="15%"><%=Helper.correctNull((String)arrCol.get(6))%></td>
       </tr>
      <%
			}
      } 
      }
      else
      {%>
   
   
    <tr class="dataGrid"> 
      <td width="25%" >&nbsp;</td>
      <td width="35%" align="center" ></td>
      <td width="25%" align="left"></td>
       <td width="15%" align="left"></td>
       
    </tr>
    <tr  class="dataGrid"> 
      <td width="25%" >&nbsp;</td>
      <td width="35%" align="center" ></td>
      <td width="25%" align="left"></td>
       <td width="15%" align="left"></td>
    </tr>
    <tr class="dataGrid"> 
      <td width="41%" >No Data Found</td>
      <td width="20%" align="center" >&nbsp;</td>
      <td width="15%" align="left"></td>
       <td width="15%" align="left"></td>
    </tr>
    <%}%>
	<%//String strCount=hshValues.get("cnttotal");%>
	
	 
	
  </table>
<input type="hidden" name="cbsid" >
<input type="hidden" name="comapp_compname">
<input type="hidden" name="comapp_compid">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="cbsname" value="">
<input type="hidden" name="ltrcode" value="">
<input type="hidden" name="hidorgCode" value="<%=Helper.correctNull((String)hshValues.get("OrgCode"))%>">
</form>
</body>
</html>
