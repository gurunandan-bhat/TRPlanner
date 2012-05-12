[Payment]
QuotationId = <!-- TMPL_VAR NAME=qid -->
UploadId = <!-- TMPL_VAR NAME=uuid -->
PaymentId = <!-- TMPL_VAR NAME=puuid -->
Lead = <!-- TMPL_VAR NAME=name0 -->
AmountCharged = <!-- TMPL_VAR NAME=amt -->
CurrencyOdyssseyCode = <!-- TMPL_VAR NAME=occ -->
CurrencyHDFCCode = <!-- TMPL_VAR NAME=hdfccc -->
AmountIsAdvance = <!-- TMPL_VAR NAME=isadvance -->
PaymentTimeStamp = <!-- TMPL_VAR NAME=pdate -->
PaymentHDFCId = <!-- TMPL_VAR NAME=hdfcpid -->
TransactionHDFCId = <!-- TMPL_VAR NAME=hdfctid -->
ReferenceHDFCId = <!-- TMPL_VAR NAME=hdfcrid -->

[LeadPax]
Name = <!-- TMPL_VAR NAME=name0 -->
Nationality = <!-- TMPL_VAR NAME=nationality0 -->
PassportNo = <!-- TMPL_VAR NAME=passport0 -->
PassportPlaceofIssue = <!-- TMPL_VAR NAME=issuedat0 -->
PassportDateofIssue = <!-- TMPL_VAR NAME=issuedon0 -->
PassportDateofExpiry = <!-- TMPL_VAR NAME=expireson0 -->
AddressLine1 = <!-- TMPL_VAR NAME=addr1 -->
AddressLine2 = <!-- TMPL_VAR NAME=addr2 -->
City = <!-- TMPL_VAR NAME=city -->
State = <!-- TMPL_VAR NAME=state -->
Zip = <!-- TMPL_VAR NAME=zip -->
Country = <!-- TMPL_VAR NAME=country -->
Email = <!-- TMPL_VAR NAME=email -->
TravelEmail = <!-- TMPL_VAR NAME=travelemail -->
PreferredPhone = <!-- TMPL_VAR NAME=telehome -->
EmergencyContact = <!-- TMPL_VAR NAME=ecorrname -->
EmergencyEmail = <!-- TMPL_VAR NAME=eemail -->
EmergencyHomePhone = <!-- TMPL_VAR NAME=etelehome -->
EmergencyMobilePhone = <!-- TMPL_VAR NAME=etelecell -->


<!-- TMPL_LOOP NAME=paxes -->
[<!-- TMPL_VAR NAME=paxidx -->]
Name = <!-- TMPL_VAR NAME=name -->
Nationality = <!-- TMPL_VAR NAME=nationality -->
PassportNo = <!-- TMPL_VAR NAME=passport -->
PassportPlaceofIssue = <!-- TMPL_VAR NAME=issuedat -->
PassportDateofIssue = <!-- TMPL_VAR NAME=issuedon -->
PassportDateofExpiry = <!-- TMPL_VAR NAME=expireson -->
<!-- /TMPL_LOOP -->