
<%@ page import="java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>Products</title>
<%
//out.println("******************"+hshValues);
%>
<script language="JavaScript">

<%
	String form_type = request.getParameter("form_type");

	//out.println(hshValues);

	HashMap hshTermLoan = (HashMap)hshValues.get("interestindex_tl");
	HashMap hshWorkingCapital = (HashMap)hshValues.get("interestindex_wc");
	
	ArrayList vecLabel = (ArrayList)hshTermLoan.get("vecValues1");
	ArrayList vecRatio = (ArrayList)hshTermLoan.get("vecValues2");

	boolean flag = vecLabel.removeElement(new String(""));
		
	int len = vecLabel.size();
	//System.out.println("var arrtl = new Array("+len+");");
	//System.out.println("var arrtlval = new Array("+len+");");

	for(int i=0;i<len;i++)
	{
		//System.out.println("arrtl["+i+"] = '"+vecLabel.get(i)+"';");
		//System.out.println("arrtlval["+i+"] = '"+vecRatio.get(i)+"';");
	}

	vecLabel = (ArrayList)hshWorkingCapital.get("vecValues3");
	vecRatio = (ArrayList)hshWorkingCapital.get("vecValues4");
	
	flag = vecLabel.removeElement(new String(""));
	
	len = vecLabel.size();
	out.println("var arrwc = new Array("+len+");");
	out.println("var arrwcval = new Array("+len+");");
	
	for(int i=0;i<len;i++)
	{%>
	var varArrVal='<=vecLabel.get(i)>';
//	alert(varArrVal+"second");
	<%
		out.println("arrwc["+i+"] = '"+vecLabel.get(i)+"';");
		out.println("arrwcval["+i+"] = '"+vecRatio.get(i)+"';");
	}
%>

	var type = '<%= form_type %>';
	
	function setData()
	{

		alert(type);
		if(type == 'Commercial/Term Loan' || type == 'Retail')
		{
			document.inttypefrm.prdint.options[0] = new Option('Products Defined','Products Defined');
			//alert(arrtl.length);
			for(i=1;i<=arrtl.length;i++)
			{
					document.inttypefrm.prdint.options[i] = new Option(arrtl[i-1],arrtl[i-1]);
			}
		}
		else if(type == 'Commercial/Working Capital')
		{
			//alert(arrwc.length);
			for(i=0;i<arrwc.length;i++)
			{
				document.inttypefrm.prdint.options[i] = new Option(arrwc[i],arrwc[i]);
			}
		}
		
		else if(type == 'Personal Loan')
		{
			//alert(type);
			//alert(arrwc.length);
			for(i=0;i<arrwc.length;i++)
			{
//				alert(arrwc[i]+"     "+arrwc[i]);
				
				document.inttypefrm.prdint.options[i] = new Option(arrwc[i],arrwc[i]);
				//document.inttypefrm.prdint.options[i].value = "DATA";
				//alert(document.inttypefrm.prdint.options[i].value);
			}
		}
	}

	function onClickOK()
	{
		var ind = document.inttypefrm.prdint.selectedIndex;
		if(ind == -1)
		{
			alert("Select Interest type");
		}
		else
		{
			var val = document.inttypefrm.prdint.options[ind].value;
			window.opener.document.prdinterestfrm.prd_inttype.value=val;
			if(val=='Products Defined')
			{
				window.opener.document.prdinterestfrm.intrlabel.value = "Products Defined %";
				window.opener.document.prdinterestfrm.prd_intrate.value = '';
				window.opener.document.prdinterestfrm.prd_intrate.disabled=false;
				window.opener.document.prdinterestfrm.prd_intrate.readOnly=false;
				window.opener.document.prdinterestfrm.prd_intrate.focus();
				window.opener.document.prdinterestfrm.prd_intrate.value = "";
				window.opener.document.prdinterestfrm.prd_addlint.value = "";
				window.opener.document.prdinterestfrm.prd_totalint.value = "";
			}
			else
			{
				if(type == 'Commercial/Term Loan' || type == 'Retail')
				{
				window.opener.document.prdinterestfrm.prd_intrate.value=arrtlval[ind-1];
				}
				else if(type == 'Commercial/Working Capital')
				{
					window.opener.document.prdinterestfrm.prd_intrate.value=arrwcval[ind];
				}
				window.opener.document.prdinterestfrm.intrlabel.value = "Index Rate %";
				window.opener.document.prdinterestfrm.prd_intrate.disabled = true;
				window.opener.document.prdinterestfrm.prd_addlint.value = "";
				window.opener.document.prdinterestfrm.prd_totalint.value = "";
				window.opener.document.prdinterestfrm.prd_addlint.focus();
			}
		this.close();
		}
		
	}

	function onClickCancel()
	{
		this.close();
	}

	
</script>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
-->
</style>
</head>

<body bgcolor="#EEEAE3" text="#000000" onLoad="setData()">
<form name="inttypefrm" method="post" action="" size="10">
    <table width="45%" border="0" cellspacing="0" cellpadding="1" align="center" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center">
          <tr> 
            <td height="20" bgcolor="#71694F"> 
              <div align="left"><font color="#FFFFFF" size=2><b><font face="MS Sans Serif" size="1">Select 
                Interest Type</font></b></font></div>
            </td>
          </tr>
          <tr> 
            <td height="7"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="4" height="2"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td colspan="10"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="67">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4">
                                  <tr> 
                                    <td colspan="2"> 
                                      <div align="center"> 
                                        <select size="10" name="prdint" style="width:250" onDblClick="onClickOK()">								 
                                        </select>
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="50%"> 
                                      <div align="right">
                                        <input type="button" name="btn_ok" value="OK" onClick="onClickOK()" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" >
                                      </div>
                                    </td>
                                    <td width="50%"> 
                                      <div align="left"> 
                                        <input type="button" name="btn_cancel" value="Close" onClick="onClickCancel()" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold">
                                      </div>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <p>&nbsp; </p>

	<input type=hidden name="hidBeanId" value="setinterest" >
	<input type=hidden name="hidBeanGetMethod" value="getInterests">
	
</form>
</body>
</html>
