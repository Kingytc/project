<%@include file="../share/directives.jsp"%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
</script>
</head>
<body>
<a href="javascript:callLink('adv_borrowingpower.jsp','ADV1151','getadvBorrowingPower')">1</a> 
<a href="javascript:callLink('adv_commentsonstatus.jsp','ADV1151','getcommentsonstatus')">2</a>
<a href="javascript:callLink('adv_generalcomments.jsp','ADV1151','getGeneralComments')">3</a>
<a href="javascript:callLink('adv_dishonours.jsp','ADV1151','getdishonours')">4</a>
<a href="javascript:callLink('adv_legalheirs.jsp','ADV1151','getLegalheirs')">5</a>
<a href="javascript:callLink('adv_guarantorsdetails.jsp','ADV1151','getGuranteedetails')">6</a>
<a href="javascript:callLink('adv_otherbank.jsp','ADV1151','getotherbank')">7</a>
<a href="javascript:callLink('adv_turnover.jsp','ADV1151','getTurnover')">8</a>
<a href="javascript:callLink('adv_depositaccounts.jsp','ADV1151','getDepositAccounts')">9</a>
<a href="javascript:callLink('adv_termdepoits.jsp','ADV1151','getTermdepoits')">10</a>
<a href="javascript:callLink('adv_connectedaccounts.jsp','ADV1151','getconnectedaccts')">11</a>
<a href="javascript:callLink('adv_workingcapital.jsp','ADV1151','getworkingcapital')">12</a>
<a href="javascript:callLink('adv_billpurchase.jsp','ADV1151','getPurchaseDetails')">13</a>
<a href="javascript:callLink('adv_liabilities.jsp','ADV1151','getADVLiabilities')">14</a>
<a href="javascript:callLink('adv_comments.jsp','ADV1151','getComments')">15</a>
<a href="javascript:callLink('adv_document.jsp','ADV1151','getADVDocument')">16</a>
<a href="javascript:callLink('adv_borrowerexp.jsp','ADV1151','getADVBorrowerExp')">17</a>
<a href="javascript:callLink('adv_termloancomments.jsp','ADV1151','gettermloancomments')">18</a>
<a href="javascript:callLink('adv_workingcapitalcomments.jsp','ADV1151','getworkingcapitalcomments')">19</a>
</body>
</html>