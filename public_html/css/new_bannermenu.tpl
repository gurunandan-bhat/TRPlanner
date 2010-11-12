<div id="topmenu">
<ul>
	<li id="current"><a href="index.cgi">Home</a></li>
	<li><a href="theme.cgi">Themes</a></li>
	<li><a href="hotel.cgi">Special Places</a></li>
	<li><a href="region.cgi">Modules</a></li>
	<li><a href="tours.cgi?mode=tours_index">Tours</a></li>
	<li><a href="index.cgi?mode=init">Plan a Trip</a></li>
	<li><a href="index.cgi?mode=about">About Us</a></li>
	<li><a href="index.cgi?mode=contact">Contact Us</a></li>
</ul>
</div>
<div id="loginbox">
	<!-- TMPL_IF NAME=USERNAME -->
	<p>
		Welcome <!-- TMPL_VAR NAME=USERNAME --> (<a href="index.cgi?authen_logout=1">Logout</a>)<br />
		Last Login: <!-- TMPL_VAR NAME=LASTLOGIN -->
	</p>
	<!-- TMPL_ELSE -->
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
			<tr>
				<td colspan="2">
					<input type="submit" name="authen_loginbutton" value="Sign In" class="button" /> <span class="labeltype">or</span> <a href="register.cgi"><span class="labeltype">Register</span></a>
				</td>
			</tr>
		</table>
		<input type="hidden" name="destination" value="<!-- TMPL_VAR NAME=THISURL -->" />
		<input type="hidden" name="rm" value="authen_login" />
	</form>
	<!-- /TMPL_IF -->	
</div>
