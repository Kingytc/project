<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
             HashMap hshRecord=new HashMap();
             java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
             nf.setGroupingUsed(false);
             nf.setMaximumFractionDigits(2);
             nf.setMinimumFractionDigits(2);
     		 ArrayList vecid1 = (ArrayList) hshValues.get("vecid1");
			 ArrayList vecid2 = (ArrayList) hshValues.get("vecid2");
			 ArrayList vecid3 = (ArrayList) hshValues.get("vecid3");
			 ArrayList vecid4 = (ArrayList) hshValues.get("vecid4");
			 ArrayList vecid5 = (ArrayList) hshValues.get("vecid5");
			 
			 
			 hshRecord=(HashMap)hshValues.get("hshReqValues5");
			String tagFlag = "";
			int p = 0, sizeyear = 0, from = 0, to = 0, vecModSize = 0;
			String temp = "", totcount = "", upto = "", pageval = "", strCurModule = "", fromnext = "";
			totcount = Helper.correctNull((String) hshValues.get("totalyear"));
			
		
			ArrayList arrRowDefault		= new ArrayList();
			ArrayList arrRowCIBIL	= new ArrayList();
			ArrayList arrColCIBIL	= new ArrayList();
			ArrayList arrColDefault		= new ArrayList();
			
			ArrayList arrRow	= new ArrayList();
			ArrayList arrCol	= new ArrayList();
			ArrayList VecRow		= new ArrayList();
			ArrayList VecCol		= new ArrayList();
			
			
			fromnext = Helper.correctNull((String) hshValues.get("from"));
			pageval = Helper.correctNull((String) hshValues.get("page"));
			
	   
			strCurModule = pageval;
			ArrayList g1=new ArrayList();
			ArrayList g2=new ArrayList();
			ArrayList g3 = new ArrayList();
			ArrayList g4 = new ArrayList();
			
			ArrayList year1 = new ArrayList();
			ArrayList year2 = new ArrayList();
			ArrayList year3 = new ArrayList();
			ArrayList year4 = new ArrayList();
			ArrayList year5 = new ArrayList();
			
			VecRow=(ArrayList)hshValues.get("VecRow");

			g2 = (ArrayList) hshValues.get("yearvalue");
			g3 = (ArrayList) hshValues.get("value");
			g4 = (ArrayList) hshValues.get("yearvalue_strt");
			year1 = (ArrayList) hshValues.get("year1");
			year2 = (ArrayList) hshValues.get("year2");
			year3 = (ArrayList) hshValues.get("year3");
			year4 = (ArrayList) hshValues.get("year4");
			year5 = (ArrayList) hshValues.get("year5");
			
			ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String yearval[] = new String[5];
			String yearval_strt[] = new String[5];
			String comboselect[] = new String[5];
			String snos[] = new String[5];
			int y = 0, n = 0,c=1;

			if(g4!=null && g4.size()>0)
			{

				for(int m=0;m<g4.size();m++)
				{
					yearval_strt[m] = Helper.correctNull((String) g4.get(m));
				}
			}
			if (g2!=null && g2.size() != 0) {
				sizeyear = g2.size();
				

				for (int k = 0; k <= g2.size() - 1; k++) {
					if(k<=2)
					{
					snos[c-1]=Helper.correctNull((String)hshValues.get("sno"+(c)));
					c++;
				}
					if ((k % 2) == 0) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						yearval[y] = temp;
						y = y + 1;
					} 
					else if ((k % 2) == 1) 
					{
						temp = Helper.correctNull((String) g2.get(k));
						if (temp.trim().equals("CGTMSE_AUDIT")) {
							temp = "a";
						} else if (temp.trim().equals("CGTMSE_UNAUDIT")) {
							temp = "u";
						} else if (temp.trim().equals("CGTMSE_ESTIMATED")) {
							temp = "e";
						} else if (temp.trim().equals("CGTMSE_PROJECTION")) {
							temp = "p";
						}
						comboselect[n] = temp;
						n = n + 1;
					}
				}
				for (int d = 0; d <= 4; d++) 
				{
					if (comboselect[d] == null) {
						comboselect[d] = "S";

					}
					if (yearval[d] == null) {
						yearval[d] = "";
					}
					if (snos[d] == null) {
						snos[d] = "";
					}
				}
			} 
			else {
				for (p = 0; p <= 4; p++) {
					comboselect[p] = "S";
					yearval[p] = "";
					snos[p] = "";
				}
			}
		
			int sampleval=0;
			String strFinType1 = Helper.correctNull((String) comboselect[0]);
			String strFinType2 = Helper.correctNull((String) comboselect[1]);
			String strFinType3 = Helper.correctNull((String) comboselect[2]);
			String strFinType4 = Helper.correctNull((String) comboselect[3]);
			String strFinType5 = Helper.correctNull((String) comboselect[4]);

			String strYear1 = Helper.correctNull((String) yearval[0]);
			String strYear2 = Helper.correctNull((String) yearval[1]);
			String strYear3 = Helper.correctNull((String) yearval[2]);
			String strYear4 = Helper.correctNull((String) yearval[3]);
			String strYear5 = Helper.correctNull((String) yearval[4]);

			String strYearStrt1 = Helper.correctNull((String) yearval_strt[0]);
			String strYearStrt2 = Helper.correctNull((String) yearval_strt[1]);
			String strYearStrt3 = Helper.correctNull((String) yearval_strt[2]);
			String strYearStrt4 = Helper.correctNull((String) yearval_strt[3]);
			String strYearStrt5 = Helper.correctNull((String) yearval_strt[4]);
		
		
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
			if (strFinType5.trim().equals("S")) {
				strFinType5 = Helper.correctNull((String) request.getParameter("type5"));
			}
			
			
			String strfintype = Helper.correctNull((String)hshValues.get("fintype"));
			String checkcol1= Helper.correctNull((String)hshValues.get("checkcol1"));
			String checkcol2= Helper.correctNull((String)hshValues.get("checkcol2"));
			String checkcol3= Helper.correctNull((String)hshValues.get("checkcol3"));
			String checkcol4= Helper.correctNull((String)hshValues.get("checkcol4"));
			String checkcol5= Helper.correctNull((String)hshValues.get("checkcol5"));
			String applicationno = "";
			
			applicationno = Helper.correctNull((String)request.getParameter("appno"));
	if(applicationno.equalsIgnoreCase(""))
	{
		applicationno = Helper.correctNull((String) hshValues.get("strAppNo"));

	}
		
	
		     ArrayList labeld_details=new ArrayList();
		     labeld_details=(ArrayList) hshValues.get("arr_labeldetails");
	    	  arrRowCIBIL=(ArrayList)(hshRecord.get("arrRowCIBIL"));
			  arrRowDefault = (ArrayList)hshRecord.get("arrRowDefault");  
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"><Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";	
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";


