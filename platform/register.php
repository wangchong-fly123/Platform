<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>欢动通行证注册</title>
<link href="view/layout_LoginAndRegister.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function create_code() {
    document.getElementById('code').src = 'authcode.php';
}
function pw() {
    var pw1 = document.getElementById("password").value;
    var pw2 = document.getElementById("confirm").value;
    if(pw1 == pw2) {
        document.getElementById("notify").innerHTML="<font color='green'> </font>";
    } else {
        document.getElementById("notify").innerHTML="<font color='red'>两次输入密码不相同</font>";
    }
}
</script>
</head>
<body>
<div id="container">
    <div id="header">
    </div>
    <div id="mainContent">
        <div id="circle">
            <form name="frm" action="register_process.php" method="post">
                <table width="60%" align="center">
                    <tr><td>用户名:</td><td><input type="text" name="username" id="username" size="30" maxlength="16" value=""  style="width:200px;height:30px"></td><td>*字母和数字或下划线组合(5-16位)</td></tr>
                    <tr><td>密码:</td><td><input type="password" name="password" id="password" size="30" maxlength="16" value=""  style="width:200px;height:30px"></td><td>*字母和数字或下划线组合(5-16位)</td></tr>
                    <tr><td>确认密码:</td><td><input type="password" name="confirm" id="confirm" size="30" maxlength="16" value=""  onkeyup="pw();"style="width:200px;height:30px"></td><td></td></tr>
                    <tr><td>确认密码:</td><td><input type="text" name="regtype" id="confirm" size="30" maxlength="16" value=""  onkeyup="pw();"style="width:200px;height:30px"></td><td></td></tr>
                    </td>
                    <td><img id="code" name="code" src="authcode.php" /><a style="text-decoration:underline;cursor:hand" onclick="create_code();return false;">换一个</a>
                    </td></tr>
                    <tr><td></td><td><input id="submit" type="submit" value="注册" style="width:90px;height:40px;"/>
                    <input type="reset" value="清空" style="width:60px;height:40px;"/></td></tr>
                    <tr><td></td><td><span id="notify"></span></td></tr>
                </table>
            </form>
        </div>
    </div>
</div>

<div id="footer">
<center>版权所有 翻版必究</center>
</div>
</body>
</html>
