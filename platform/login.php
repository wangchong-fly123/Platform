<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>登录页面</title>
<link href="view/layout_LoginAndRegister.css" rel="stylesheet" type="text/css" />


</head>
<body>
<div id = "container">
<div id = "header">
</div>
<div id="mainContent">
<h2>注册欢动通行证</h2>
<div id="circle">
	<form action="login_process.php" method="post">
	<table width="55%" align="center">
	    <tr><td>账号:</td><td><input type="text" name="username" size="30" maxlength="16" value="" style="width:200px;height:30px"></td></tr>
	    <tr><td>密码:</td><td><input type="password" name="password" size="30" maxlength="16" value="" style="width:200px;height:30px"></td></tr>
	    <tr><td>GAME:</td><td><input type="text" name="game" size="30" maxlength="16" value="" style="width:200px;height:30px"></td></tr>
	    <br>
	    <tr>
	    <td></td><td><input type="submit" value="登陆" style="width:90px;height:40px;"/> <input type="reset" value="清空" style="width:60px;height:40px;"/></td>
	    </tr>
	</table>
	</form>
</div>
</div>

</div>
<div id="footer">
<center>版权所有 翻版必究</center>
</div>
</div>

</body>
</html>
