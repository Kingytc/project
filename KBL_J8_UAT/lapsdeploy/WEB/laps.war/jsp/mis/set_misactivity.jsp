<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>MIS Activity Code</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/mis/set_misactivity.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function clearvalues() {
	document.forms[0].sel_SubActivity.options[0].value="";
	document.forms[0].sel_SubActivity.options[0].text="select";
}
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<form name="misactivity" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home-&gt; Setup -&gt; MIS Setup -&gt; Activity Code</td>
</tr>
</table>
<br>
<br>
<table width="50%" border="0" cellspacing="0" cellpadding="0" class="outertable border1 tableBg" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center">
		<tr>
			<td>
				<table width="95%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center">
				<tr>
					<td>
						Activity code<span class="mantatory">*</span>
					</td>
					<td>
						<input type="text" name="txt_ActivityCode" readOnly="readonly" style="width: 30%">
						&nbsp;
						<b>
							<span onClick="callMISActvityHelp();" style="cursor:hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
							</span>
						</b>
					</td>
				</tr>
				<tr>
					<td width="20%">
						Main Activity<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_MainActivity" style="width: 80%" onchange="onMainActChange();generateActivityCode();">
							<option value="">--Select--</option>
							<lapschoice:MISDataTag apptype="2"/>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Sub Activity<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_SubActivity" id="sel_SubActivity" style="width: 80%" onchange="generateActivityCode();">
							<option value="">--Select--</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Purpose<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_Purpose" style="width: 80%" onchange="generateActivityCode();">
							<option value="">--Select--</option>
							<lapschoice:MISPurposeDataTag apptype="3"/>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						BSR Code<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_BSRCode" style="width: 80%">
							<option value="">--Select--</option>
							<lapschoice:BSRCodeTag apptype="1" />
						</select>
					</td>
				</tr>
				<tr>
					<td>
						BSR1 Code
					</td>
					<td>
						<select name="sel_BSR1Code" style="width: 80%">
							<option value="">--Select--</option>
							<lapschoice:MISDataTag apptype="6"/>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Display Screen
					</td>
					<td>
						<select name="txt_displayscreen" style="width: 80%" multiple>
							<option value="">--Select--</option>
							<lapschoice:MISDataTag apptype="4"/>
						</select>
						<input type="hidden" name="sel_DisplayScreen" value="">
					</td>
				</tr>
				<tr>
					<td>
						Industry Type
					</td>
					<td>
						<select name="sel_IndustryType" style="width: 80%">
							<option value="">--Select--</option>
							<lapschoice:MISDataTag apptype="5"/>
						</select>
					</td>
				</tr>
					<tr>
					<td width="20%">
						LBR Code<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_LBRCode" style="width: 80%">
							<option value="">--Select--</option>
							<lapschoice:MISDataTag apptype="21"/>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Visibility<span class="mantatory">*</span>
					</td>
					<td>
						<select name="sel_Visibility" style="width: 30%">
							<option value="">--Select--</option>
							<option value="E">Enable</option>
							<option value="D">Disable</option>
						</select>
					</td>
				</tr>
				
				<tr>
				
				 <td>Rating is Based on</td>
				 <td>
				 <select name="sel_ratbasedon" style="width: 50%">
							<option value="">--Select--</option>
							<option value="S">Schematic</option>
							<option value="N">Non-Schematic</option>														
						</select></td>
						
				
				</tr>
				
				<tr>
				
				 <td>Type of Rating<span class="mantatory">*</span></td>
				 <td>
				 <select name="sel_busruleid" style="width: 50%">
							<option value="">--Select--</option>
							<lapschoice:BusinessRuleTag apptype="1" page='set' />							
						</select></td>
				
				</tr>
				<tr>
				<td>Free Code 6 <b><span class="mantatory">*&nbsp;</span></b></td>
      			<td> 
       			<select name="sel_freecode6" tabindex="2" onchange="changeFreeCode7()" style="width: 90%">
      				<option value="0" selected="selected" >--Select--</option>
					<lapschoice:StaticDataNewTag apptype="127" />
    			</select>
			</td>
			</tr>
			<tr>
			<td>Free Code 7 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode7" tabindex="4" onchange="changeFreeCode8(document.forms[0].sel_freecode7.value);setText7();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option> 
    			</select>
			</td>
			</tr>
			<tr>
			<td>Free Code 8 <b><span class="mantatory">*&nbsp;</span></b></td>
      		<td> 
       			<select name="sel_freecode8" tabindex="6" onchange="setText8();" style="width: 90%">
      				<option value="" selected="selected">--Select--</option>
    			</select>
			</td>
			</tr>
			<tr>
			<td nowrap="nowrap">Whether CGTMSE applicable&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="sel_cg">
							<option value="" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
			</tr>
			<tr>
			<td nowrap="nowrap">Whether Allied Activity Code&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="allied_act_code">
							<option value="" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
			</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<iframe height="0" width="0" id="ifrme" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidSlNo">
<input type="hidden" name="hidFreeCode7">
<input type="hidden" name="hidFreeCode8">
<input type="hidden" name="hidFreeCode7FinVal">
<input type="hidden" name="hidFreeCode8FinVal">
<input type="hidden" name="hidFreeCode7Desc">
<input type="hidden" name="hidFreeCode8Desc">
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0" ></iframe>
</form>
</body>
</html>