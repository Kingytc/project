<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%

//out.print(hshValues);
%>

<Script>	
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var sno;
var finance_id;
function selectValues(slno,financeid)
{
	//alert(slno);

	
	window.opener.document.forms[0].hidcmasno.value=slno;
sno=slno;
finance_id=financeid;
window.opener.document.forms[0].hidfinance.value=financeid;
	

	
}

	function doclose()
	{
		var radio_count=0;
		var check_count=0;

		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			 if(document.forms[0].elements[i].type=="radio")
				{
				 radio_count=radio_count+1;
				}
		}
		
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
		 if(document.forms[0].elements[i].type=="radio")
			{


				if(document.forms[0].elements[i].checked==false)
				{	
				
				check_count=check_count+1;	  
			}
			}
		}

	
		if(check_count==radio_count)
		{
      alert("Please select Financial Format");
      return false;
		}
		else
		{

  
		window.opener.document.forms[0].hidBeanId.value="financial";
	
		window.opener.document.forms[0].hidBeanGetMethod.value="updateAttachData";
		window.opener.document.forms[0].action = appUrl+"action/financial.jsp";
		window.opener.document.forms[0].submit();
		window.close();



		}
	}


	function docancel()
	{
		if(ConfirmMsg(102))
		{
			for(var i=0;i<document.forms[0].elements.length;i++)
			{
			 if(document.forms[0].elements[i].type=="radio")
				{
					document.forms[0].elements[i].checked=false;		  
				}
			}
			window.close();
		}
	}


</script>
	
<html>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">

<form name="frmcma" method="post">
  <br>
  <br>
  <br>
 
  <table width="86%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable border1" >
    <tr> 
      <td> 
     <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
					<tr class="dataheader">
            <td colspan="5" align="center"><b>Financial Format Selection</b></td>
          
          </tr>
          
          <%  		
          String g1 =  "",g2="",g3="",cma="",g4="";   	
                 
                  ArrayList arrcmavalcma = (ArrayList) hshValues.get("arrcmavalcma");
                  ArrayList arrcmavalRowdesc = (ArrayList) hshValues.get("arrcmavalRowdesc");
                  ArrayList arrcmavalRowdate = (ArrayList) hshValues.get("arrcmavalRowdate");
                  ArrayList arrcmavalfinanceid = (ArrayList) hshValues.get("arrcmavalfinanceid");
                  
							if(arrcmavalcma!=null)
							{	
								
								int arrsize =arrcmavalcma.size();
								for(int l=0;l<arrsize;l++)
								{	
									g1 = (String)arrcmavalRowdate.get(l);
									g2 = (String)arrcmavalcma.get(l);
									g3 = (String)arrcmavalRowdesc.get(l);
									g4 = (String)arrcmavalfinanceid.get(l);
									%>
          <tr  class="datagrid"> 
            <td width="3%"> 
              <input type="radio" name="cma_no"  style="border-style:none" onClick="selectValues('<%=g2%>','<%=g4%>')" >
            </td>
            <td width="5%">&nbsp;<%=l+1%></td>
            <td width="30%"   nowrap>&nbsp;<%=g3%></td>
            <td colspan="2" nowrap align="center">&nbsp;<%=g1%> </td>
          </tr>
          <%
                    				}
								}
							
								 %>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table border="0" cellspacing="0" cellpadding="0" class="outertable border1"  align="center">
    <tr> 
      <td> 
        <table width="43%" border="0" cellspacing="0" cellpadding="1">
          <tr valign="top"> 
           
           
            <td> 
              <input type="button" name="cmdClose" value="OK" onClick="doclose()"class="buttonstyle">
            </td>
             <td> 
              <input type="button" name="cmdClose" value="Cancel" onClick="docancel()"class="buttonClose">
            </td>
           
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <br>
  <input type="hidden" name="hidBeanId" >
  <input type="hidden" name="hidBeanMethod" >
  <input type="hidden" name="hidBeanGetMethod" >
  <input type="hidden" name="hidSourceUrl"  >
  <INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>">
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidMode" value="">
  <!--  <input type="text" name="hidNew" value="<%//=Helper.correctNull((String)hshValues.get("cmano"))%>"> -->
  <input type="hidden" name="hidappno" value="">
  <input type="hidden" name="hidtotal" value="">
  <input type=hidden name="hidPageName" value="financial.jsp">
  <input type="hidden" name="hidcmasno" value="">
    <input type="hidden" name="hidfinance" value="">
  <input type="hidden" name ="hidcmaamtval" >
  <input type ="hidden" name="chkTotal" value="Y">
    <input type ="hidden" name="hidppid_value" value="<%=Helper.correctNull((String)request.getParameter("appid"))%>">
</form>
</body>
</html>