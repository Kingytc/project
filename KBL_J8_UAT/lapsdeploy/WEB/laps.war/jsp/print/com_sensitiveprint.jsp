<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%HashMap hshRecord=new HashMap();
hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));
			ArrayList vecid1 = (ArrayList) hshRecord.get("vecid1");
			ArrayList vecid2 = (ArrayList) hshRecord.get("vecid2");
			ArrayList vecid3 = (ArrayList) hshRecord.get("vecid3");
			ArrayList vecid4 = (ArrayList) hshRecord.get("vecid4");
			ArrayList vecPercent=(ArrayList)hshRecord.get("vecPercent1");
			String bgclr = "";
			String tagFlag = "";

			int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0;
			String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", identity = "", fromnext = "";
    		totcount = Helper.correctNull((String) hshRecord.get("totalyear"));
    		upto = Helper.correctNull((String) hshRecord.get("upto"));
			fromnext = Helper.correctNull((String) hshRecord.get("from"));
			pageval = Helper.correctNull((String) hshRecord.get("page"));
			identity = Helper.correctNull((String) hshRecord.get("identity"));
			java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
			strCurModule = pageval;

			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			ArrayList g3 = new ArrayList();
			ArrayList year1 = new ArrayList();
			ArrayList year2 = new ArrayList();
			ArrayList year3 = new ArrayList();
			ArrayList year4 = new ArrayList();
			ArrayList finyear1 = new ArrayList();
			ArrayList finyear2 = new ArrayList();
			ArrayList finyear3 = new ArrayList();
			ArrayList finyear4 = new ArrayList();
			g2 = (ArrayList) hshRecord.get("yearvalue");
			g3 = (ArrayList) hshRecord.get("value");
			year1 = (ArrayList) hshRecord.get("year1");
			year2 = (ArrayList) hshRecord.get("year2");
			year3 = (ArrayList) hshRecord.get("year3");
			year4 = (ArrayList) hshRecord.get("year4");
			finyear1 = (ArrayList) hshRecord.get("finyear1");
			finyear2 = (ArrayList) hshRecord.get("finyear2");
			finyear3 = (ArrayList) hshRecord.get("finyear3");
			finyear4 = (ArrayList) hshRecord.get("finyear4");
			ArrayList vecModule = (ArrayList) hshRecord.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String yearval[] = new String[5];
			String comboselect[] = new String[5];
			int y = 0, n = 0;
			if (g2.size() != 0) {
				sizeyear = g2.size();
				for (int k = 0; k <= g2.size() - 1; k++) {
					if ((k % 2) == 0) {
						temp = Helper.correctNull((String) g2.get(k));
						yearval[y] = temp;
						y = y + 1;
					} else if ((k % 2) == 1) {
						temp = Helper.correctNull((String) g2.get(k));
						 if (temp.trim().equals("fin_projection")) {
							temp = "Projection";
						}else if (temp.trim().equals("fin_stress_projection")) {
							temp = "Projection";
						}						
						comboselect[n] = temp;
						n = n + 1;
					}
				}
				for (int d = 0; d <= 3; d++) {
					if (comboselect[d] == null) {
						comboselect[d] = "";
					}
					if (yearval[d] == null) {
						yearval[d] = "";
					}
				}
			} else {
				for (p = 0; p <= 3; p++) {
					comboselect[p] = "";
					yearval[p] = "";
				}
			}
			String strFinType1 = Helper.correctNull((String) comboselect[0]);
			String strFinType2 = Helper.correctNull((String) comboselect[1]);
			String strFinType3 = Helper.correctNull((String) comboselect[2]);
			String strFinType4 = Helper.correctNull((String) comboselect[3]);

			String strYear1 = Helper.correctNull((String) yearval[0]);
			String strYear2 = Helper.correctNull((String) yearval[1]);
			String strYear3 = Helper.correctNull((String) yearval[2]);
			String strYear4 = Helper.correctNull((String) yearval[3]);			

			if (strFinType1.trim().equalsIgnoreCase("S")) {
				strFinType1 = Helper.correctNull((String) request.getParameter("type1"));
			}
			if (strFinType2.trim().equals("S")) {
				strFinType2 = Helper.correctNull((String) request.getParameter("type2"));
			}
			if (strFinType3.trim().equals("S")) {
				strFinType3 = Helper.correctNull((String) request.getParameter("type3"));
			}
			if (strFinType4.trim().equals("S")) {
				strFinType4 = Helper.correctNull((String) request.getParameter("type4"));
			}
			ArrayList v = (ArrayList) hshRecord.get("labeldetails");
			String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
			String finval = "", colval1 = "";
			String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
			int vecsize = 0, count = 1, yearsize = 0, finsize = 0, startsize = 0;
			String colid = "", rowid = "",rowpercent="",rowdesc="";
			
			String fincolval1 = "", fincolval2 = "", fincolval3 = "", fincolval4 ="";
			if (v != null) {
				vecsize = v.size();
			}
			if (year1 != null) {
				yearsize = year1.size();
			}
			if (yearsize == vecsize) {
				finsize = vecsize;
			} else if (yearsize < vecsize) {
				finsize = yearsize;
			}
			for (int m = 0; m < finsize; m++) {
				g1 = (ArrayList) v.get(m);
			rowdesc = Helper.correctNull((String) g1.get(1));
			}
			%>
			<div class="title">Sensitivity Analysis : </div><br>
			<table width="100%" border="0" cellspacing="0" cellpadding="1" align="left">
					<tr >
						<td>
