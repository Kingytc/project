
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<% request.setAttribute("_cache_refresh", "true"); %>
<lapschoice:handleerror />
<%
String val=Helper.correctNull(request.getParameter("val"));
String strWrkflowtype=Helper.correctNull(request.getParameter("work"));


ArrayList arrRatingDesc = new ArrayList();
ArrayList arrRatingSno = new ArrayList();
ArrayList arrratingvalues = new ArrayList();
int arrRatingDescSize=0;

if(hshValues!=null)
{
	arrRatingDesc = (ArrayList)hshValues.get("arrRatingDesc");
	arrRatingSno = (ArrayList)hshValues.get("arrRatingSno");
	if(arrRatingDesc!=null)
	{
		arrRatingDescSize= arrRatingDesc.size();
	}
	arrratingvalues=(ArrayList)hshValues.get("arrratingvalues");
}

String strslno=Helper.correctNull((String)request.getParameter("slno"));
if(strslno.equals(""))
{
	strslno=Helper.correctNull((String)hshValues.get("slno"));
}
String strintId=Helper.correctNull((String)request.getParameter("interest_id"));
if(strintId.equals(""))
{
	strintId=Helper.correctNull((String)hshValues.get("interest_id"));
}
if(strintId.equals(""))
{
	strintId=Helper.correctNull((String)request.getParameter("varRuleId"));
}
int ratingvaluessize=0;
if(arrratingvalues!=null && arrratingvalues.size()>0)
{
	ratingvaluessize=arrratingvalues.size();
}
String refrate=Helper.correctNull((String)request.getParameter("ref_rate"));
if(refrate.equals(""))
{
	refrate=Helper.correctNull((String)hshValues.get("ref_rate"));
}
String strsector=Helper.correctNull((String)hshValues.get("sector"));
String strAction=Helper.correctNull((String)hshValues.get("hidAction"));
%>
<HTML>
<HEAD>
<TITLE> Rating Based ROI </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varFromDate="<%=Helper.correctNull((String)request.getParameter("from_date"))%>";
var varToDate="<%=Helper.correctNull((String)request.getParameter("to_date"))%>";
var varRefRate="<%=refrate%>";
var varInterestId="<%=Helper.correctNull((String)request.getParameter("interest_id"))%>";
var varslno="<%=strslno%>";
var varCheckApp="<%=Helper.correctNull((String)request.getParameter("chkapp"))%>";

var varArrRatingDescSize = "<%=arrRatingDescSize%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varsector="<%=strsector%>" ;
var varratingValuesize="<%=ratingvaluessize%>";
var action="<%=strAction%>";
var varWrkflowtype="<%=strWrkflowtype%>";
function totalInt(val)
{
	if(parseInt(varArrRatingDescSize)>1)
	{
		//var baserate = parseFloat(document.forms[0].baserate[val].value);
		var baserate = parseFloat(varRefRate);
		var adjrate  = parseFloat(document.forms[0].adjust1[val].value);
	
		if(baserate == null || isNaN(baserate))
		{
			baserate = 0.00;
		}
		
		if(adjrate == null || isNaN(adjrate))
		{
			adjrate = 0.00;
		}
	
		document.forms[0].total1[val].value = roundVal(baserate + adjrate);
	}
	else if(parseInt(varArrRatingDescSize)==1)
	{
		
		//var baserate = parseFloat(document.forms[0].baserate[val].value);
		var baserate = parseFloat(varRefRate);
		var adjrate  = parseFloat(document.forms[0].adjust1[0].value);

		if(baserate == null || isNaN(baserate))
		{
			baserate = 0.00;
		}
		
		if(adjrate == null || isNaN(adjrate))
		{
			adjrate = 0.00;
		}
		document.forms[0].total1[0].value = roundVal(baserate + adjrate);
	}
	
}

