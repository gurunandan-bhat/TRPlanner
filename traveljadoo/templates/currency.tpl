<table border="0">
<tr><th>Currency</th><th>Symbol</th></tr>
<TMPL_LOOP NAME="CURRENCIES">
<tr>
   <td>
      <a href="<!-- TMPL_VAR NAME=URI -->;selected_currency=<!-- TMPL_VAR NAME=CODE -->;changed_currency=1">
      <!-- TMPL_VAR NAME=CODE --> &nbsp;&nbsp;&nbsp; <!-- TMPL_VAR NAME=CURRENCY --></a>
   </td>
   <td><!-- TMPL_VAR NAME=SYMBOL --></td>
</tr>
</TMPL_LOOP>
</table>                                       
