<html>
<head>
<script>

function callLink(pagename,methodname)
{
	document.forms[0].method = "post";	
	document.forms[0].hidMethod.value = methodname;
	document.forms[0].action = appUrl+"action/"+pagename;
	document.forms[0].submit();
}


</script>
</head>
<body>

 <a href="javascript:callLink('npa_prop1.jsp','getNpaDetailsData')" class="blackfont"> 
1</a> <a href="javascript:callLink('npa_prop2.jsp','getNpaDetailsData')" class="blackfont"> 
2</a> <a href="javascript:callLink('npa_prop3.jsp','getSacrificeData')" class="blackfont">
3</a> <a href="javascript:callLink('npa_prop4.jsp','getClaimData')" class="blackfont"> 
4</a> <a href="javascript:callLink('npa_prop5.jsp','getAssociateGroupData')" class="blackfont"> 
5</a> <a href="javascript:callLink('npa_prop6.jsp','getSacrificeData')" class="blackfont"> 
6</a> <a href="javascript:callLink('npa_prop7.jsp','getMovementData')" class="blackfont"> 
7</a>

</body>
</html>