var labeldets = new Array();
var cma="<%=strfintype%>";

<%
if(labeld_details!=null)
{
	for(int i=0;i<labeld_details.size();i++)
	{
		
%>
labeldets[<%= i %>] = "<%=(String)labeld_details.get(i)%>";
	
<%
	}
}
%>

function callCalender(fname,lname)
{
	var val2=funfinancialYrCheck(lname,'N');
	if(val2==true)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
 			showCal("<%=ApplicationParams.getAppUrl()%>",fname);
		}
	}
}

function comboselect()
{
	document.forms[0].combo1.value ="<%=strFinType1%>";
	document.forms[0].combo2.value ="<%=strFinType2%>";
	document.forms[0].combo3.value ="<%=strFinType3%>";
	document.forms[0].combo4.value ="<%=strFinType4%>";
	document.forms[0].combo5.value ="<%=strFinType5%>";
}
function shownext(val)
{
	upto = <%=Integer.parseInt(Helper.correctInt((upto)))%>;
	page="<%=pageval%>";
	totcount=<%=totcount%>;
	fromnext=<%=Integer.parseInt(Helper.correctInt((fromnext)))%>;	
	if (val == "n")
	{
		if (upto == totcount)
		{
		from =1;
		}
		else
		{
			from = upto + 1;
		}
	}
	else if (val == "p")
	{
	     from = fromnext - 5;		
	}
	else if(val=="a")
	{
		from=upto+1;
	}
	document.forms[0].action=appURL+"action/financial.jsp?page="+page+"&from="+from;
	document.forms[0].hidBeanGetMethod.value="getRetailData";
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].submit();
}

