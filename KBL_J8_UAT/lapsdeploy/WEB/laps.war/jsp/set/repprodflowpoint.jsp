<%@include file="../share/directives.jsp"%><html>
<head>
<title>Reports - Products Flowpoint</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/repprodflowpoint.js">
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
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body onLoad="loadValues()">

<form class="normal" name="orgfrm" method="post">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
    
      <td class="page_flow">Home 
        -&gt;Setup -&gt; Reports 
        -&gt;Product Flowpoints </td>
    </tr>
  </table>
      
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="20">
    <tr> 
      <td valign="middle"> 
        <div align="left"> 
          <table class="outertable border1 tableBg" width="60%" border="0" cellspacing="0" cellpadding="5" align="center">
            <tr> 
              <td> 
                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                  <tr> 
                    <td width="77%">
                      <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                        <tr class="dataheader"> 
                          <td align="center" height="26" width="31%">Product 
                            Type </td>
                          <td align="center" height="26" width="33%">Category 
                            </td>
                        </tr>
                        <tr> 
                          <td align="center" height="26" width="31%"> 
                              
                            <select name="prodopt" style="width:140" onChange="selectValues()" style="margin-bottom: 11px; display:inline-block;">
                              <option selected>--Select--</option>
							   <option value="p">Retail Product</option>
                            </select>
                            </td>
                          <td align="center" height="26" width="33%"><iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" src="<%=ApplicationParams.getAppUrl()%>action/iframeprodrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=prodflow&hidProducts=prod&prodtype="+prodid></iframe> 
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
                              <option value="prd_desc">Product Name</option>
                              <option value="prd_rng_from">Product Range From</option>
                              <option value="prd_rng_to">Product Range To</option>
                              <option value="prd_flowpoint">Flow Point</option>
                              <option value="prd_maxclass">Maximum Class</option>
                              <option value="wrk_flowname">Action</option>
                              <option value="wrk_flowtype"> Process Phase</option>
                              <option value="prd_duration">Duration(Hrs)</option>
                            </select>
                          </td>
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
  <table class="outertable border1" border="0" cellspacing="0" cellpadding="0" align="center" >
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="16%"> 
              <div align="center"> 
                <input type="button" name="rprunreport" value="Run Report" class="buttonothers" onClick="runrep()">
              </div>
            </td>
      
            <td width="15%"> 
              <div align="center"> 
                <input type="reset" name="rpreset" value="Reset" class="buttonothers" onClick="JavaScript:resetValues()">
              </div>
            </td>
            
            <td align="center" width="21%"> 
              <input type="button" name="rpclose" value="Close" class="buttonClose" onClick="JavaScript:closeWindow()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  
  

<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="prodtype"  >
<input type="hidden" name="hidProducts"  >
<input type="hidden" name="hidFromWhichPage"  >
<input type="hidden" name="hidPrdCode"  >
<input type="hidden" name="hidCatFields">
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields"  >
<input type="hidden" name="hidMethod" >
<input type="hidden" name="repname" value ="Product Flowpoint Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidParam">
<input type="hidden" name="hidPage" value="runprodflowrep.jsp">
<input type="hidden" name="txtDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
