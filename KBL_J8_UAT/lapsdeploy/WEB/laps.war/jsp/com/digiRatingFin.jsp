<%@include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
String strCurModule="";
int  vecModSize = 0,arSize=0;
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
ArrayList arRatRow=new ArrayList();
ArrayList arRatCol=new ArrayList();
if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	arRatRow=(ArrayList)hshValues.get("arRatRow");
}
ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
if (vecModule != null) {
	vecModSize = vecModule.size();
}
if(arrRow!=null && arrRow.size()>0)
{
	arSize=arrRow.size();
}
String tagFlag = "";
String strfintype = Helper.correctNull((String)hshValues.get("fintype"));

String strfinid = Helper.correctNull((String)hshValues.get("hidfinanceid"));

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DIGI RATING</title>
<script>
var cma="<%=strfintype%>";
var finaced_id="<%=strfinid%>";
var hid_appid="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appno="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var digiflag="<%=Helper.correctNull((String)hshValues.get("digiflag"))%>";
var digicma="<%=Helper.correctNull((String)hshValues.get("digicma"))%>";
var digistrAppID="<%=Helper.correctNull((String)hshValues.get("digistrAppID"))%>";
var digifinanceid="<%=Helper.correctNull((String)hshValues.get("digifinanceid"))%>";

</script>
</head>
<script type="text/javascript">
function callFinancialWorkflow()
{
	document.forms[0].hidBeanId.value = "financial";
	document.forms[0].hidBeanGetMethod.value="getHistroy";
	document.forms[0].action=appUrl+"action/com_financialratingworkflow.jsp";
	document.forms[0].hidcmasno.value=digicma;
	document.forms[0].hid_appid.value=digistrAppID;
	document.forms[0].hidfinanceid.value=digifinanceid;
	document.forms[0].submit();
}
function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].hid_appid.value=hid_appid;
	document.forms[0].hidfinid.value=finaced_id;
	document.forms[0].appno.value=appno;
	document.forms[0].action = appURL + "action/" + pagename;
	document.forms[0].pageFrom.value="RA1";
	document.forms[0].pagetype1.value="OFR";
	
	document.forms[0].submit();
}

function getSection(modid)
{	
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}

function doClose()
{
	   if(ConfirmMsg(100))
		 {
			 document.forms[0].action=appUrl+"action/financialsrch.jsp";
			 document.forms[0].submit();
		 }
			
}
function callonLoad()
{
	
}
</script>

<body onload="callonLoad()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr>
		<td class="page_flow">
          	Home -&gt; Financial / Rating -&gt; DIGI RATING
          	</td>
          </tr>
  </table>
 <lapschoice:finapptype  appid='<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("hidfinanceid"))%>'/>
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
				   
				  strClass="sub_tab_inactive";
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
					if (Helper.correctNull((String) hshValues.get("tabname"))
							.equalsIgnoreCase("Project Financial Input")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("INFRA STRUCTURE MODEL")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("OPERATIONS PHASE")) {
						/*if (Helper.correctNull(
								(String) hshValues.get("sel_divID"))
								.equalsIgnoreCase("0")) {
							pflag = true;
						}*/
					}
				}%>
				</td>
								<%}%>
							  	<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('financial','getDataRatio','finratio.jsp','RA1&pagetype1=OFR')">FINANCIAL RATIOS</a></b></td>  
							  	<td align="center" class="sub_tab_active" nowrap><b>DIGI RATING</b></td>  
								<td align="center" class="sub_tab_inactive"><a
									href="javascript:callFinancialWorkflow();"
									onMouseOut="window.status='';return true;"
									onMouseOver="window.status='Applicant';return true;"> <b>
							         FINANCIAL/RATING WORKFLOW </b></a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
<table align="center" width="55%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
</br>
<tr class="datagrid">
<td  >CIBIL Commercial Bureau Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("COMMERCIAL_BUREAU_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >CIBIL Consumer Individual Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CONSUMER_IND_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >CIBIL Consumer Related Party Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CONSUMER_PARTY_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >OD Account Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("OD_ACCOUNT_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Current Account Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("CURRENT_ACCOUNT_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >FSA Score: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FSA_SCORE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Band Rating: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("BAND_RATING"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td >Band Path: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="60"  value="<%=Helper.correctNull((String)hshValues.get("BAND_PATH"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > KB Rating: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("KB_RATING"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > Financial Type: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FINANCIAL_TYPE"))%>">
			</td>		
<tr>

<tr class="datagrid">
<td > Financial Year: <b><span class="mantatory" ></span></b></td>
<td>
				<input type="text"  name="score" size="15"  value="<%=Helper.correctNull((String)hshValues.get("FINANCIAL_YEAR"))%>">
			</td>	
</tr>	
</table>
<table align="center">
<tr>
	<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
</tr>
</table>
<input type ="hidden" name="hidBeanId">
<input type ="hidden" name="hidBeanGetMethod">
<input type="hidden" name="flowtype">
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String)hshValues.get("fintype"))%>">
<input type="hidden" name="pageval">
<input type="hidden" name="hid_appid">
<input type="hidden" name="hidfinid">
<input type="hidden" name="pageFrom">
<input type="hidden" name="appno">
<input type="hidden" name="pagetype1">

</form>
</body>
</html>