function placeValues()
{	      
	disableFields(true);
	document.forms[0].combo1.disabled=true;
	document.forms[0].combo3.disabled=true;
	document.forms[0].combo2.disabled=true;
	document.forms[0].combo4.disabled=true;
	document.forms[0].combo5.disabled=true;			
		
	var sel_divID="<%=Helper.correctNull((String)hshValues.get("sel_divID"))%>";			
			
    var checkcol1="<%=checkcol1%>";
	var checkcol2="<%=checkcol2%>";
	var checkcol3="<%=checkcol3%>";
	var checkcol4="<%=checkcol4%>";
	var checkcol5="<%=checkcol5%>";

	var sno1="<%=Helper.correctNull((String)hshValues.get("sno1"))%>";
	var sno2="<%=Helper.correctNull((String)hshValues.get("sno2"))%>";
	var sno3="<%=Helper.correctNull((String)hshValues.get("sno3"))%>";
	var sno4="<%=Helper.correctNull((String)hshValues.get("sno4"))%>";
	var sno5="<%=Helper.correctNull((String)hshValues.get("sno5"))%>";

    
	 if((checkcol1!="") && (checkcol1==sno1)){
		 document.forms[0].printchk1.checked=true;
	      }else
		   {
			 document.forms[0].printchk1.checked=false;
		    }
	 if((checkcol2!="") && (checkcol2==sno2)){
		 document.forms[0].printchk2.checked=true;
	      }else
		   {
			 document.forms[0].printchk2.checked=false;
		    }
	 if((checkcol3!="") && (checkcol3==sno3)){
		 document.forms[0].printchk3.checked=true;
	      }else
		   {
			 document.forms[0].printchk3.checked=false;
		    }
	 if((checkcol4!="") && (checkcol4==sno4)){
		 document.forms[0].printchk4.checked=true;
	      }else
		   {
			 document.forms[0].printchk4.checked=false;
		    }
	 if((checkcol5!="") && (checkcol5==sno5)){
		 document.forms[0].printchk5.checked=true;
	      }else
		   {
			 document.forms[0].printchk5.checked=false;
		    }
}
function onCall()
{
	disableFields(true);
	
}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false);
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
	
}
function doDelete()
{
	var frm=document.forms[0];	
	if(frm.chk1.checked==false && frm.chk2.checked==false && frm.chk3.checked==false && frm.chk4.checked==false &&frm.chk5.checked==false)
	{
		alert("Please select the year you want to delete");
		return;
	}


	else
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].combo1.disabled=false;
			document.forms[0].combo2.disabled=false;	
			
			document.forms[0].hidAction.value="delete";
			
			document.forms[0].hidBeanId.value="financial";
	
			document.forms[0].hidBeanMethod.value="updateRetailData";
			document.forms[0].hidBeanGetMethod.value="getRetailData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/retailfin.jsp";
			document.forms[0].submit();

		 }
	}
}
function checkDesc()
{
	var len=document.forms[0].id.length.value;	
	for(var i=0;i<len;i++)
	{
		if (document.forms[0].type[i].value == "I")
		{
			var x="document.forms[0].desc"+i+".value";
			if (x == "")
			{
				var t = "document.forms[0].row"+id[i]+"c1".value
				t ="0.00"
			}
		}
	}
}
function doSave()
{
	 modifyCheck();
    var from=document.forms[0].fromnext.value;
	var frm=document.forms[0];
	
	  if((frm.txtyear1.value=="" || frm.txtyear1_start.value=="") && frm.combo1.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear1.focus();
		  return;
	  }
	  else if(frm.txtyear1.value!="" && frm.combo1.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo1.focus();
		  return;
	  }
	  if((frm.txtyear2.value=="" || frm.txtyear2_start.value=="") && frm.combo2.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear2.focus();
		  return;
	  }
	  else if(frm.txtyear2.value!="" && frm.combo2.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo2.focus();
		  return;
	  }
	  if((frm.txtyear3.value=="" || frm.txtyear3_start.value=="") && frm.combo3.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear3.focus();
		  return;
	  }
	  else if(frm.txtyear3.value!="" && frm.combo3.value=="S")
	  {
		  alert("Please SelectFinancial Type");
		  frm.combo3.focus();
		  return;
	  }
	  if((frm.txtyear4.value=="" || frm.txtyear4_start.value=="") && frm.combo4.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear4.focus();
		  return;
	  }
	  else if(frm.txtyear4.value!="" && frm.combo4.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo4.focus();
		  return;
	  }
	  if((frm.txtyear5.value=="" || frm.txtyear5_start.value=="") && frm.combo5.selectedIndex>0) 
	  {
		  alert("Please Enter Date ");
		  frm.txtyear5.focus();
		  return;
	  }
	  else if(frm.txtyear5.value!="" && frm.combo5.value=="S")
	  {
		  alert("Please Select Financial Type");
		  frm.combo5.focus();
		  return;
	  }
	  if (((frm.txtyear1.value=="" || frm.txtyear1_start.value=="")  && frm.combo1.value=="") &&			
				((frm.txtyear2.value=="" || frm.txtyear2_start.value=="") && frm.combo2.value=="")&&
				((frm.txtyear3.value=="" || frm.txtyear3_start.value=="") && frm.combo3.value=="")&&
				((frm.txtyear4.value=="" || frm.txtyear4_start.value=="") && frm.combo4.value=="")&&
				((frm.txtyear5.value=="" || frm.txtyear5_start.value=="") && frm.combo5.value==""))	
		    {
			  alert("Please Select Date and Financial Type atleast for one Financial Year");
			  frm.combo1.focus();
			  return;
		    }
	 
    	disableFields(false);
		document.forms[0].combo1.disabled=false;
		document.forms[0].combo2.disabled=false;
			
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="financial"
	    document.forms[0].hidapppage.value="true"
		document.forms[0].hidBeanMethod.value="updateRetailData";
		document.forms[0].hidBeanGetMethod.value="getRetailData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/retailfin.jsp?from="+from;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].submit();	
		
	 
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getRetailData";
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].action=appURL+"action/retailfin.jsp";	
		document.forms[0].submit();
	 }	
}
function doClose()
{
        if(ConfirmMsg(100))
	 {
		 window.close();
	 }
		
}
function getSection(modid)
{	
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	

	document.forms[0].hidcmasno.value=cma;
	document.forms[0].type1.value = document.forms[0].combo1.value;
	document.forms[0].type2.value = document.forms[0].combo2.value;
	document.forms[0].type3.value = document.forms[0].combo3.value;
	document.forms[0].type4.value = document.forms[0].combo4.value;
	document.forms[0].type5.value = document.forms[0].combo5.value;
	
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getRetailData";
	document.forms[0].action = appUrl+"action/retailfin.jsp";
	document.forms[0].submit();

}
function enableButtons(bool1,bool2,bool3,bool4)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool4;
}


