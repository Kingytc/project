<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>KARNATAKA BANK LTD.</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>


<%

ArrayList vecRow = (ArrayList) hshValues.get("ArrayList2");
ArrayList vecCol = null;
String ratecon=Helper.correctNull((String) hshValues.get("RatingConfirmedbyCG"));
String rateconf="";
if(ratecon != "null")
{
	if(ratecon.equalsIgnoreCase("Y"))
	{
		rateconf="Yes";
	}
	else
	{
		rateconf="No";
	}
}
String date=Helper.getCurrentDateTime();


%>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var apptype = "<%=Helper.correctNull((String) hshValues.get("strAppType"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";


</script>
</head>

<body>
<form name="ram106rep" method="post">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable border1">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td align="center"><strong>KARNATAKA BANK LTD. </strong></td>
          </tr>
          <tr>
            <td align="center"><strong>Lending Automation Solution </strong></td>
          </tr>
          <tr>
            <td align="right">LAS 106 </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td colspan="2"><table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td colspan="5" align="center"><strong><U>RATING CONFIRMATION/MODIFICATION/REJECTION BY CREDIT GRID</U></strong></td>
          </tr>
          <tr>
            <td colspan="5" align="center"><strong>Structured Message from Credit Grid to Rating PooL/RO/ZO/FGMO/Branches<br />
              [Credit limits (both Fund and Non-fund)]</strong></td>
          </tr>
          <tr>
            <td width="4%"><strong>1.</strong></td>
            <td width="33" colspan="2">Branch</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("BranchName"))%></td>
          </tr>
          <tr>
            <td><strong>2.</strong></td>
            <td colspan="2">Borrower' Name &amp; ID</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("companyname"))%> &amp;<%=Helper.correctNull((String) hshValues.get("companycode"))%></td>
            
          </tr>
          <tr>
            <td><strong>3.</strong></td>
            <td colspan="2">Structured Message ref. No.
              &amp; Date</td>
            <td width="18%"> <%=Helper.correctNull((String) hshValues.get("DateofFinalisation"))%>
            <!-- <input name="textfield2223" type="text" size="20" maxlength="25" />--></td>
           <!--   <td width="45%"><input name="textfield322" type="text" size="5" maxlength="10" />
&nbsp;
              Yrs &nbsp;
              <input name="textfield332" type="text" size="5" maxlength="10" />
&nbsp;
                Months&nbsp;
                <input name="textfield342" type="text" size="5" maxlength="10" />
&nbsp;
                Days</td>-->
          </tr>
          <tr>
            <td valign="top"><strong>4.</strong></td>
            <td colspan="2"> Credit Rating assigned by
              Rating Pool with ref.No.
              &amp; Date</td>
            <td><%=Helper.correctNull((String) hshValues.get("CreditRatingbyRatingPool"))%> &amp;<%=Helper.correctNull((String) hshValues.get("RatingPoolDate"))%> </td>
            <td><!--  <input name="textfield322" type="text" size="5" maxlength="10" />
  &nbsp;
              Yrs &nbsp;
                <input name="textfield332" type="text" size="5" maxlength="10" />
  &nbsp;
              Months&nbsp;
                  <input name="textfield342" type="text" size="5" maxlength="10" />
  &nbsp;
              Days --></td>
          </tr>
          
                   
          <tr>
            <td><strong>5.</strong></td>
            <td colspan="2">Rating Confirmed by Credit Grid</td>
            <td colspan="2"><%=rateconf %>
             <!--   <select name="select6">
                <option>Yes</option>
                <option>No</option>
              </select>-->
                      </td>
          </tr>
          <tr>
            <td><strong>6.</strong></td>
            <td colspan="2"> Rating Modification sought by
              Credit Grid</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("CGRating"))%></td>
          </tr>
          <tr>
            <td><strong>7.</strong></td>
            <td colspan="2"> Justifications/Rationale to 
              modify Rating</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("CGRationale"))%></td>
          </tr>
          <tr>
            <td><strong>8.</strong></td>
            <td colspan="2"> Rating Rejection by Credit Grid:
              (justify reason for rejection)</td>
            <td colspan="2"><!--  <input name="textfield2223222" type="text" size="20" maxlength="25" />--></td>
          </tr>
          <tr>
          <div align="top">
            <td valign="top"><strong>9.</strong></td>
            <td colspan="2" valign="top"> Risk Pricing based on rating</td>
            <td colspan="2" valign="top">
            
           
            <% if(vecRow!=null && vecRow.size()>0)
            {	
            	for(int i=0;i<vecRow.size();i++)
            	{
            		vecCol=(ArrayList)vecRow.get(i);
        			if(vecCol!=null)
        			{	%>
        				
        				<%String facName=Helper.correctNull((String) vecCol.get(0));
        				String intRate=Helper.correctNull((String) vecCol.get(1));%>
        				 <table width="60%" border="0" valign="top" cellpadding="0" cellspacing="0">
        				 <tr>
   						<td width="5%"><%=i+1%>&nbsp;</td><td width="40%"><%=facName%></td><td width="15%"><%=intRate%></td>
        				</tr>
        				</table>
            <% 	}
            
            	}
            }
           	%>
           	
           	
                </td>
                </div>
          </tr>
          <tr>
            <td><strong>10.</strong></td>
            <td colspan="2"> Rating Review,if any</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("RatingReview"))%></td>
          </tr>
          <tr>
            <td><strong>11</strong>. </td>
            <td colspan="2">Credit Grid observations, if any</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("CGObservations"))%></td>
          </tr>
          <tr>
            <td><strong>12.</strong></td>
            <td colspan="2"> Proposal forwarded to competent
              authority as per Delegated
              Lending Powers for sanction</td>
            <td colspan="2"><!--  <input name="textfield22232234" type="text" size="20" maxlength="25" />--></td>
          </tr>
          <tr>
            <td><strong>13.</strong></td>
            <td colspan="2"> Whether Sanctioned</td>
            <td colspan="2">
            <!-- <select name="select">
              <option>Yes</option>
              <option>No</option>
            </select> --></td>
          </tr>
          <tr>
            <td><strong>14.</strong></td>
            <td colspan="2"> Date of intimation to
              Branch</td>
            <td colspan="2"><%=Helper.correctNull((String) hshValues.get("DateofFinalisation"))%></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td valign="top" align="center">&nbsp;</td>
      </tr>
      <tr>
        <td valign="top" align="center"><strong>DIGITAL SIGNATURE OF <br />
          Credit Grid Members</strong> </td>
        </tr>
      
    </table></td>
  </tr>
</table>

 <%String strappno = request.getParameter("comm_appno");%>
<input type="hidden" name="appno" value="<%=strappno%>">
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl" value="">
</form>
</body>
</html>
