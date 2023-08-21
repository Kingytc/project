<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
			
			arryRow = (ArrayList) hshValues.get("arryRow");
		
			if (arryRow == null) 
			{
				arryRow = new ArrayList();
			}
	String l1="";
	String l2="";
	String l3="";	
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
		%>

<html>
<head>
<title>Appraisal - EMI Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";
		document.forms[0].submit();
	}
}

function onloading()
{
	disablefields(true);
}

function disablefields(one)
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


function callTotal()
{
var marketval=document.forms[0].txt_marketval.value;
var loanamount=document.forms[0].txt_loanamount.value;
if(marketval=="")
{
document.forms[0].txt_marketval.value="0";
}
if(loanamount=="")
{
document.forms[0].txt_loanamount.value="0";
}

document.forms[0].txt_margin.value=eval(marketval)-eval(loanamount);
}
function callMargin()
{
var marketval=document.forms[0].txt_marketval.value;
var marginval=document.forms[0].txt_margin.value;
var marginper=(eval(marginval)/eval(marketval))*100;
document.forms[0].txt_marginper.value=NanNumber(eval(marginper));
var num=marginper;
var str=num.toFixed(2);
document.forms[0].txt_marginper.value=NanNumber(eval(str));
var margin;
if(eval(marketval)>0)
{
margin=0.2*eval(marketval);
if(eval(marginval)<eval(margin))
{

alert("Margin value is less than 20% of Market value");
document.forms[0].txt_margin.value="0";
return;

}
}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading();callTotal();callMargin()">
<form class="normal" name="appform" method="post" action="">
						<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
								
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td width="3%">&nbsp;</td>
                              <td width="57%">Loan 
                                Applicant</td>
                              <td width="3%">&nbsp;</td>
                              <td width="37%"> 
                                <%String loanapplicant=Helper.correctNull((String) hshValues.get("sel_applicant"));
				
                if(loanapplicant.equalsIgnoreCase("1"))
                {
                loanapplicant="Farmer with crop loan from our Bank";
                }
                if(loanapplicant.equalsIgnoreCase("2"))
                {
                loanapplicant="Farmer with crop loan from other Banks";
                }
                if(loanapplicant.equalsIgnoreCase("3"))
                {
                loanapplicant="Trader with valid license for above 1 year";
                }
               
                 %>
                                <input type="text" name="txt_loanapplicant"
											maxlenght="10" size="40" style="text-align:left" value=" <%=loanapplicant%>">
                              </td>
                            </tr>
                            <tr> 
                              <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(4));
					
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				
			}

			%>
                              <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					l2= Helper.correctNull((String) arryCol.get(4));
					
				}
				

			} else if (arryRow.size() == 0) {
				l2="";
				
			}

			%>
                              <% 	if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l3= Helper.correctNull((String) arryCol.get(4));
					}
			      } else if (arryRow.size() == 0) {
				           l3="";
				
			          }

			            %>
                              <td>&nbsp;</td>
                              <td>Description 
                                of Goods to be pledged</td>
                              <td>&nbsp;</td>
                              <td> 1.<%=l1%><br>
                                <%=l2%><br>
                                <%=l3%><br>
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Type of 
                                Warehouse</td>
                              <td>&nbsp;</td>
                              <td> 
                                <%String warehouse=Helper.correctNull((String) hshValues.get("sel_warehouse"));
				
                if(warehouse.equalsIgnoreCase("1"))
                {
               warehouse="Central WareHousing Corporation";
                }
                if(warehouse.equalsIgnoreCase("2"))
                {
                warehouse="State WareHousing Corporation";
                }
                if(warehouse.equalsIgnoreCase("3"))
                {
               warehouse="Approved National Level multicommodity Exchange";
                }
               if(warehouse.equalsIgnoreCase("4"))
                {
               warehouse="Others";
                }
                 %>
                                <input type="text" name="txt_warehouse"
											maxlenght="10" size="40" style="text-align:Left" value="<%=warehouse%>">
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>License 
                                </td>
                              <td>&nbsp;</td>
                              <td> 
                                <%String license=Helper.correctNull((String) hshValues.get("sel_license"));
				
                if(license.equalsIgnoreCase("1"))
                {
               license="license to deal in proposed community";
                }
                if(license.equalsIgnoreCase("2"))
                {
                license="No License";
                }
                
                 %>
                                <input type="text" name="txt_license"
											maxlenght="10" size="40" style="text-align:left" value="<%=license%>">
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Distance 
                                from Branch</td>
                              <td>&nbsp;</td>
                              <td> 
                                <input type="text" name="txt_distance" maxlenght="10" value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"
											size="15" style="text-align:right">
                                (Km)</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Accessibility 
                                to the Branch</td>
                              <td>&nbsp;</td>
                              <td> 
                                <input type="text" name="txt_accesibility" maxlenght="10"
											size="15" style="text-align:left" value="<%=Helper.correctNull((String)hshValues.get("txt_accesibilty"))%>">
                              </td>
                            </tr>
                            <tr> 
                              <td height="32">&nbsp;</td>
                              <td>Total Market 
                                Value</td>
                              <td><strong>Rs</strong>.</td>
                              <td> 
                                <input type="text" name="txt_marketval" maxlenght="10"
											size="15" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("totmarketval"))%>">
                              </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Minimum 
                                Margin at 20% of the Market Value</td>
                              <td><strong>Rs</strong>.</td>
                              <td> 
                                <input type="text" name="txt_margin" maxlenght="10" value=""
											size="15" style="text-align:right">
                                <input type="text" name="txt_marginper" maxlenght="10" value=""
											size="15" style="text-align:right">
                                <strong> (Margin %)</strong></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Loan Amount 
                                Eligible </td>
                              <td><strong>Rs</strong>.</td>
                              <td> 
                                <input type="text" name="txt_loanamount" maxlenght="10"
											size="15" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("totloanamt"))%>">
                              </td>
                            </tr>
                          </table>
								</td>
							</tr>
						</table>
						<br>
						
						<div align="center">
						<input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
						</div>
						
			
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="button" name="cmdsave" style="visibility:hidden" disabled="disabled">
</form>
</body>
</html>