function funfinancialYrCheck(obj,val1)
{
	var varVal=obj.value;
	if(varVal!="")
	{
		alert("You can't Modify the Date, Please delete the entire finanical for this year");
		if(val1=="Y")
		{
		window.event.returnValue = false;
		}else{
			return false;
		}
	}else{
		return true;
	}
}
function chkFinType(var1)
{
	if(var1 == 2)
	{
		var year1 = document.forms[0].txtyear1.value;
		var year2 = document.forms[0].txtyear1_start.value;
		var combo1 = document.forms[0].combo1.value;
		var combo2 = document.forms[0].combo2.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo2.value = "S";
			document.forms[0].combo2.focus();
		}
	}
	else if(var1 == 3)
	{
		var year1 = document.forms[0].txtyear2.value;
		var year2 = document.forms[0].txtyear2_start.value;
		var year3 = document.forms[0].txtyear3.value;
		var year4 = document.forms[0].txtyear3_start.value;
		var combo1 = document.forms[0].combo2.value;
		var combo2 = document.forms[0].combo3.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo3.value = "S";
			document.forms[0].combo3.focus();
		}
	}
	else if(var1 == 4)
	{
		var year1 = document.forms[0].txtyear3.value;
		var year2 = document.forms[0].txtyear3_start.value;
		var year3 = document.forms[0].txtyear4.value;
		var year4 = document.forms[0].txtyear4_start.value;
		var combo1 = document.forms[0].combo3.value;
		var combo2 = document.forms[0].combo4.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo4.value = "S";
			document.forms[0].combo4.focus();
		}
	}
	else if(var1 == 5)
	{
		var year1 = document.forms[0].txtyear4.value;
		var year2 = document.forms[0].txtyear4_start.value;
		var year3 = document.forms[0].txtyear5.value;
		var year4 = document.forms[0].txtyear5_start.value;
		var combo1 = document.forms[0].combo4.value;
		var combo2 = document.forms[0].combo5.value;

		if((year1+year2+combo1) == (year3+year4+combo2))
		{
			alert("Financial with same year and type is already available");
			document.forms[0].combo5.value = "S";
			document.forms[0].combo5.focus();
		}
	}

}
function modifyCheck()
{	
	var temp=0;
	<%
	ArrayList v1 = (ArrayList) hshValues.get("labeldetails");
	
	String col11 = "", col12 = "", col13 = "", col14 = "", col15 = "";
	String colval11 = "0";
	String colval12 = "0", colval13 = "0", colval14 = "0", colval15 = "0", strtype1 = "", selectdesc1 = "",selectdesc2 = "";
	int vecsize1 = 0, yearsize1 = 0, finsize1 = 0, startsize1 = 0;
	String colid1 = "", rowid1 = "";
	if (v1 != null) {
		vecsize1 = v1.size();
	}
	if (year1 != null) {
		yearsize1 = year1.size();
	}
	if (yearsize1 == vecsize1) {
		finsize1 = vecsize1;
	} else if (yearsize1 < vecsize1) {
		finsize1 = yearsize1;
	}
	if (finsize1 == 0) {
		finsize1 = vecsize1;
	}
	for (int l = 0; l < finsize1; l++) {
		g1 = (ArrayList) v1.get(l);
		colid1 = Helper.correctNull((String) g1.get(0));
		colid1 = colid1.trim();
		if (year1 != null) {
			rowid1 = Helper.correctDouble((String) vecid1.get(l));
			rowid1 = rowid1.trim();
			if (rowid1.equals(colid1)) {
				colval11 = Helper.correctDouble((String) year1
						.get(l));
			}else {
				colval11 = "0.00";
						} 
		}
		if (year2 != null) {
			rowid1 = Helper.correctDouble((String) vecid2.get(l));
			if (rowid1.equals(colid1)) {
				colval12 = Helper.correctDouble((String) year2
						.get(l));
			} else {
				colval12 = "0.00";
						}
		}
		if (year3 != null) {
			rowid1 = Helper.correctDouble((String) vecid3.get(l));
			if (rowid1.equals(colid1)) {
				colval13 = Helper.correctDouble((String) year3
						.get(l));
			}else {
				colval13 = "0.00";
						}
		}
		if (year4 != null) {
			rowid1 = Helper.correctDouble((String) vecid4.get(l));
			if (rowid1.equals(colid1)) {
				colval14 = Helper.correctDouble((String) year4
						.get(l));
			} else {
				colval14 = "0.00";
						}
		}
		if (year5 != null) {
			rowid1 = Helper.correctDouble((String) vecid5.get(l));
			if (rowid1.equals(colid1)) {
				colval15 = Helper.correctDouble((String) year5
						.get(l));
			} else {
				colval15 = "0.00";
						}
		}
	
		
		col11 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c1";
		col12 = "row" + Helper.correctNull((String) g1.get(0))
				+ "c2";
		col13 = "row" + Helper.correctNull((String) g1.get(0))
		+ "c3";
        col14 = "row" + Helper.correctNull((String) g1.get(0))
		+ "c4";
        col15 = "row" + Helper.correctNull((String) g1.get(0))
		+ "c5";
		strtype1 = Helper.correctNull((String) g1.get(2));

	%>
	<%if(!strtype1.equalsIgnoreCase("C")){%>
		if(document.forms[0].<%=col11%>.value!=<%=nf.format(Double.parseDouble(colval11))%>){temp++;}
		if(document.forms[0].<%=col12%>.value!=<%=nf.format(Double.parseDouble(colval12))%>){temp++;}
		if(document.forms[0].<%=col13%>.value!=<%=nf.format(Double.parseDouble(colval13))%>){temp++;}
		if(document.forms[0].<%=col14%>.value!=<%=nf.format(Double.parseDouble(colval14))%>){temp++;}
		if(document.forms[0].<%=col15%>.value!=<%=nf.format(Double.parseDouble(colval15))%>){temp++;}
	<%}}
	%>

	if(document.forms[0].combo1.value!=document.forms[0].old_combo1.value){	temp++;}
	if(document.forms[0].combo2.value!=document.forms[0].old_combo2.value){	temp++;}
	if(document.forms[0].combo3.value!=document.forms[0].old_combo3.value){	temp++;}
	if(document.forms[0].combo4.value!=document.forms[0].old_combo4.value){	temp++;}
	if(document.forms[0].combo5.value!=document.forms[0].old_combo5.value){	temp++;}

	
	if(document.forms[0].txtyear1_start.value!=document.forms[0].old_txtyear1_start.value){	temp++;}
	if(document.forms[0].txtyear2_start.value!=document.forms[0].old_txtyear2_start.value){	temp++;}
	if(document.forms[0].txtyear3_start.value!=document.forms[0].old_txtyear3_start.value){	temp++;}
	if(document.forms[0].txtyear4_start.value!=document.forms[0].old_txtyear4_start.value){	temp++;}
	if(document.forms[0].txtyear5_start.value!=document.forms[0].old_txtyear5_start.value){	temp++;}
	
	
	
	if(document.forms[0].txtyear1.value!=document.forms[0].old_txtyear1.value){	temp++;}
	if(document.forms[0].txtyear2.value!=document.forms[0].old_txtyear2.value){	temp++;}
	if(document.forms[0].txtyear3.value!=document.forms[0].old_txtyear3.value){	temp++;}
	if(document.forms[0].txtyear4.value!=document.forms[0].old_txtyear4.value){	temp++;}
	if(document.forms[0].txtyear5.value!=document.forms[0].old_txtyear5.value){	temp++;}


if(temp>0){document.forms[0].hidChangeFlag.value="Y";}
else{document.forms[0].hidChangeFlag.value="N";}

}



</script>
</head>
<body onLoad="onCall();comboselect();placeValues();checkDesc();modifyCheck();">
<form method="post" class="normal">