function show_submit()
{
	document.forms[0].hidAction.value="insert";
	var count=0;
	if(varWrkflowtype=="fixed")
	{
		for(var i=0; i<document.forms[0].baserate1.length;i++)
		{
			if(document.forms[0].adjust1[i].value=="")
			{
				count = eval(count)+1;
			}
		}
	
		if(eval(count)==eval(document.forms[0].baserate1.length))
		{
			alert("Enter Data");
			return;
		}
	}
	else
	{
		for(var i=0; i<document.forms[0].baserate1.length;i++)
		{
			if(document.forms[0].txtcreditrskpremium[i].value=="" || document.forms[0].txtbustratpremium[i].value=="")
			{
				count = eval(count)+1;
			}
		}
	
		if(eval(count)==eval(document.forms[0].baserate1.length))
		{
			alert("Enter Data");
			return;
		}
	}
	

	document.forms[0].hidBeanId.value="setproducts";
	if(document.forms[0].hidModule.value=="RET")
	{
		document.forms[0].hidBeanMethod.value="UpdatePerratingBasedROI";
		document.forms[0].hidBeanGetMethod.value="getPerratingBasedROI";
	}
	else
	{
		document.forms[0].hidBeanMethod.value="setratingBasedROI";
		document.forms[0].hidBeanGetMethod.value="getratingBasedROI";
	}
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setratingbasedroicorporate.jsp";
	document.forms[0].submit();
}
function setValues()
{
	if(action=="insert")
	{
		alert('Values got saved');
	}
	if(varCheckApp=='Yes')
	{
		document.forms[0].cmdok.disabled=true;
	}
		if(varsector!="")
		{
			document.forms[0].sel_sector.value=varsector;
		}
		else
		{
			document.forms[0].sel_sector.value="0";
		}

		if(document.forms[0].hidModule.value!="RET")
		{
			if(varslno=='0')
			{
				if(parseInt(varratingValuesize)==0)
				{
					for(var i=0;i<varArrRatingDescSize;i++)
					{
						document.forms[0].interestid[i].value=window.opener.document.forms[0].hidroi_interestid1[i].value;
						document.forms[0].interestsno[i].value=window.opener.document.forms[0].hidroi_interestsno1[i].value;
						document.forms[0].baserate1[i].value=  window.opener.document.forms[0].hidroi_baserate1[i].value;
						document.forms[0].interest_id.value=window.opener.document.forms[0].hidroi_interestid1[i].value;
						document.forms[0].ref_rate.value=  window.opener.document.forms[0].hidroi_baserate1[i].value;
					}
				}
			
			}
			else if(varslno=='1')
			{
				if(parseInt(varratingValuesize)==0){
				for(var i=0;i<varArrRatingDescSize;i++)
				{
					document.forms[0].interestid[i].value=window.opener.document.forms[0].hidroi_interestid2[i].value;
					document.forms[0].interestsno[i].value=window.opener.document.forms[0].hidroi_interestsno2[i].value;
					document.forms[0].baserate1[i].value=  window.opener.document.forms[0].hidroi_baserate2[i].value;
					document.forms[0].interest_id.value=window.opener.document.forms[0].hidroi_interestid2[i].value;
					document.forms[0].ref_rate.value=  window.opener.document.forms[0].hidroi_baserate2[i].value;
				}
				}
			}
			else if(varslno=='2')
			{
				if(parseInt(varratingValuesize)==0){
				for(var i=0;i<varArrRatingDescSize;i++)
				{
					document.forms[0].interestid[i].value=window.opener.document.forms[0].hidroi_interestid3[i].value;
					document.forms[0].interestsno[i].value=window.opener.document.forms[0].hidroi_interestsno3[i].value;
					document.forms[0].baserate1[i].value=  window.opener.document.forms[0].hidroi_baserate3[i].value;
					document.forms[0].interest_id.value=window.opener.document.forms[0].hidroi_interestid3[i].value;
					document.forms[0].ref_rate.value=  window.opener.document.forms[0].hidroi_baserate3[i].value;
				}
				}
			}
			else if(varslno=='3')
			{
				if(parseInt(varratingValuesize)==0){
				for(var i=0;i<varArrRatingDescSize;i++)
				{
					document.forms[0].interestid[i].value=window.opener.document.forms[0].hidroi_interestid4[i].value;
					document.forms[0].interestsno[i].value=window.opener.document.forms[0].hidroi_interestsno4[i].value;
					document.forms[0].baserate1[i].value=  window.opener.document.forms[0].hidroi_baserate4[i].value;
					document.forms[0].interest_id.value=window.opener.document.forms[0].hidroi_interestid4[i].value;
					document.forms[0].ref_rate.value=  window.opener.document.forms[0].hidroi_baserate3[i].value;
				}
				}
			}
			else if(varslno=='4')
			{
				if(parseInt(varratingValuesize)==0){
				for(var i=0;i<varArrRatingDescSize;i++)
				{
					document.forms[0].interestid[i].value=window.opener.document.forms[0].hidroi_interestid5[i].value;
					document.forms[0].interestsno[i].value=window.opener.document.forms[0].hidroi_interestsno5[i].value;
					document.forms[0].baserate1[i].value=  window.opener.document.forms[0].hidroi_baserate5[i].value;
					document.forms[0].interest_id.value=window.opener.document.forms[0].hidroi_interestid5[i].value;
					document.forms[0].ref_rate.value=  window.opener.document.forms[0].hidroi_baserate4[i].value;
				}
				}
			}
		}
}

