<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrData = (ArrayList) hshValues.get("arrData");

	arrRow=(ArrayList)hshValues.get("arrRow11");
	ArrayList arrIrrValues=(ArrayList)hshValues.get("arrIrrValues");
	int intnoofyrs=Helper.parseInt(Helper.correctInt((String)hshValues.get("noofyrs")));
	int intpercent=intnoofyrs*2;
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/per/agrassesment.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
		document.forms[0].submit();

	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function onloading()
{
	disableFields(true);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="frmpri" method=post class="normal">
  <table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
    <tr  class="dataHeader"> 
      <td rowspan="2"  width="10%">Project Amount Rs. 
        <input type="text" name="txt_loanamount"  size="15"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("loan_begin"))%>"
									style="text-align:right;">
        </td>
      <td  colspan="<%=(intnoofyrs+1)%>" align="center" >Years</td>
    </tr>
    <tr  class="dataHeader"> 
    <%for(int i=0;i<intnoofyrs;i++){ %>
      <td align="CENTER" ><%=(i+1)%>
      <%} %>
      <td align="CENTER" width="8%" >Net 
        present value (NPV)</td>
    </tr>
    <tr  class="dataHeader"> 
      <td height="36" width="10%"><b>CashFlow 
        <input type="hidden" name="txt_iyear">
        </b></td>
        
        <%
        if(arrData!=null && arrData.size()>0){ 
        	for(int i=0;i<intnoofyrs;i++){
        %>
      <td  height="36"> 
        <input type="text" name="txt_iyear"  size="15"
		maxlength="15" value="<%=Helper.correctNull((String)arrData.get(i)) %>"  style="text-align:right;" readonly="readonly">
      </td>
      <%} %>
      <td height="36" width="8%">&nbsp; </td>
      <%} %>
    </tr>
     <%
		arrCol=new ArrayList();
		if(arrRow!=null && arrRow.size()>0)
		{
    		for(int i=0;i<arrRow.size();i++)
			{
    			arrCol=(ArrayList)arrRow.get(i);
									%>
    <tr   class="datagrid"> 
      <td nowrap width="10%"><b> 
        <input type="text" name="txt_iiyear"  size="5"
					maxlength="15" value="<%=Helper.correctNull((String)arrCol.get(intpercent))%>" 
									 style="text-align:right;" readonly="readonly">
        % DF</b></td>
        <%for(int j=0;j<intnoofyrs;j++){ 
         int k=j*2;%>
      <td> 
        <input type="text"  size="15" maxlength="15"   readonly="readonly"
        style="text-align:right;border:none;background-color: #ECF1F9" 
        name="txt_iiyear" value="<%=Helper.correctNull((String)arrCol.get(k))%>">
      </td>
      <%} %>
       <td width="8%">&nbsp; </td>
    </tr>
    <tr class="dataHeader"> 
      <td nowrap width="10%"><b>PV @ 
        <input type="text" name="txt_iiiyear"  size="5" readonly="readonly"
				style="text-align:right;border:none;"
				maxlength="15" value="<%=Helper.correctNull((String)arrCol.get(intpercent))%>"  style="text-align:right;">
        %DF</b></td>
         <%for(int j=0;j<=intnoofyrs;j++){ 
         int k=(j*2)+1;
         %>
      <td > 
        <input type="text" name="txt_iiiyear"  size="15" maxlength="15"   readonly="readonly"
        	style="text-align:right;" value="<%=Helper.correctNull((String)arrCol.get(k))%>">
      </td>
       <%} %>
     </tr>
    <%
									}
									}
									%>
  </table>
  <br>
  
 <% if(arrIrrValues!=null && arrIrrValues.size()>0){ %>
  
 <font color="#0000FF"> <b>IRR=</b> </font>
  <input type="text" name="posvalper" size="3"  readonly="readonly"
 	 value="<%=Helper.correctNull((String)arrIrrValues.get(3))%>">
  + 
  <input type="text" name="interval" size="3"  readonly="readonly"
  	value="<%=Helper.correctNull((String)arrIrrValues.get(0))%>">
  *[
  <input type="text" name="posval" size="15"  readonly="readonly"
  	value="<%=Helper.correctNull((String)arrIrrValues.get(2))%>">
  /(
  <input type="text" name="posval1" size="15"  readonly="readonly"
  	value="<%=Helper.correctNull((String)arrIrrValues.get(2))%>">
  +
  <input type="text" name="negval" size="15"  readonly="readonly"
  	value="<%=Helper.correctNull((String)arrIrrValues.get(1))%>">
  ) ]=
  <input type="text" name="irrval" size="15"  readonly="readonly"
  	value="<%=Helper.correctNull((String)arrIrrValues.get(4))%>">
<%} %>
  <br> <br>
				<table class="outertable border1" align="center" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
						<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="2" >
							<tr valign="top">
								<td width="0"><input type="button" name="cmdclose" value="Close"
									class="buttonClose" onClick="doClose()"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>

<lapschoice:agrihiddentag/>
<input type="hidden" name="cmdsave" value="" disabled>
<input type="hidden" name="negvalper" size="3" value="">
</form>
</body>
</html>