<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

			<tr>
				<td>
				<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   if(str1.equals(strCurModule))
				   {
				   strClass="sub_tab_active";
				  }
				  else
				  {
				  strClass="sub_tab_inactive";
				   }				   
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				  <%if (str1.equals(strCurModule)) {%> 
				  <b><%=Helper.correctNull((String) vecVal.get(0))%></b>
								<%} else {%> 
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%}

						if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}
					
				}%>
				</td>
								<%}%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		
				

						
			
					<%
					ArrayList v = (ArrayList) hshValues.get("labeldetails");
				
			String col1 = "", col2 = "", col3 = "", col4 = "", col5 = "";
			String  colval1 = "";
			String colval2 = "", colval3 = "", colval4 = "", colval5 = "", strtype = "", selectdesc = "";
			int vecsize = 0,  yearsize = 0, finsize = 0, startsize = 0;
			String colid = "", rowid = "";
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
			if (finsize == 0) {
				finsize = vecsize;
			}
			
			List<String> list =new ArrayList();
			Double AmtValue =  Double.parseDouble(hshValues.get("apploamamt").toString());
		   if(AmtValue>=5000001 && AmtValue<=10000000){
				    String strPrevCusID="",strCheifpro="";int j=0,k=1,x=0;
				   int arrSize=arrRowCIBIL.size()+1;
				   for(int i=0;i<arrRowCIBIL.size();i++) {
				   	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
				   	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
				   	{
				   		continue;
				   	}
				   	else
				   	{
				   		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
				   		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
				   	}j=j+1;
				    if(strCheifpro.equalsIgnoreCase("Y")){
				   		j=j+1;k=k+1;
				   %>
				    <table width="100%" border="1" cellspacing="0" cellpadding="4" align="center">
				   	 <tr class="datagrid">
						<td align="center" width="20%"><b>Particular</b></td>
						<td align="center" width="30%" colspan="4"><b>Input</b></td>
					</tr>
				   <tr class="datagrid">
				   		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
				   		<td align="center" width="20%" ><b>Promoter Name</b></td>
				   		<td align="center" width="10%">CIBIL Refered</td>
				   	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
				   		
				   </tr>
				   <tr class="datagrid">
				   		<td align="center" width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
				   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
				   		<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
				   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
				   		<%}else{ %>
				   			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
				   		<%} %>
				   </tr>
				   <%}}}%>
			   </table>
			   
			   
			    <table width="100%" border="1" cellspacing="0" cellpadding="4" align="center">
			 <% if(AmtValue>=10000001){ %>
			   
<tr class="datagrid">
		<td align="center" width="20%"><b>Particular</b></td>
		<td align="center" width="30%" colspan="4"><b>Input</b></td>
	</tr>

	<tr class="datagrid">
		<td align="center" width="20%">Is any of the Promoter(s)/Directors/Key management personnel in the CRILC/CIBIL/RBI list of defaulters ?</td>
		
<td align="center" width="30%" colspan="3">
	<table width="100%" align="center">
	<tr class="datagrid">
		<%if(Helper.correctNull((String) hshValues.get("CG_DEFAULTER")).equalsIgnoreCase("Y")){ %>
			<td align="center" width="15%">Yes</td>
			<%}else{ %>
			<td align="center" width="15%">No</td>
			<%} %>
		</tr>
	</table>
</td>
	</tr>
	
	
	<% String strPrevCusID="",strCheifpro=""; int j=0,k=1,x=0;
 int arrSize=arrRowCIBIL.size()+1;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
	}j=j+1;
	%>
	<%
	  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
	 {%>
	 <tr class="datagrid">
		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
		<td align="center" width="20%" ><b>Promoter Name</b></td>
		<td align="center" width="10%">CIBIL Refered</td>
	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
		
</tr>

	<tr class="datagrid">
			<td width="20%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
			<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
		<%}else{ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
		<%} %>
		</tr>
		<%}else{ %>	
	<% if(!strCheifpro.equalsIgnoreCase("Y")){
		j=j+1;k=k+1;
%>
<tr class="datagrid">
		<td align="center" width="30%" rowspan="2">Credit bureau score of promoter <%=j%> & credit bureau name</td>
		<td align="center" width="20%" ><b>Promoter Name</b></td>
		<td align="center" width="10%">CIBIL Refered</td>
	    <td align="center" width="15%" ><b>CIBIL Score</b></td>
		
</tr>
<tr class="datagrid">
		<td align="center" width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
		<%if(!Helper.correctNull((String)arrColCIBIL.get(4)).equalsIgnoreCase("")){ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
		<%}else{ %>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%></td>
		<%} %>
</tr>
<%}}}%>

<!-- Added for Experian Score -->
<%
int f=1;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
		f++;
	}
}
%>

<%
	  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
	 {
		  arrSize=f+1;
			 strPrevCusID="";strCheifpro=""; j=0;
%>
<tr class="datagrid">
<td align="center" width="30%" rowspan=<%=arrSize%>>Experian Commercial score (if available,else put NA)</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>Commercial score</b></td>
</tr>
<%
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
	   continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
	}j=j+1;
%>
<tr class="datagrid">
	<td align="center" width="20%"><%=j%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<% if(!Helper.correctNull((String)arrColCIBIL.get(17)).equalsIgnoreCase(""))
			{
		%>
		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(17))%></td>

		<%} else {%>
		<td width="14%" align="center">NA</td>
		<%} %>
	
