<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<%@ page import="java.util.*"%>
<laps:handleerror />
<%
String strsaral = Helper.correctNull((String) request
					.getParameter("hidsaral"));
			String appstatus = (String) request.getParameter("appstatus");
			String strSector = Helper.correctNull((String) request
					.getParameter("hidsector"));
			
			ArrayList arrRow= new ArrayList();
			ArrayList arrCol= new ArrayList();
			arrRow =(ArrayList)hshValues.get("arrRow");
			String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));
			String strappname=Helper.correctNull((String)request.getParameter("appname"));
			%>
<html>
<head>
<title>com_duediligencereportprint</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

var insbanknameboard="<%=Helper.correctNull((String)hshValues.get("mmr_insbanknameboard"))%>";
var insborrowernamebord="<%=Helper.correctNull((String)hshValues.get("borrower_name"))%>";
var insmaintanance="<%=Helper.correctNull((String)hshValues.get("proper_main"))%>";
var varOrgLevel="<%=strOrgLevel%>";
var varsaral="<%=strsaral%>";
var appstatus="<%=appstatus%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
	    	if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].action=appUrl+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				document.forms[0].method="post";	
				document.forms[0].action=appUrl+"action/"+"corppge.jsp";
				document.forms[0].submit();
			}
	}
}




</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">

