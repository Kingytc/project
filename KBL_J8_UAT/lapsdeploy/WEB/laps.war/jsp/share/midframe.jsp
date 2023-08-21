<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<%
ArrayList arrValues = new ArrayList();
if (hshValues.get("arrValues") != null) 
{
	arrValues = (ArrayList) hshValues.get("arrValues");
}
String perapp_id = Helper.correctNull((String)session.getAttribute("bowid"));
String helpkey_id = "";
String strParent = Helper.correctNull((String)hshValues.get("strParent"));
String strChild = "0"; //Helper.correctNull((String)hshValues.get("strChild"));
String strFlag = Helper.correctNull((String)hshValues.get("flag"));
int iCtr = 0;
%>
<html>
<head>
<title>LAPS</title>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script>


function clearSelection() 
{
	for (i = 0; i < document.all["tab"].length; i++) 
	{
		document.all["link"][i].style.color ="#000000";
		document.all["tab"][i].style.background ="#EEEAE3"
	}

	for (i = 0; i < document.all["timg"].length; i++) 
	{
		document.all["timg"][i].src = "<%=ApplicationParams.getAppUrl()%>img/tableft.jpg";
	}
	
	// first tab & last tab	
	document.all["timg"][0].src = "<%=ApplicationParams.getAppUrl()%>img/tabfirst.jpg";	
	
	var lastIndex = document.all.timg.length - 1;
	document.all["timg"][lastIndex].src = "<%=ApplicationParams.getAppUrl()%>img/tabright.jpg";	
}

function doSelection(index) 
{
	var obj = document.all["tab"][index];
	var link = document.all["link"][index];

	clearSelection();
	
	if (index != 0) 
	{
		document.all["timg"][index].src = "<%=ApplicationParams.getAppUrl()%>img/tabdarkleft.jpg";
	} 
	else 
	{
		document.all["timg"][index].src = "<%=ApplicationParams.getAppUrl()%>img/tabdarkfirst.jpg";	
	}
	
	if (index != (document.all.tab.length-1)) 
	{
		document.all["timg"][++index].src = "<%=ApplicationParams.getAppUrl()%>img/tabdarkright.jpg";
	} 
	else
	{
		document.all["timg"][++index].src = "<%=ApplicationParams.getAppUrl()%>img/tabdarklast.jpg";
	}

	link.style.color ="#FFFFFF";
	obj.style.background ="#71694F";
}

// Page is Main Tabs
function callPage(page_id, page, tab_id,helpid) 
{

	// setting child data to topFrame
    window.parent.window.parent.topFrame.document.forms[0].hidChildId.value=page_id;
    window.parent.window.parent.topFrame.document.forms[0].hidChildPage.value=page;
    window.parent.window.parent.topFrame.document.forms[0].hidChildTab.value=tab_id;
    window.parent.window.parent.topFrame.document.forms[0].hidHelpkeyid.value=helpid;
	doSelection(tab_id);
	window.parent.window.parent.mainFrame.document.location.href = 
				"<%=ApplicationParams.getAppUrl()%>action/"+page+"&screen_id="+page_id;
}

function doLoad() {


	if ("<%=strFlag%>"=="orgChange") {
		var page_id = window.parent.window.parent.topFrame.document.forms[0].hidChildId.value;
	    var page = window.parent.window.parent.topFrame.document.forms[0].hidChildPage.value;
	    var tab_id = window.parent.window.parent.topFrame.document.forms[0].hidChildTab.value;
	    var help_id = window.parent.window.parent.topFrame.document.forms[0].hidHelpkeyid.value;
	    if (page!="") {
		    callPage(page_id, page, tab_id,help_id);
		}
		
	}
}
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0" onload="doLoad()">
<form name="form1" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="2">
    <tr> 
      <td valign="bottom"> 
        <table border="0" cellspacing="0" cellpadding="0" align="left">
          <tr> 
            <%
				if (arrValues.size() > 0) 
				{
					boolean flag = false;
					for (int size = arrValues.size(); iCtr < size; iCtr++) 
					{
						ArrayList arrRow = (ArrayList) arrValues.get(iCtr);
						out.println(arrRow.get(0));
						out.println(arrRow.get(2));
						out.println(arrRow.get(3));
						if (strChild.trim().equals(String.valueOf(iCtr)) || (strChild.trim().equals("")) && iCtr == 0) {
%>
        
            <td id="tab" nowrap align="center" class="tabactivetop" ><b><font size="1" face="ms sans serif"><a id="link" style="color: white"
					href="javascript:callPage('<%= arrRow.get(0)%>', '<%= arrRow.get(2)%>', '<%= iCtr %>', '<%= arrRow.get(3)%>')">&nbsp;&nbsp;<%= (String) arrRow.get(1) %>&nbsp;&nbsp;</a></font></b></td>
					<script>
					
						// setting the child id
							window.parent.window.parent.topFrame.document.forms[0].hidChildId.value = '<%= arrRow.get(0)%>';
							window.parent.window.parent.topFrame.document.forms[0].hidHelpkeyid.value = '<%= arrRow.get(3)%>';
					</script>
            <% 
							flag = true;
						} 
						else 
						{
							if (flag) 
							{
								flag = false;

							} else 
							{

							}
%>
            <td id="tab" nowrap align="center" class="tabinactive" ><b><font size="1" face="ms sans serif"><a id="link"
					href="javascript:callPage('<%= arrRow.get(0)%>', '<%= arrRow.get(2)%>', '<%= iCtr %>', '<%= arrRow.get(3)%>')">&nbsp;&nbsp;<%= (String) arrRow.get(1) %>&nbsp;&nbsp;</a></font></b></td>
<%
						}
					}
					
				}
%>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidDemoId" value="<%=perapp_id%>">
</form>
</body>
</html>