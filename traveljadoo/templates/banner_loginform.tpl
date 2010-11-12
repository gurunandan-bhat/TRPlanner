<form  id="loginform" name="loginform" method="post" action="<!-- TMPL_VAR NAME=THISURL -->">
	<table width="100%">
		<tr>
			<td><label for="authen_username">Email: </label></td>
			<td><input type="text" id="authen_username" name="authen_username" /></td>
		</tr>
		<tr>
			<td><label for="authen_password">Password: </label></td>
			<td><input type="password" name="authen_password" size="20" /></td>
		</tr>
	</table>
	<div id="submitbutton"><input type="image" src="images/signin.gif" name="authen_loginbutton" value="Sign In" /></div>
	<div id="registerlink">or <a href="register.cgi">Register</a></div>
	<input type="hidden" name="destination" value="<!-- TMPL_VAR NAME=THISURL -->" />
	<input type="hidden" name="rm" value="authen_login" />
</form>