function callTableCode()
{	
	var varArrRatingDescSize = "<%=arrRatingDescSize%>";
	var prop="scrollbars=no,width=300,height=300,top=100,left=250";
	var url=appUrl+"action/setcbstablecodelist.jsp?Array_size="+varArrRatingDescSize+"&pagefrom=corp";
	window.open(url,"hai",prop);
}
function callTableCode(intt)
{	
	var intnumber=intt;
	var varArrRatingDescSize = "<%=arrRatingDescSize%>";
	var prop="scrollbars=no,width=300,height=300,top=100,left=250";
	var url=appUrl+"action/setcbstablecodelist.jsp?Array_size="+varArrRatingDescSize+"&intNum="+intnumber+"&pagefrom=corp";
	window.open(url,"hai",prop);
}

function callratingbasedroi()
{
	if(document.forms[0].sel_sector.value!="0")
	{
		document.forms[0].hidBeanId.value="setproducts";
		if(document.forms[0].hidModule.value=="RET")
		{
			document.forms[0].hidBeanGetMethod.value="getPerratingBasedROI";
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getratingBasedROI";
		}
		document.forms[0].action=appURL+"action/setratingbasedroicorporate.jsp";
		document.forms[0].submit();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</HEAD>

<body onload="setValues()" >
<form name="selection" method="post" action="">
<br>
   <table width="100%">
  <tr>
      <td><font color="red" style="font-size: 15px;">Note : Please fill values for all the three sector types.</font></td>
  </tr>
  </table>     
  <table border="0" cellspacing="0" cellpadding="5"  width="100%" align="center" class="outertable">
    <tr> 
      <td valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
        <tr>
          <td>
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr class="datagrid" >
          <td width="30%" align="center" nowrap><b>Select Sector</b></td>
          <td width="30%" align="left"><select name="sel_sector"  onchange="callratingbasedroi()" style="font-size: 12px">
          <option value="0">--Select--</option>
          <option value="01">priority</option>
          <option value="02">Non-priority</option>
          <option value="11">Commercial</option>
          </select></td>
            <%if(strWrkflowtype.equalsIgnoreCase("fixed")){ %>
          	<td nowrap width="40%" ><b>Reference Rate: &nbsp;<%=refrate%></b></td>
          	<%} %>
          </tr></table></td></tr>
          <tr>
          <td>
          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
             <tr class="dataheader" align="center">
             	  <td> Rating Description</td>
             	  <%if(strWrkflowtype.equalsIgnoreCase("fixed")){ %>
             	  <td>Adjustments (+/-)</td>
             	  <td>Interest Rate (%)</td>
             	  <%}else{ %>
             	  <td>Credit Risk Premium</td>
             	  <td>Business Strategic Premium</td>
             	  <%} %>
             </tr>
              <%
					
						if(ratingvaluessize==0) {
							for (int i = 0; i < arrRatingDescSize; i++) 
							{
					%>
					<tr class="datagrid" align="center">	
                 	 <td align="left"> 
                  	 	 <input type="text" name="txt_ratingDesc" size="45"
                  	 	 value="<%=Helper.correctNull((String)arrRatingDesc.get(i))%>"
						 style="border:none;background-color: #ece1ea" readOnly>
					</td>
					<input type="hidden" name="from1" value="">
					<input type="hidden" name="to1" value="">
					<input type="hidden" name="baserate1" onKeyPress="allowInteger()"  value="">
					<%if(!strWrkflowtype.equalsIgnoreCase("fixed")){ %>
					<input type="hidden" name="adjust1"  value="">
					<input type="hidden" name="total1"  value="">
					<td  align="center"><input type="text"  name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<td  align="center"><input type="text"  name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<%}else{ %>
					<td align="center">
					<INPUT TYPE="text" NAME="adjust1" MAXLENGTH="8"
										ONKEYPRESS="allowAdjustment(this)" SIZE="12" tabindex="1"
										ONBLUR="totalInt('<%=i%>')" VALUE="" style="text-align:left"></td>
					<td  align="center"><input type="text" name="total1"
										maxlength="8" onKeyPress="allowNumber(this);" size="12"
										onBlur="checkPercentage(this),roundtxt(this)" readOnly style="text-align:right"></td>
					<%} %>
					<input type="hidden" name="interestid"  value="">
					<input type="hidden" name="interestsno"  value="">
					</tr>
             	   <%} } else {
             		   if(arrRatingDescSize==ratingvaluessize) {
             		   for(int k=0;k<ratingvaluessize;k++) {
             		   ArrayList arrCol=(ArrayList)arrratingvalues.get(k);
             		   
             		   %>
             	   
             	   <tr class="datagrid" align="center">	
                 	 <td align="left"> 
                  	 	 <input type="text" name="txt_ratingDesc" size="45"
                  	 	 value="<%=Helper.correctNull((String)arrCol.get(2))%>"
						 style="border:none;background-color: #ece1ea" readOnly>
					</td>
					<input type="hidden" name="from1" value="">
					<input type="hidden" name="to1" value="">
					<input type="hidden" name="baserate1" onKeyPress="allowInteger()"  value="<%=Helper.correctNull((String)arrCol.get(3))%>">
					<%if(!strWrkflowtype.equalsIgnoreCase("fixed")){ %>
					<input type="hidden" name="adjust1"  value="">
					<input type="hidden" name="total1"  value="">
					<td  align="center"><input type="text"  name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);"
					 style="text-align: right;" onkeypress="allowNumber(this)" size="12" VALUE="<%=Helper.correctNull((String)arrCol.get(6))%>"/></td>
					<td  align="center"><input type="text"  name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" 
					style="text-align: right;" onkeypress="allowNumber(this)" size="12"/ VALUE="<%=Helper.correctNull((String)arrCol.get(7))%>"></td>
					<%}else{ %>
					<td align="center">
					<INPUT TYPE="text" NAME="adjust1" MAXLENGTH="8"
										ONKEYPRESS="allowAdjustment(this)" SIZE="12" tabindex="1"
										ONBLUR="totalInt('<%=k%>')" VALUE="<%=Helper.correctNull((String)arrCol.get(4))%>" style="text-align:left"></td>
					<td  align="center"><input type="text" name="total1"
										maxlength="8" onKeyPress="allowNumber(this);" size="12"
										onBlur="checkPercentage(this),roundtxt(this)" value="<%=Helper.correctNull((String)arrCol.get(5))%>" readOnly style="text-align:right"></td>
					<%} %>
					<input type="hidden" name="interestid" maxlength="8" readonly value="">
					<input type="hidden" name="interestsno" maxlength="8" readonly value="">
					</tr>
             	   <% }} else { for (int i = 0; i < arrRatingDescSize; i++) 
							{%>
             	   <tr class="datagrid" align="center">	
                 	 <td align="left"> 
                  	 	 <input type="text" name="txt_ratingDesc" size="45"
                  	 	 value="<%=Helper.correctNull((String)arrRatingDesc.get(i))%>"
						 style="border:none;background-color: #ece1ea" readOnly>
					</td>
					<input type="hidden" name="from1" value="">
					<input type="hidden" name="to1" value="">
					<input type="hidden" name="baserate1" onKeyPress="allowInteger()"  value="">
					<%if(!strWrkflowtype.equalsIgnoreCase("fixed")){ %>
					<input type="hidden" name="adjust1"  value="">
					<input type="hidden" name="total1"  value="">
					<td  align="center"><input type="text"  name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" 
					style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<td  align="center"><input type="text"  name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" 
					style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<%}else{ %>
					<td align="center">
					<INPUT TYPE="text" NAME="adjust1" MAXLENGTH="8"
										ONKEYPRESS="allowAdjustment(this)" SIZE="12" tabindex="1"
										ONBLUR="totalInt('<%=i%>')" VALUE="" style="text-align:left"></td>
					<td  align="center"><input type="text" name="total1"
										maxlength="8" onKeyPress="allowNumber(this);" size="12"
										onBlur="checkPercentage(this),roundtxt(this)" readOnly style="text-align:right"></td>
					<%} %>
					<input type="hidden" name="interestid"  value="">
					<input type="hidden" name="interestsno"  value="">
					</tr>
             	   <% }} } %>
             	   
             	   
             	   <%
             	   	if(arrRatingDescSize==1)
             	   	{ %>
             	   	<tr class="datagrid" align="center">	
                	 <td  align="left"> 
                 	 	 <input type="hidden" name="txt_ratingDesc" size="45"
                 	 	 value=""
						 style="border:none;background-color: #ece1ea" readOnly>
					</td>
					<input type="hidden" name="from1" value="">
					<input type="hidden" name="to1" value="">
								    <input type="hidden" name="baserate1" 
												onKeyPress="allowInteger()"  readOnly
												value="" style="text-align:right">
					<%if(!strWrkflowtype.equalsIgnoreCase("fixed")){ %>
					<input type="hidden" name="adjust1"  value="">
					<input type="hidden" name="total1"  value="">
					<td  align="center"><input type="text"  name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<td  align="center"><input type="text"  name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/></td>
					<%}else{ %>						
									<td  align="center"><INPUT TYPE="hidden" NAME="adjust1"
										MAXLENGTH="8" ONBLUR="totalInt('')"
										ONKEYPRESS="allowAdjustment(this)" SIZE="12" tabindex="1"
										VALUE="" style="text-align:left"></td>
									<td  align="center"><input type="hidden" name="total1"
										maxlength="8" onKeyPress="allowNumber(this);" size="12"
										onBlur="checkPercentage(this),roundtxt(this)" readOnly style="text-align:right"
										></td>
					<%} %>
									<input type="hidden" name="interestid" maxlength="8" readonly
										value="">
									<input type="hidden" name="interestsno" maxlength="8" readonly value="">
					</tr>
             	 <%}
             	   %>
          </table>
          </td>
        </tr>
      </table>
      </td>
    </tr>
  </table>
							 
  <table width="9%" border="0" cellspacing="0" cellpadding="0"   align="center" bordercolordark="#B6C1D2" bordercolorlight="#FFFFFF">
    <tr> 
	<td> 
        <table width="88%" border="0" cellspacing="0" cellpadding="1">
          <tr valign="top">
            <td>
				<input type="button" name="cmdok" value="Save" class="buttonStyle"  onClick="show_submit()">
            </td>
			<td> 
            
                <input type="button" name="cmdclose" value="Cancel"  class="buttonClose"   onClick="javascript:window.close()">
             
            </td>
		  </tr>
        </table>
      </td>
    </tr>
  </table>
	 <input type="hidden" name="hiddesc" value="">
  <input type="hidden" name="hidtype" value="">
  <input type="hidden" name="hidBeanId" value="floatbaserate" >
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl">		
   <input type="hidden" name="hidAction">
  <input type="hidden" name="slno" value="<%=strslno%>">
  <input type="hidden" name="interest_id" value="<%=strintId%>">
  <input type="hidden" name="ref_rate" value="<%=refrate%>">
  <input type="hidden" name="work" value="<%=strWrkflowtype%>">
  <input type="hidden" name="hidModule" value="<%=Helper.correctNull((String)request.getParameter("hidModule"))%>">
</form>
</BODY>
</HTML>