</tr>
<%}}%>
<tr></tr> 
<tr></tr> 
<!-- end -->

	<tr class="datagrid">
		<td align="center" width="30%">Networth of the key Promoter Or borrower</td>
		
		<%if(!Helper.correctNull((String) hshRecord.get("PERAPP_NETWORTH")).equalsIgnoreCase(""))
		{
		%>
		<td width="14%" colspan="3" align="center"><%=Helper.correctNull((String) hshRecord.get("PERAPP_NETWORTH"))%> </td>
        <%} else {%>
		<td width="14%" colspan="3"  align="center">Not Available</td>
		<%} %>	
	</tr>

	<tr class="datagrid">
		<td align="center" width="30%">Promoter's contribution in the entity (in % terms)</td>
		<% if(!Helper.correctNull((String) hshRecord.get("CG_TC_PROMOTERS")).equalsIgnoreCase(""))
			{
		%>
		<td width="14%" colspan="3" align="center"><%=Helper.correctNull((String) hshRecord.get("CG_TC_PROMOTERS")) %>&nbsp;%</td>
		<%} else {%>
		<td width="14%" colspan="3" align="center">Not Available</td>
		<%}%>
	</tr>
	<%-- <!-- start -->
	<%
			  if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
			 {
	 strPrevCusID="";strCheifpro="";
		 arrSize=arrRowCIBIL.size()+1;
		for(int i=0;i<arrRowCIBIL.size();i++) 
		{
			arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
			if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
			{
				continue;
			}
			else
			{
				strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
				strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
			}j=j+1;
			if(!strCheifpro.equalsIgnoreCase("Y")){
				j=j+1;
				//k=k+1;
		%>
	<tr class="datagrid">
<td align="center" width="30%" rowspan=<%=arrSize%>>Group/associate entities of promoter(s) have been into NPA category in past 1 year</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>NPA Category</b></td>
</tr>
<%for(i=0;i<arrRowCIBIL.size();i++) {
	x=i+1;
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);%>
	<tr class="datagrid">
	<td align="center" width="20%"><%=x%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<%if(!Helper.correctNull((String)arrColCIBIL.get(15)).equalsIgnoreCase(""))
		{%>

		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(15))%></td>
		<%} else {%>
		<td width="14%" align="center"></td>
					<%} %>
	
</tr>
<%} }}}%>
	<!-- end --> --%>
	<%
 f=1;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
		strCheifpro = Helper.correctNull((String)arrColCIBIL.get(14));	
		f++;
	}
}
%>

<%
	  if(!strCheifpro.equalsIgnoreCase("Y"))
	 {
		  arrSize=f+1;
			 strPrevCusID="";strCheifpro=""; j=0;
%>
<tr class="datagrid">
<td align="center" width="30%" rowspan=<%=arrSize%>>Group/associate entities of promoter(s) have been into NPA category in past 1 year</td>
<td align="center" width="20%" ><b>Promoter Sno</b></td>
<td align="center" width="15%" ><b>Promoter Name</b></td>
<td align="center" width="15%" ><b>NPA Category</b></td>
</tr>
<% //out.print("arrRowCIBIL.size()"+arrRowCIBIL.size());
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
	   continue;
	   
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));	
	}j=j+1;
%>
<tr class="datagrid">
	<td align="center" width="20%"><%=j%></td>
	<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<% if(!Helper.correctNull((String)arrColCIBIL.get(15)).equalsIgnoreCase(""))
			{
		%>
		<td align="center" width="15%"><%=Helper.correctNull((String)arrColCIBIL.get(15))%></td>

		<%} else {%>
		<td width="14%" align="center"> </td>
		<%} %>
	
</tr>
<%}}%>
 <tr></tr> 
<tr></tr>
	<tr class="datagrid">
		
		<td align="center" width="30%">Promoter's experience in current/related business (in years)</td>
			<%if(!Helper.correctNull((String) hshRecord.get("PEREMP_EXPINYRS")).equalsIgnoreCase(""))
		{%>

		<td width="14%" colspan="3" align="center"><%=Helper.correctNull((String) hshRecord.get("PEREMP_EXPINYRS"))%> </td>
		<%} else {%>
		<td width="14%" colspan="3" align="center">Not Available</td>
					<%} %>
	</tr>

</table>
			<%}  %>
	
		</table>



