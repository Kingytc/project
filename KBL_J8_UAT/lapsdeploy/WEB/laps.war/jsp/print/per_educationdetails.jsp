<%@include file="../share/directives.jsp"%>
<% 
   ArrayList arrDevCol = new ArrayList();
   ArrayList arrDevRow = new ArrayList();
   if(hshValues!=null)
   {
	   arrDevRow = (ArrayList)hshValues.get("arrDevRow");
   }
   
    ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	
	ArrayList vecDataSchl = new ArrayList();
	ArrayList vecRowSchl = new ArrayList();
	int vecsizeSchl = 0;
	
	if (hshValues != null) {
		vecData = (ArrayList) hshValues.get("vecDataEdu");
		vecDataSchl = (ArrayList) hshValues.get("vecDataSchl");
	}
	
	ArrayList vecDataCol = new ArrayList();
	String eduyear1[] = new String[15];
	String eduyear2[] = new String[15];
	String eduyear3[] = new String[15];
	String eduyear4[] = new String[15];
	String eduyear5[] = new String[15];
	String eduyear6[] = new String[15];
	String comments[] = new String[15];
	String totalexpenses[] = new String[15];

	int vecsizeCol = 0;
	
	if (hshValues != null & vecDataCol != null) 
	{
		vecDataCol = (ArrayList) hshValues.get("vecCol");
		vecsizeCol = vecDataCol.size();

		ArrayList g1 = new ArrayList();

		int k = 0;

		////System.out.println("0" + vecsizeCol);
		for (int i = 0; i < vecsizeCol; i++) 
		{
			g1 = (ArrayList) vecDataCol.get(i);

			if (Helper.correctNull((String) g1.get(8)).equals("e")) 
			{
				eduyear1[k] = (String) g1.get(0);
				eduyear2[k] = (String) g1.get(1);
				eduyear3[k] = (String) g1.get(2);
				eduyear4[k] = (String) g1.get(3);
				eduyear5[k] = (String) g1.get(4);
				eduyear6[k] = (String) g1.get(5);
				totalexpenses[i] = (String) g1.get(6);
				comments[k] = (String) g1.get(7);

				k++;
			}

		}

		for (int i = 0; i < vecsizeCol; i++) 
		{
			g1 = (ArrayList) vecDataCol.get(i);

			if (Helper.correctNull((String) g1.get(8)).equals("s")) 
			{
				////System.out.println("1" + k);
				eduyear1[k] = (String) g1.get(0);
				eduyear2[k] = (String) g1.get(1);
				eduyear3[k] = (String) g1.get(2);
				eduyear4[k] = (String) g1.get(3);
				eduyear5[k] = (String) g1.get(4);
				eduyear6[k] = (String) g1.get(5);
				totalexpenses[i] = (String) g1.get(6);
				comments[k] = (String) g1.get(7);

				k++;
				////System.out.println("2" + k);
			}

		}
	}
	
	ArrayList vecDataMOF = new ArrayList();
	String eduyear1MOF[] = new String[12];
	String eduyear2MOF[] = new String[12];
	String eduyear3MOF[] = new String[12];
	String eduyear4MOF[] = new String[12];
	String eduyear5MOF[] = new String[12];
	String eduyear6MOF[] = new String[12];
	String commentsMOF[] = new String[12];
	String totalexpensesMOF[] = new String[12];

	int vecsizeMOF = 0;
	
	if (hshValues != null & vecDataMOF != null) 
	{
		vecDataMOF = (ArrayList) hshValues.get("vecColMOF");
		vecsizeMOF = vecDataMOF.size();

		ArrayList g1 = new ArrayList();

		int k = 0;

		////System.out.println("0" + vecsizeCol);
		for (int i = 0; i < vecsizeMOF; i++) 
		{
			g1 = (ArrayList) vecDataMOF.get(i);

			if (Helper.correctNull((String) g1.get(8)).equals("e")) 
			{
				eduyear1MOF[k] = (String) g1.get(0);
				eduyear2MOF[k] = (String) g1.get(1);
				eduyear3MOF[k] = (String) g1.get(2);
				eduyear4MOF[k] = (String) g1.get(3);
				eduyear5MOF[k] = (String) g1.get(4);
				eduyear6MOF[k] = (String) g1.get(5);
				totalexpensesMOF[i] = (String) g1.get(6);
				commentsMOF[k] = (String) g1.get(7);

				k++;
			}

		}

		for (int i = 0; i < vecsizeMOF; i++) 
		{
			g1 = (ArrayList) vecDataMOF.get(i);

			if (Helper.correctNull((String) g1.get(8)).equals("s")) 
			{
				////System.out.println("1" + k);
				eduyear1MOF[k] = (String) g1.get(0);
				eduyear2MOF[k] = (String) g1.get(1);
				eduyear3MOF[k] = (String) g1.get(2);
				eduyear4MOF[k] = (String) g1.get(3);
				eduyear5MOF[k] = (String) g1.get(4);
				eduyear6MOF[k] = (String) g1.get(5);
				totalexpensesMOF[i] = (String) g1.get(6);
				commentsMOF[k] = (String) g1.get(7);

				k++;
				////System.out.println("2" + k);
			}

		}
	}
	
 String strcourse= Helper.correctNull((String) hshValues.get("edu_partfull"));
 String strstudies= Helper.correctNull((String) hshValues.get("prd_purpose"));
 String strcompulsary =Helper.correctNull((String) hshValues.get("edu_comp_stay_hostel"));
 String strinstut=Helper.correctNull((String) hshValues.get("edu_univ_situ_domicile"));
 String streducat=Helper.correctNull((String) hshValues.get("edu_qual_proposed"));
 String strmodesec=Helper.correctNull((String) hshValues.get("edu_mode_secure"));
 String strapprcou=Helper.correctNull((String) hshValues.get("edu_course_approved"));
 String strrecuniv=Helper.correctNull((String) hshValues.get("edu_univ_approved"));
 String strCourseSpl=Helper.correctNull((String) hshValues.get("edu_typeofcourse"));
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Education Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
  <tr>
		<td>
		
      <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="outertable">		
	
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" cellpadding="3"  cellspacing="0" class="outertable">
			
			<tr>
			<td width="50%">Course Specialization</td>
			<%if(strCourseSpl.equalsIgnoreCase("1")) 
			{
				strCourseSpl="Engineering";
			}else if(strCourseSpl.equalsIgnoreCase("2")) 
			{
				strCourseSpl="Medical";
			}
			else if(strCourseSpl.equalsIgnoreCase("3")) 
			{
				strCourseSpl="Nursing and other Professional Courses";
			}else if(strCourseSpl.equalsIgnoreCase("4")) 
			{
				strCourseSpl="Management";
			}else if(strCourseSpl.equalsIgnoreCase("5")) 
			{
				strCourseSpl="Others";
			}else{
				strCourseSpl=" ";
			}%>
			<td width="50%">&nbsp;<%=strCourseSpl%>&nbsp;</td>
			</tr>
			
			<tr>
			<td width="50%">% of Marks Obtained</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_qualifyingexa"))%>&nbsp;(%)</td>
			</tr>
						
			<tr>
			<td width="50%">Total Family Yearly Income  &nbsp; [Rs in Rs]</td>
			<td width="50%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("indinfo_family_income")),"R")%>&nbsp;</td>
			</tr>
			
			<tr>
			<td width="50%">Name of the Course for which loan is required</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_coursename"))%></td>
			</tr>
			
			
			
			<tr>
			<td width="50%">Is it an approved course & Recognized by</td>
			<td width="50%">&nbsp;
			<%if(strapprcou.equalsIgnoreCase("1")) 
			{%>
				Yes
			<%}%>
			<%if(strapprcou.equalsIgnoreCase("2")) 
			{%>
				No
			<%}%>
			&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_course_approvedby"))%></td>
			</tr>
			
		    <tr>
			<td width="50%">University / Institution</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_univ_name"))%></td>
			</tr>
			
			
			<tr>
			<td width="50%">Is it a Recognized University/Institution &Recognized by</td>
			<td width="50%">&nbsp;
			<%if(strrecuniv.equalsIgnoreCase("1")) 
			{%>
				Yes
			<%}%>
			<%if(strrecuniv.equalsIgnoreCase("2")) 
			{%>
				No
			<%}%>
			
			&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_univ_approvedby"))%></td>
			</tr>
			
			
			<tr>
			<td width="50%">Address of the University/Institution</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_univ_addr"))%></td>
			</tr>
			
			<tr>
			<td width="50%">Type of Course </td>
			<td width="50%">&nbsp;
			<%if(strcourse.equalsIgnoreCase("1")) 
			{%>
				Part Time
			<%}%>
			<%if(strcourse.equalsIgnoreCase("2")) 
			{%>
				Full Time
			<%}%>
			<%if(strcourse.equalsIgnoreCase("3")) 
			{%>
			   Evening Course
			<%}%>
			<%if(strcourse.equalsIgnoreCase("4")) 
			{%>
			  Correspondense
			<%}%>
			<%if(strcourse.equalsIgnoreCase("5")) 
			{%>
				Vocational
			<%}%>
			</td>
			</tr>
			
			<tr>
			<td width="50%">Edu. Qualification Proposed  </td>
			<td width="50%">&nbsp;
			<%if(streducat.equalsIgnoreCase("1")) 
			{%>
				Doctorate /Other Professional
			<%}%>
			<%if(streducat.equalsIgnoreCase("2")) 
			{%>
				Post Graduate
			<%}%>
			<%if(streducat.equalsIgnoreCase("3")) 
			{%>
				Graduate
			<%}%>
			<%if(streducat.equalsIgnoreCase("4")) 
			{%>
				Diploma/Certification
			<%}%>
			<%if(streducat.equalsIgnoreCase("5")) 
			{%>
				Higher Secondary
			<%}%>
			<%if(streducat.equalsIgnoreCase("6")) 
			{%>
				Below Higher Secondary
			<%}%>
			
			
			</td>
			</tr>
			
            <tr>
			<td width="50%">Duration of the Course</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_durationyrs"))%>&nbsp;(Years)&nbsp;&nbsp;
									<%=Helper.correctNull((String) hshValues.get("edu_durationmon"))%>&nbsp;(Months)</td>
			</tr>
			
			<tr>
			<td width="50%">Marks Secured in the Qualifying Examination </td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_qualifyingexa"))%>&nbsp; %</td>
			</tr>
			
			<tr>
			<td width="50%">Date of commencement of the course </td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_commencedate"))%></td>
			</tr>
			
				
			<tr>
			<td width="50%">Mode of securing admission</td>
			<td width="50%">&nbsp;
			<%if(strmodesec.equalsIgnoreCase("1")) 
			{%>
				Entrance Test
			<%}%>
			<%if(strmodesec.equalsIgnoreCase("2")) 
			{%>
				Selection Process
			<%}%>
			<%if(strmodesec.equalsIgnoreCase("3")) 
			{%>
				Direct on merit
			<%}%>
			<%if(strmodesec.equalsIgnoreCase("4")) 
			{%>
				Management Quota
			<%}%>
			</td>
			</tr>
			
			
			<tr>
			<td width="50%">Studies</td>
			<td width="50%">&nbsp;
			<%if(strstudies.equalsIgnoreCase("I")) 
			{%>
				In India
			<%}%>
			<%if(strstudies.equalsIgnoreCase("A")) 
			{%>
			    Abroad
			<%}%>
			
			</td>
			</tr>
			
			<tr>
			<td width="50%">Is the institution situated at the place of domicile</td>
			<td width="50%">&nbsp;
			<%if(strinstut.equalsIgnoreCase("1")) 
			{%>
			Yes
			<%}%>
			<%if(strinstut.equalsIgnoreCase("2")) 
			{%>
				No
			<%}%>
			</td>
			</tr>
			
			
			<tr>
			<td width="50%">Expected Income per month after completion of course&nbsp;</td>
			<td width="50%">Rs&nbsp;<%=Helper.correctNull((String) hshValues.get("expected_income"))%></td>
			</tr>
			
			<tr>
			<td width="50%">Is it compulsory to stay in hostel</td>
			<td width="50%">&nbsp;
			<%if(strcompulsary.equalsIgnoreCase("1")) 
			{%>
			Yes
			<%}%>
			<%if(strcompulsary.equalsIgnoreCase("2")) 
			{%>
				No
			<%}%>
			
			</td>
			</tr>
			
			<tr>
			<td width="50%">Particular of admission letter</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_comments1"))%></td>
			</tr>
			
		   <tr>
			<td width="50%">Insurance Details</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_comments3"))%></td>
			</tr>
			
			
			<tr>
			<td width="50%">Other Details</td>
			<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("edu_comments4"))%></td>
			</tr>
			
		</table>
		
			</div>
			</td>
			</tr>		
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr>
			<td><b>Other Educational Details:</b></td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" cellpadding="3" cellspacing="0"  class="outertable">	
					<tr class="tblhead">
						<td width="4%" align="center">&nbsp;</td>
						<td width="26%" align="center">Examination</td>
						<td width="26%" align="center">Institution</td>
						<td width="11%" align="center">Year of passing</td>
						<td width="11%" align="center">Attempts made</td>
						<td width="11%" align="center">% of marks</td>
						<td width="11%" align="center">Class obtained</td>
					</tr>
					<%
						if (vecData != null) 
						{
							vecsize = vecData.size();
						}
						String strSno = "";

						java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
						jtn.setMaximumFractionDigits(2);
						jtn.setMinimumFractionDigits(2);
						jtn.setGroupingUsed(false);

						for (int i = 0; i < vecsize; i++) 
						{
							vecRow = (ArrayList) vecData.get(i);
							if (vecRow != null) 
							{
								strSno = Helper.correctNull((String) vecRow.get(0));
					%>
						<tr>
							<td valign="middle" width="4%" align="center">&nbsp;<%=i+1%>.&nbsp;</td>
							<td valign="middle">&nbsp;<%=Helper.correctNull((String) vecRow.get(1))%></td>
							<td valign="middle">&nbsp;<%=Helper.correctNull((String) vecRow.get(2))%>&nbsp;</td>
							<td valign="middle" align="center">&nbsp;<%=Helper.correctNull((String) vecRow.get(3))%>&nbsp;</td>
							<td valign="middle" align="center">&nbsp;<%=Helper.correctNull((String) vecRow.get(4))%>&nbsp;</td>
							<td valign="middle" align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctDouble((String) vecRow.get(5)))%>&nbsp;</td>
							<td valign="middle" align="center">&nbsp;<%=Helper.correctNull((String) vecRow.get(6))%>&nbsp;</td>
						</tr>
					<%
							}
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr>
			<td><b>Scholarship Details:</b></td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" cellpadding="3" cellspacing="0"  class="outertable">	
					<%
						if (vecDataSchl != null) {
					%>
					<tr class="tblhead">
						<td width="4%">&nbsp;</td>
						<td width="16%" align="center">Examination</td>
						<td width="16%" align="center" >Academic Distinction</td>
						<td width="16%" align="center" > Name of Scholarship</td>
						<td width="16%" align="center">Amount [Rs. in Rs]</td>
						<td width="16%" align="center" nowrap>Duration From</td>
						<td width="16%" align="center">Duration To</td>
					</tr>
					<%
						vecsizeSchl = vecDataSchl.size();
						}
						strSno = "";
						jtn.setMaximumFractionDigits(2);
						jtn.setMinimumFractionDigits(2);
						jtn.setGroupingUsed(false);
						for (int i = 0; i < vecsizeSchl; i++) 
						{
							vecRowSchl = (ArrayList) vecDataSchl.get(i);
							if (vecRowSchl != null) 
							{
								strSno = Helper.correctNull((String) vecRowSchl.get(0));
					%>
					<tr>
						<td align="center"><%=i+1%>.</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecRowSchl.get(1))%></td>
						<td valign="middle">&nbsp;<%=Helper.correctNull((String) vecRowSchl.get(2))%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
						<td valign="middle">&nbsp; <%=Helper.correctNull((String) vecRowSchl.get(3))%></td>
						<td align="right">&nbsp; <%=Helper.converAmount(Helper.correctDouble((String) vecRowSchl.get(4)),"R")%></td>
						<td valign="middle" align="center"><%=Helper.correctNull((String) vecRowSchl.get(5))%></td>
						<td valign="middle" align="center">&nbsp; <%=Helper.correctNull((String) vecRowSchl.get(6))%></td>
					</tr>
					<%
						}
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
						
			<%
			String str_arr[]={ "College Fees","Books/Equipments/Instruments/Uniforms","Cost of Computer","Examination Fees",
							   "Library / Laboratory Fee","Travel Expenses","Building Fund / Refundable Deposit","Boarding Fee/Expenses",
							   "Hostel Fees or Lodge Rent","Caution Deposit","Insurance Premium"};
			
			%>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr>
			<td><b><span style="float: left;">Details of Fees & Other Expenses:</span><span style="float: right;">(Amount in Rs)</span></b></td>
			</tr>
			
			<tr>
				<td>
				<div id="top">
					<table width="100%" border="0" cellpadding="3"  cellspacing="0" class="outertable">
						<tr class="tblhead">
							<td colspan='2' align="center">Cost of Estimates</td>
							<td colspan='7' align="center">Year of Study</td>
						</tr>
						<tr class="tblhead">
							<td width="4%" align="center">S.No.</td>
							<td width="24%" align="center">Particulars</td>
							<td width="10%" align="center">I</td>
							<td width="10%" align="center">II</td>
							<td width="10%" align="center">III</td>
							<td width="10%" align="center">IV</td>
							<td width="10%" align="center">V</td>
							<td width="10%" align="center">VI</td>
							<td width="12%" align="center">Total Expenses</td>
						</tr>
						
						<%
						for(int f=0;f<11;f++)
						{
						%>
						<tr><td>&nbsp;<%=f+1%>.</td>
							<td>&nbsp;<%=Helper.correctNull(str_arr[f])%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear1[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear2[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear3[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear4[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear5[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear6[f]),"R")%></td>
							<td width="12%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) totalexpenses[f]),"R")%></td>
						</tr>
						<%	} %>
						
						<%
						for(int f=11;f<15;f++)
						{
						%>
						<tr><td>&nbsp;<%=f+1%>.</td>
							<td>&nbsp;<%=Helper.correctNull((String)comments[f])%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear1[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear2[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear3[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear4[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear5[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear6[f]),"R")%></td>
							<td width="12%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) totalexpenses[f]),"R")%></td>
						</tr>
						<%	} %>
						
						<tr><td>&nbsp;</td>
							<td><b>&nbsp;Total Expenses</b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr1")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr2")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr3")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr4")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr5")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr6")),"R")%></b></td>
							<td width="12%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblColTot")),"R")%></b></td>
						</tr>
						
					</table>
				</div>
				</td>
			</tr>		
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<%
			String str_arr2[]={ "Loan Amount from Karnataka Bank","Own Savings","Provident Fund Withdrawal","Disposal of Investments",
							   "FDs","Shares","LIC Policies","Non Repayable Scholarship ","Repayable Scholarship ","Sponsorship by close relatives ",
							   "If Advance Payment ","Others "};
			
			%>
			
			<tr>
				<td>
				<div id="top">
					<table width="100%" border="0" cellpadding="3"  cellspacing="0" class="outertable">
						<tr class="tblhead">
							<td colspan='2' align="center">Means of finance</td>
							<td colspan='7' align="center">Year of Study</td>
						</tr>
						<tr class="tblhead">
							<td width="4%" align="center">S.No.</td>
							<td width="24%" align="center">Sources</td>
							<td width="10%" align="center">I</td>
							<td width="10%" align="center">II</td>
							<td width="10%" align="center">III</td>
							<td width="10%" align="center">IV</td>
							<td width="10%" align="center">V</td>
							<td width="10%" align="center">VI</td>
							<td width="12%" align="center">Total Means</td>
						</tr>
						
						<%
						for(int f=0;f<8;f++)
						{
						%>
						<tr>
							<td>&nbsp;<%=f+1%>.</td>
							<td>&nbsp;<%=Helper.correctNull(str_arr2[f])%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear1MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear2MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear3MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear4MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear5MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear6MOF[f]),"R")%></td>
							<td width="12%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) totalexpensesMOF[f]),"R")%></td>
						</tr>
						<%	} %>
						
						<%
						for(int f=8;f<12;f++)
						{
						%>
						<tr><td>&nbsp;<%=f+1%>.</td>
							<td>&nbsp;<%=Helper.correctNull(str_arr2[f])%>&nbsp;<%=Helper.correctNull((String)commentsMOF[f])%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear1MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear2MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear3MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear4MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear5MOF[f]),"R")%></td>
							<td width="10%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) eduyear6MOF[f]),"R")%></td>
							<td width="12%" align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String) totalexpensesMOF[f]),"R")%></td>
						</tr>
						<%	} %>
						
						<tr><td>&nbsp;</td>
							<td><b>&nbsp;Total Means</b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr1mof")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr2mof")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr3mof")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr4mof")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr5mof")),"R")%></b></td>
							<td width="10%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblTotYr6mof")),"R")%></b></td>
							<td width="12%" align="right"><b>&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblColTotmof")),"R")%></b></td>
						</tr>
					</table>
				</div>
				</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>