<form name="frminspection" method="post">

  <table width="100%" border="0" cellspacing="1" cellpadding="3">
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
    		<td align="center" colspan="4"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
  		</tr>
 		<tr> 
    		<td align="center" colspan="4"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  		</tr>
  		<tr> 
    		<td align="center" colspan="4"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
      		<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
      		<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
      		<hr/>
    		</td>
  		</tr>
          <tr> 
            <td align="center" colspan="4"><b><u> Due diligence certificate for 
              property offered as security </u></b></td>
          </tr>
          <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><laps:inward/></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"> <laps:application/></td>
  </tr>
  <%}%>
          <tr> 
            <td align="center" colspan="4"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td>&nbsp; </td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td align="center">ANNEXURE</td>
    </tr>
    <tr> 
      <td height="28">&nbsp; </td>
      <td height="28">Date of Inspection : <%=Helper.correctNull((String)hshValues.get("duediligence_inspect"))%> 
      </td>
      <td height="28">&nbsp;</td>
      <td height="28">&nbsp;</td>
    </tr>
    <tr> 
      <td  width="2%"><b>1.</b></td>
      <td  width="49%"><b> Name of the Account</b></td>
      <td width="1%" valign="top"> 
        <div align="center" ><b>:</b></div>
      </td>
      <td width="48%" ><%if(strsaral.equalsIgnoreCase("saral"))
		{%>
		<%=strappname%>
		<%}else
    	  {%> <%=Helper.correctNull((String) hshValues.get("appname"))%><%} %></td>
    </tr>
    <tr> 
      <td width="2%" valign="top"><b>2.</b></td>
      <td valign="top"><b> Credit limit sought for</b></td>
      <td width="1%" valign="top"> 
        <div align="center" ><b>:</b></div>
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr>
    	<td>&nbsp;</td> 
    	<td colspan="3">
        <table width="80%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="1" cellpadding="0">
                <tr > 
                  <td width="75%" ><b> Nature of Facility </b></td>
                  <td width="25%" align="right" ><b>&nbsp;Amount(<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
                </tr>
                <%	
                String facnature="";
			if(arrRow!=null && arrRow.size() > 0){
			if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
			arrCol = (ArrayList) arrRow.get(i);
			
	
			%>
                <tr > 
                <%
                if(!Helper.correctNull((String)hshValues.get("strretail")).equalsIgnoreCase("Y"))
                {
	                if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("1"))
	    			{
	    				facnature="Contingent Limits";
	    			}
	    			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("2"))
	    			{
	    				facnature="Working capital Limits";
	    			}
	    			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("3"))
	    			{
	    				facnature="Term Loan/DPGL Limits";
	    			}
	    			else
	    			{
	    				facnature=Helper.correctNull((String)arrCol.get(3));
	    			}
	            }
                else
	            {
                	out.print(arrCol);
    				facnature = Helper.correctNull((String)arrCol.get(1));
    			}
                %>
                  <td width="75%" ><%=facnature%>&nbsp;</td>
                  <td width="25%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
                </tr>
                <%}
			}}else{

			    %>
                <tr> 
                  <td align="center" colspan="2">Nil</td>
                </tr>
                <%} %>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3">
          <tr> 
            <td width="2%" valign="top"><b>3.</b></td>
            <td width="49%" valign="top"><b>List of documents submitted </b></td>
            <td width="1%" valign="top"> 
              <div align="center" ><b>:</b></div>
            </td>
            <td width="48%"> 
              <P> <%=Helper.formatTextAreaData((String)hshValues.get("duediligence_docs"))%> 
                &nbsp; </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="2%"><b>4.</b></td>
            <td width="49%"><b>Name of the owner of the property and full address 
              with telephone no </b></td>
            <td width="1%"> 
              <div align="center" ><b>:</b></div>
            </td>
            <td width="48%"> 
              <P> <%=Helper.formatTextAreaData((String)hshValues.get("duediligence_address"))%> 
                &nbsp;</P>
            </td>
          </tr>
          <tr> 
            <td width="2%" valign="top"><b>5.</b></td>
            <td width="49%" valign="top"><b>Brief description of the property 
              </b></td>
            <td width="1%" valign="top"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> 
              <P> <%=Helper.formatTextAreaData((String)hshValues.get("duediligence_property"))%> 
                &nbsp; </P>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="4" > 
        <table width="100%" border="0" cellspacing="3" cellpadding="3">
          <tr valign="top"> 
            <td width="2%" height="28" >6.</td>
            <td colspan="2" height="28"><b>Location of the property</b></td>
            <td width="1%" height="28">&nbsp;</td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>a)</b></td>
            <td width="47%"><b>Plot No. / Survery No., </b> 
            <td width="1%" align="center"><b>:</b></td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_plot"))%> </td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>b)</b></td>
            <td width="47%"><b>Door No.</b></td>
            <td width="1%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_door"))%></td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>c)</b></td>
            <td width="47%"><b>T.S No. / Village ,</b></td>
            <td width="1%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_TSNo"))%></td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>d)</b></td>
            <td width="47%"><b>Ward / Taluka</b></td>
            <td width="1%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_ward"))%></td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>e)</b></td>
            <td width="47%"><b>Mandal / Disctrict</b></td>
            <td width="1%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_mandal"))%></td>
          </tr>
          <tr valign="top"> 
            <td width="2%">&nbsp;</td>
            <td width="2%"><b>f)</b></td>
            <td width="47%"><b>Any Other</b></td>
            <td width="1%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="48%"> <%=Helper.correctNull((String) hshValues.get("duediligence_others"))%></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3">
          <tr valign="top"> 
            <td width="3%"><b>7.</b></td>
            <td width="48%"> 
              <b>Whether residential / commercial or industrial 
                / Agriculture </b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_residential"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>8.</b></td>
            <td width="48%"> 
              <b>Whether coming under Corporation limit village 
                panchayat / Municipality</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_corporation"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>9.</b></td>
            <td width="48%"> 
              <b>Whether covered under any state / Cent. Govt. 
                enactments or notified under agency area/ scheduled area / cantonment 
                area.</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_state"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>10.</b></td>
            <td width="48%"> 
              <b>Size of the plot</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_plotsize"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>11.</b></td>
            <td width="48%"> 
              <b>Whether occupied by the owner or tenant</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_owners"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>12.</b></td>
            <td width="48%"> 
              <b>If occupied by tenant since how long and monthly 
                rent </b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_sincewhen"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>13.</b></td>
            <td width="48%"> 
              <b>Availability of Civic amenities like School 
                ,Hospital,Bus Stop,Market etc.</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_civic"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>14.</b></td>
            <td width="48%"> 
              <b>Boundaries of the property</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_boundaries"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>15.</b></td>
            <td width="48%"> 
              <b>Development of surrounding areas</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_surrounding"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>16.</b></td>
            <td width="48%"> 
              <b>Whether Non Agriculture Certificate is available</b>
            </td>
            <td width="2%"> 
              <div align="center"><b>:</b></div>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_certificate"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%" ><b>17.</b></td>
            <td width="48%"><b>In case a property belongs to third party, 
                relationship of the borrower with the mortgager </b>
            </td>
            <td width="2%" align="center"><b>:</b>
            </td>
            <td width="47%" > 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_mortrelation"))%> 
              </P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%" ><b>18.</b></td>
            <td width="48%" ><b>Name of the persons with whom enquiry is made 
                about the ownership of the property, position ,valuation and marketability 
                and their views with their address,Telephone/Mobile No.etc.</b>
            </td>
            <td width="2%" align="center"><b>:</b>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_enquiry"))%></P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>19.</b></td>
            <td width="48%"><b>Approx. value of the property</b>
            </td>
            <td width="2%" align="center"><b>:</b>
            </td>
            <td width="47%"> 
              <P> <%=Helper.formatTextAreaData((String) hshValues.get("duediligence_propertyvalue"))%></P>
            </td>
          </tr>
          <tr valign="top"> 
            <td width="3%"><b>20.</b></td>
            <td width="48%"><b>Comments on the marketablity of the property</b>
            </td>
            <td width="2%" align="center"><b>:</b>
            </td>
            <td width="47%"> 
              <P><%=Helper.formatTextAreaData((String) hshValues.get("duediligence_market"))%> 
              </P>
            </td>
          </tr>
          <tr> 
            <td width="3%"></td>
            <td width="48%">&nbsp;</td>
            <td width="2%">&nbsp; </td>
            <td width="47%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td width="48%">&nbsp; </td>
            <td colspan="2">&nbsp; </td>
          </tr>
          <tr> 
            <td width="3%">&nbsp;</td>
            <td width="48%">&nbsp;</td>
            <td>&nbsp;</td>
            <td align="center"><b>(<%=Helper.correctNull((String)hshValues.get("duediligence_name"))%>)<br/><%=Helper.correctNull((String)hshValues.get("duediligence_designation"))%></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>

