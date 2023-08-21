<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
	<%
	ArrayList arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
	ArrayList arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
	ArrayList arrParentID0 = (ArrayList)hshValues.get("arrParentID0");
	ArrayList arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<title>Credit Sanction</title>
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
}

.line {
	margin: 5px 0;
	height: 2px;
	background: repeating-linear-gradient(to right, back 0, red 5px, transparent 5px,
		transparent 7px) /*5px red then 2px transparent -> repeat this!*/
}

.col {
	COLOR: #ff0000;
}
</style>

</head>
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0"
	border="0">
	<tr>
		<td align="center"><br>
		<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	</tr>
	<%
		{
	%>
	<%
		if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("008")) {
	%>
	<tr>
		<td align="center" width="50%">Credit LCFD
		</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("010")) {
				String strComSancbranchcode = Helper
						.correctNull((String) hshValues
								.get("com_sancbranchcode"));
				if (strComSancbranchcode.equalsIgnoreCase("MCFD"))
					strComSancbranchcode = "Credit MCFD";
				else
					strComSancbranchcode = "Credit RFD";
	%>
	<tr>
		<td align="center" width="50%"><%=strComSancbranchcode%>
		</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("013")) {
	%>
	<tr>
		<td align="center" width="50%">Credit RFD</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("014")) {
	%>
	<tr>
		<td align="center" width="50%">Credit MCFD</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("015")
					|| Helper.correctNull(
							(String) hshValues.get("com_sancdeptcode"))
							.equalsIgnoreCase("016")) {
	%>
	<tr>
		<td align="center" width="50%"><%=Helper.correctNull((String) hshValues
									.get("strSanctiondept"))%></td>
	</tr>
	<%
		} else {
	%>
	<tr>
		<td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull(
									(String) hshValues.get("strOrgName"))
									.toUpperCase()%></td>
	</tr>
	<%
		}
	%>
	<%
		}
	%>
	<tr>
		<td align="center" width="70%">&nbsp;</td>
	</tr>
	<tr>
		<td align="right">
		<table width="100%" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td align="left" width="20%"><br>
			<!-- 	Ref.:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /PF/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  /OR/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /2020-21</td>  -->
			        Ref.:&nbsp; <%=Helper.correctNull((String)hshValues.get("selcom_sancdept")) %>  /PF/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  /OR/&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /2020-21</td>  
			</tr>
			<tr>
			<td align="right" width="50%"><br>
				Date:<%=Helper.correctNull((String)hshValues.get("processdate")) %></td>
			</tr>

			<tr>
				<td align="left" width="85%"><br>
				The Branch Head,</td>
			</tr>
			<tr>
				<td>Branch&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("homebranch"))%>
				</td>
			</tr>

			<tr>
				<td align="left"><br>
				Dear sir,</td>
			</tr>

			<tr>
				<td><br>
				<p>Reg: Credit facilities sanctioned to <%=Helper.correctNull((String) hshValues.get("appname"))%></p>
				</td>
			</tr>

			<tr>
				<td><br>
				<p align="justify">In terms of <%=Helper.correctNull((String) hshValues
							.get("sanctionrefno"))%>,the
				working capital limits sanctioned to <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b>is
				reviewed and you are permitted to allow operations in the sanctioned
				working capital limits for a period of 6 months, i.e., up to
				<%=Helper.correctNull((String)hshValues.get("strReviewDate")) %> on the following terms & conditions.</p>
				</td>
			<tr>
				<td class="title"><br>
				Terms and Conditions:</td>
			</tr>
			<%
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;

	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
		<tr><td class="title">Specific:</td></tr>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="100%" >
			      	<tr>
			      		<td width="3%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
			      	<tr>
			      		<td valign="top">&nbsp;&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}
	} %>
	<%
	if(arrFacilityTermApp0!=null)
	{
		for(int i=0;i<arrFacilityTermApp0.size();i++)
		{  main = main+1;
		%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
		}
	} %>

            <tr>
				<td align="left">&nbsp;</td>
			</tr>
			<tr>
				<td align="left">&nbsp;</td>
			</tr>
			<tr>
				<td align="left">Yours faithfully,</td>
			</tr>
			<tr>
				<td class="title"><br>
				Authorised Signatory</td>
			</tr>

		</table>
		</td>
	</tr>
</table>

</body>
</html>