<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">

			<tr>
				<td>
				<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><% pflag = false;
			 base_year = false;
			//int strWidth;
			//int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   if(str1.equals(strCurModule))
				   {
				   strClass="sub_tab_active";
				  }
				  else
				  {
				  strClass="sub_tab_inactive";
				   }				   
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				  <%if (str1.equals(strCurModule)) {%> 
				  <b><%=Helper.correctNull((String) vecVal.get(0))%></b>
								<%} else {%> 
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%}

						if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}
					
				}%>
				</td>
								<%}%>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor">
				<tr class="dataheader">
				<td align="Left" colspan="15"><b>All Values are in Rupees</b>&nbsp;</td>
				</tr>
					<tr class="dataheader">
						<td colspan="4" align="left"><b>&nbsp;Starting period of financial</b></td>
						<td colspan="2" width="14%" align="center"><input type="text" name="txtyear1_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt1%>"
							onBlur="checkDate(txtyear1_start);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear1_start',document.forms[0].txtyear1_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td colspan="2" width="13%" align="center" colspan="3"><input type="text" name="txtyear2_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt2%>"
							onBlur="checkDate(txtyear2_start);checkmindate(this,document.forms[0].txtyear1_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear2_start',document.forms[0].txtyear2_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
							<td width="14%" align="center"><input type="text" name="txtyear3_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt3%>"
							onBlur="checkDate(txtyear3_start);checkmindate(this,document.forms[0].txtyear2_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear3_start',document.forms[0].txtyear3_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
							<td width="14%" align="center"><input type="text" name="txtyear4_start"
							size="13" maxlength="12"  border="1"
							 value="<%=strYearStrt4%>"
							onBlur="checkDate(txtyear4_start);checkmindate(this,document.forms[0].txtyear3_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear4_start',document.forms[0].txtyear4_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
						<td width="13%" align="center"><input type="text" name="txtyear5_start"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value="<%=strYearStrt5%>"
							onBlur="checkDate(txtyear5_start);checkmindate(this,document.forms[0].txtyear4_start.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear5_start',document.forms[0].txtyear5_start);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>	
					
						
												
					</tr>
					<tr class="dataheader">
						<td colspan="4" align="left"><b>&nbsp;End period of financial</b></td>
						<td colspan="2" width="14%" align="center"><input type="text" name="txtyear1"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear1%>"
							onBlur="checkDate(txtyear1);checkmindate(this,document.forms[0].txtyear1_start.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear1',document.forms[0].txtyear1);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno1" value="1"></td>
						<td colspan="2" width="13%" align="center" colspan="3"><input type="text" name="txtyear2"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear2%>"
							onBlur="checkDate(txtyear2);checkmindate(this,document.forms[0].txtyear1.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear2',document.forms[0].txtyear2);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno2" value="2"></td>
							
							<td width="14%" align="center"><input type="text" name="txtyear3"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear3%>"
							onBlur="checkDate(txtyear3);checkmindate(this,document.forms[0].txtyear2.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear3',document.forms[0].txtyear3);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno3" value="3"></td>
						<td width="14%" align="center"><input type="text" name="txtyear4"
							size="13" maxlength="12"  border="1"
							 value="<%=strYear4%>"
							onBlur="checkDate(txtyear4);checkmindate(this,document.forms[0].txtyear3.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear4',document.forms[0].txtyear4);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno4" value="4"></td>
						<td width="13%" align="center"><input type="text" name="txtyear5"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value="<%=strYear5%>"
							onBlur="checkDate(txtyear5);checkmindate(this,document.forms[0].txtyear4.value)" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> <a
							alt="Select date from calender"
							href="javascript:callCalender('txtyear5',document.forms[0].txtyear5);"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a><input type="hidden" name="strsno5" value="5"></td>
						
						
						
					</tr>
					<tr class="dataheader">
						<td colspan="4">&nbsp;</td>
						<td colspan="2" width="14%"  align="center"><select name="combo1" >
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td colspan="2" width="14%" align="center"><select name="combo2" onChange="chkFinType(2)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo3" onChange="chkFinType(3)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo4" onChange="chkFinType(4)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>

						<td width="13%" align="center"><select name="combo5" onChange="chkFinType(5)">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						
					</tr>
					<tr class="datagrid">
						<td colspan="4">&nbsp;<span class="mantatory"><b>For Deleting F.Y. click
						in the box and press delete button</b></span></td>
						<td colspan="2" width="14%" align="center"><input type="checkbox" name="chk1"
							value="y1" style="border-style:none"></td>
						<td colspan="2"  width="13%" align="center"><input type="checkbox" name="chk2"
							value="y2" style="border-style:none"></td>
							<td width="14%" align="center"><input type="checkbox" name="chk3"
							value="y3" style="border-style:none"></td>
						<td width="14%" align="center"><input type="checkbox" name="chk4"
							value="y4" style="border-style:none"></td>
						<td width="13%" align="center"><input type="checkbox" name="chk5"
							value="y5" style="border-style:none"></td>
					
					</tr>
					
					<tr class="datagrid">
						<td colspan="4">&nbsp;<span class="mantatory"><b>Select the Check box to print 
                    the financial year</b></span></td>
						<td colspan="2" width="14%" align="center"><input type="checkbox" name="printchk1"
							value="p1" style="border-style:none"></td>
						<td colspan="2"  width="13%" align="center"><input type="checkbox" name="printchk2"
							value="p2" style="border-style:none"></td>
							 <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk3"
							value="p3" style="border-style:none">
                  </td>
                  <td width="16%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk4"
							value="p4" style="border-style:none">
                  </td>
                  <td width="15%" align="center" HEIGHT="22">
                    <input type="checkbox" name="printchk5"
							value="p5" style="border-style:none">
                  </td>
					</tr>
			
					<%
					
	    	if (v != null) {
				vecsize = v.size();
				finsize = vecsize;
			}
			if (year1 != null) {
				yearsize = year1.size();
			}
			
			if (yearsize == vecsize) {
				finsize = vecsize;			
			
			} else if (yearsize < vecsize) {
				finsize = yearsize;
				
			}
			if (finsize == 0) {
				finsize = vecsize;
			}
			%>
			
			  
			   <%
				for(int l=0;l<VecRow.size();l++)
				{
					VecCol=(ArrayList)VecRow.get(l);
			    %>
			     <tr class="datagrid">
			     
			     <td colspan="4"><%=VecCol.get(1) %></td>
		  
		<%
			
				g1 = (ArrayList) v.get(l);
				colid = Helper.correctNull((String) g1.get(0));
				colid = colid.trim();
				
				if (year1 != null) {
					rowid = Helper.correctDouble(Helper.correctDouble((String) vecid1.get(l)));
					
					if (rowid.equals(colid)) {
						colval1 = Helper.correctDouble(Helper.correctDouble((String) year1.get(l)));
					} else {
						colval1 = "0.00";
					}
				} else {
					colval1 = "0.00";
				}
				if (year2 != null) {
					rowid = Helper.correctDouble(Helper.correctDouble((String) vecid2.get(l)));
					
					if (rowid.equals(colid)) {
						colval2 = Helper.correctDouble(Helper.correctDouble((String) year2.get(l)));
					} else {
						colval2 = "0.00";
					}
				} else {
					colval2 = "0.00";
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
				if (year5 != null) {
					rowid = Helper.correctDouble((String) vecid5.get(l));
					if (rowid.equals(colid)) {
						colval5 = Helper.correctDouble((String) year5.get(l));
					} else {
						colval5 = "0.00";
					}
				} else {
					colval5 = "0.00";
				}
				
				col1 = "row" + Helper.correctNull((String) g1.get(0)) + "c1";
				col2 = "row" + Helper.correctNull((String) g1.get(0)) + "c2";
				col3 = "row" + Helper.correctNull((String) g1.get(0)) + "c3";
				col4 = "row" + Helper.correctNull((String) g1.get(0)) + "c4";
				col5 = "row" + Helper.correctNull((String) g1.get(0)) + "c5";
				
			
				
				selectdesc = "desc" + Helper.correctNull((String) g1.get(0));
				strtype = Helper.correctNull((String) g1.get(2));
				
				%>
				
						
						
						<td width="14%" align="center" colspan="2">
					<input type="hidden" name="id" value="<%=Helper.correctNull((String)g1.get(0))%>"> 
						<input type="hidden" name="type" value="<%=Helper.correctNull((String)g1.get(1))%>"> 
						
						
						<input type="text" name="<%=col1%>" size="13" style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=nf.format(Double.parseDouble(colval1))%>" onKeyPress="allowNegtiveNumber(this)"> 		
					</td>
		
					
						<td width="13%" align="center" >
						<input type="text" name="<%=col2%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval2))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							</td>
							<td width="13%" align="center" colspan="2">
						<input type="text" name="<%=col3%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval3))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							</td>
							<td width="13%" align="center" colspan="1">
						<input type="text" name="<%=col4%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval4))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							</td>
							<td width="13%" align="center" colspan="1">
						<input type="text" name="<%=col5%>" size="13"
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value='<%=nf.format(Double.parseDouble(colval5))%>'
							onKeyPress="allowNegtiveNumber(this)"> 
							</td>
						
						
					</tr>
					<%}%>
				</table>
				</td>
			</tr>
			 </table>
		

<br>
			
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
			<tr>
				
				<td align="center"><br>
			<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
			</td>	
				
			</tr>			
		</table>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="totvalue" value="<%=totcount%>"> 
<input type="hidden" name="uptovalue" value="<%=upto%>"> 
<input type="hidden" name="fromvalue" value="<%=Integer.parseInt(Helper.correctInt((upto))) + 1%>"> 
<INPUT TYPE="hidden" value="<%=pageval%>" name="pageval"> 
<INPUT TYPE="hidden" value="10" name="hidTotal"> 
<input type="hidden" name="otherGenTable"> 
<input type="hidden" name="hidPageName" value="financial.jsp"> 
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 
<input type="hidden" name="type1"> 
<input type="hidden" name="type2"> 
<INPUT TYPE="hidden" NAME="hidapppage">
<INPUT TYPE="hidden" NAME="hidfinanceid">
<INPUT TYPE="hidden" NAME="hidfinance">
<INPUT TYPE="hidden" NAME="hidcmasno">  

 <input type="hidden" name="app_no"  value="<%=applicationno%>">

<INPUT TYPE="hidden" NAME="hidsel_divID"> 
<input type="hidden" name="p_checkflag" value="<%=pflag%>"> 
<input type="hidden" name="BaseYearFlag" value="<%=base_year%>"> 
<INPUT TYPE="hidden" name="fromnext" value="<%=Helper.correctNull((String)hshValues.get("from"))%>">
<input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
<input type="hidden" name="fin_name" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
<INPUT TYPE="hidden" name="hidppid" value="<%=Helper.correctNull((String)hshValues.get("finappid"))%>">
 <input type="hidden" name="old_txtyear1_start" value="<%=strYearStrt1 %>">
<input type="hidden" name="old_txtyear2_start" value="<%=strYearStrt2 %>">
<input type="hidden" name="old_txtyear3_start" value="<%=strYearStrt3 %>">
<input type="hidden" name="old_txtyear4_start" value="<%=strYearStrt4 %>"> 
<input type="hidden" name="old_txtyear5_start" value="<%=strYearStrt5 %>">


<input type="hidden" name="old_txtyear1" value="<%=strYear1 %>"> 
<input type="hidden" name="old_txtyear2" value="<%=strYear2 %>"> 
<input type="hidden"name="old_txtyear3" value="<%=strYear3 %>"> 
<input type="hidden" name="old_txtyear4" value="<%=strYear4 %>"> 
<input	type="hidden" name="old_txtyear5" value="<%=strYear5 %>"> 


<input type="hidden" name="old_combo1" value="<%=strFinType1 %>">
 <input type="hidden" name="old_combo2" value="<%=strFinType2 %>"> 
 <input type="hidden" name="old_combo3" value="<%=strFinType3 %>"> 
<input type="hidden" name="old_combo4" value="<%=strFinType4 %>">
<input type="hidden" name="old_combo5" value="<%=strFinType5 %>"> 


<input	type="checkbox" name="old_ratingchk1" style="display: none;"> 
<input type="checkbox" name="old_ratingchk2" style="display: none;"> 
<input type="checkbox" name="old_ratingchk3" style="display: none;">
 <input type="checkbox" name="old_ratingchk4" style="display: none;"> 
 <input type="checkbox" name="old_ratingchk5" style="display: none;">
<input type="hidden" name="hidChangeFlag" value="N"> 

<input type="hidden" name="hidSessionModuleType" value="<%=strSessionModuleType %>"> 


	  
</form>
</body>
<script>
var tagFlag="<%=tagFlag%>";
var strCurModule ="<%=strCurModule%>";

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}

//added for disabling the textbox and combo box
if(tagFlag == strCurModule)
{		
	document.forms[0].txtyear1.readOnly = false;
	document.forms[0].txtyear2.readOnly = false;
	document.forms[0].txtyear3.readOnly = false;
	document.forms[0].txtyear4.readOnly = false;
	document.forms[0].txtyear5.readOnly = false;
	document.forms[0].combo1.disabled=false;
	document.forms[0].combo3.disabled=false;
	document.forms[0].combo2.disabled=false;
	document.forms[0].combo4.disabled=false;
	document.forms[0].combo5.disabled=false;
}
else
{
//	document.forms[0].fromvalue.value ="0";
	document.forms[0].txtyear1.readOnly = true;
	document.forms[0].txtyear2.readOnly = true;
	document.forms[0].txtyear3.readOnly = true;
	document.forms[0].txtyear4.readOnly = true;
	document.forms[0].txtyear5.readOnly = true;
	document.forms[0].combo1.disabled=true;
	document.forms[0].combo3.disabled=true;
	document.forms[0].combo2.disabled=true;
	document.forms[0].combo4.disabled=true;
	document.forms[0].combo5.disabled=true;
}
}

	</script>
</html>

                                                                                  