<div id="top">
		<%boolean base_year = false;
			int strWidth;
			int tabWidth;
			int tableWidth;
			strWidth = vecModSize;
			if (strWidth == 1) {
				tableWidth = 15;
			} else if (strWidth == 2) {
				tableWidth = 30;
			} else {
				tableWidth = 60;
			}%>
		<%if(rowdesc.length()>0){ %>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" align="left">
					<tr >
						<td colspan="2" align="center"><b>Particulars</b></td>
						<td width="5%" align="center"><b>Stress (%)</b>&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
						<td width="13%" align="center">&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
						<td width="14%" align="center">&nbsp;</td>
					</tr>
					<tr >
						<td colspan="3">&nbsp;</td>
						<td width="14%" align="center"><%=strYear1%></td>
						<td width="14%" align="center"><%=strYear2%></td>
						<td width="14%" align="center"><%=strYear3%></td>
						<td width="14%" align="center"><%=strYear4%></td>
					</tr>
					<tr >
						<td colspan="3">&nbsp;</td>
						<td width="14%" align="center"><%=comboselect[0] %></td>
						<td width="14%" align="center"><%=comboselect[1] %></td>
						<td width="14%" align="center"><%=comboselect[2] %></td>
						<td width="14%" align="center"><%=comboselect[3] %></td>
					</tr>
					<%			
			for (int l = 0; l < finsize; l++) {
				g1 = (ArrayList) v.get(l);

				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();

				if (year1 != null) {

					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {

						colval1 = Helper.correctDouble((String) year1
								.get(l));
					} else {
						colval1 = "0.00";
					}

				} else {
					colval1 = "0.00";
				}
				
				if (finyear1 != null) {

					rowid = Helper.correctDouble((String) vecid1.get(l));
					rowid = rowid.trim();
					if (rowid.equals(colid)) {

						fincolval1 = Helper.correctDouble((String)finyear1
								.get(l));
					} else {
						fincolval1 = "0.00";
					}
				} else {
					fincolval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {
						colval2 = Helper.correctDouble((String) year2
								.get(l));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
				}				
				if (finyear2 != null) {
					rowid = Helper.correctDouble((String) vecid2.get(l));
					if (rowid.equals(colid)) {

						fincolval2 = Helper.correctDouble((String) finyear2.get(l));
					} else {
						fincolval2 = "0.00";
					}
				} else {
					fincolval2 = "0.00";
				}

				if (year3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						colval3 = Helper.correctDouble((String) year3.get(l));
					} else {
						colval3 = "0.00";
					}
				} else {
					colval3 = "0.00";
				}
				
				if (finyear3 != null) {
					rowid = Helper.correctDouble((String) vecid3.get(l));
					if (rowid.equals(colid)) {
						fincolval3 = Helper.correctDouble((String) finyear3.get(l));
					} else {
						fincolval3 = "0.00";
					}
				} else {
					fincolval3 = "0.00";
				}

				if (year4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						colval4 = Helper.correctDouble((String) year4.get(l));
					} else {
						colval4 = "0.00";
					}
				} else {
					colval4 = "0.00";
				}
				
				if (finyear4 != null) {
					rowid = Helper.correctDouble((String) vecid4.get(l));
					if (rowid.equals(colid)) {
						fincolval4 = Helper.correctDouble((String) finyear4.get(l));
					} else {
						fincolval4 = "0.00";
					}
				} else {
					fincolval4 = "0.00";
				}			
				col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
				col2 = "row" + Helper.correctNull((String) g1.get(0))	+ "c2";
				col3 = "row" + Helper.correctNull((String) g1.get(0))	+ "c3";
				col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";			
				selectdesc = "desc"	+ Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));%>
					<tr class="datagrid">
						<td width="3%" align="center"><%=Helper.correctNull((String) g1.get(3))%>&nbsp;
						</td>
						<td width="23%"><%=Helper.correctNull((String)g1.get(1))%></td>
						<%if(vecPercent!=null && vecPercent.size()>0){ %>
						<td width="5%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecPercent.get(l)))) %>&nbsp;</td>
						<%} %>
						<td width="14%" align="right"><%=colval1%>&nbsp;</td>
						<td width="13%" align="right"><%=colval2%>&nbsp;</td>
						<td width="13%" align="right"><%=colval3%>&nbsp;</td>
						<td width="13%" align="right"><%=colval4%>&nbsp;</td>
					</tr>
					<%}
			int endsize = 0;
			startsize = finsize;
			if (yearsize < vecsize) {			
				for (int l = startsize; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);
					colval1 = "0.00";
					colval2 = "0.00";
					colval3 = "0.00";
					colval4 = "0.00";
					
					fincolval1 = "0.00";
					fincolval2 = "0.00";
					fincolval3 = "0.00";
					fincolval4 = "0.00";
					col1 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c1";
					col2 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c2";
					col3 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c3";
					col4 = "row" + Helper.correctNull((String) g1.get(0))
							+ "c4";
					
					selectdesc = "desc"
							+ Helper.correctNull((String) g1.get(0));
					strtype = Helper.correctNull((String) g1.get(2));

					%>
					<tr class="datagrid">
						<td width="23%"><%=Helper.correctNull((String)g1.get(1))%></td>
						<%if(vecPercent!=null && vecPercent.size()>0){ %>
						<td width="5%" align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecPercent.get(l)))) %>&nbsp;</td>
						<%} %>
						<td width="14%" align="right"><%=colval1%>&nbsp;</td>
						<td width="13%" align="right"><%=colval2%>&nbsp;</td>
						<td width="13%" align="right"><%=colval3%>&nbsp;</td>
						<td width="13%" align="right"><%=colval4%>&nbsp;</td>					
					</tr>
					<%}}%>
				</table>
				
		
		</div></td></tr><tr><td><br>
		
		<table width="90%" border="0" cellspacing="0" cellpadding="1" align="left">
					<tr >
						<td class="title">Remarks : </td></tr>
						<tr><td><%=Helper.correctNull((String)hshRecord.get("notes"))%></td></tr></table>
						</td></tr></table>

			<%}else{ %>
			<tr><td style="border: none;">Nil</td></tr>
			<%} %>