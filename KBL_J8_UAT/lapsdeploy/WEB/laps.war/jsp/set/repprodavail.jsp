<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Product Availability</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/repprodavail.js">
</script>
<script>
<!--




var per = new Array;
var path="<%=ApplicationParams.getAppUrl()%>";
var prodid="";
var fromwhichpage="";
var prodid ="";
var param="";
var rights ="<%=session.getAttribute("strGroupRights")%>";
var userid ="<%=session.getAttribute("strUserId")%>";
//-->
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body onLoad="loadValues()">

<form name="orgfrm" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td class="page_flow">Home 
        -&gt;Setup -&gt; Reports 
        -&gt;Product Availability 
    </tr>
  </table>
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="20"  >
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1 tableBg" width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
            <tr> 
              <td> 
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="77%"> 
                      
                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                        <tr class="dataheader"> 
                          <td align="center" height="26" width="31%">Product 
                            Type </td>
                          <td align="center" height="26" width="33%">Category 
                            </td>
                        </tr>
                        <tr> 
                          <td align="center" height="26" width="31%"> 
                              
                            <select name="prodopt" style="width:150" onChange="selectValues()"  style="margin-bottom: 11px; display:inline-block;">
                              <option selected>--Select--</option>
							 <option value="p">Retail Product</option>
                            </select>
                            </td>
                          <td align="center" height="26" width="33%">
                            <select name="prodcat" style="width:140" onChange="selectSub()" style="margin-bottom: 11px; display:inline-block;">
                              <option selected>--Select--</option>
                            </select>
                          </td>
                        </tr>
                        <tr class="dataheader"> 
                          <td align="center">Select 
                            Sub Category</td>
                          <td align="center">Select 
                            Output Fields</td>
                        </tr>
                        <tr> 
                          <td align="center">  
                            <select name="product" size="11"  multiple style="width:150"  >
                            </select>
                            </td>
                          <td align="center"> 
                            <select name="rpselect2" size="11" style="width:150" multiple >
                              <option value="p.prd_desc">Product Description</option>
                              <option value="c1.cat_name as cat_name">Category</option>
                              <option value="c2.cat_name as scat_name">Sub Category</option>
                              <option value="p.prd_intrate">Interest Rate</option>
                              <option value="p.prd_rng_from">Range From</option>
                              <option value="p.prd_rng_to">Range To</option>
                            </select>                          </td>
                        </tr>
                      </table>
                      
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </div>
      </td>
    </tr>
  </table>
  <br>
  <table class="outertable border1 tableBg" width="1%" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td height="0" width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
       
            <td height="0" width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()">
              </div>
            </td>
           
            <td height="0" width="21%"> 
              <div align="center"> 
                <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="prodtype"  >
<input type="hidden" name="hidProducts"  >
<input type="hidden" name="hidPrdCode"  >
<input type="hidden" name="hidCatFields">
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidMethod" >
<input type="hidden" name="repname" value ="Product Availability Report">
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="runprodavailrep.jsp">
<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
