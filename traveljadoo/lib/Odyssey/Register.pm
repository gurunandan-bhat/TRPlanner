package Odyssey::Register;

use strict;
use warnings;

use lib qw{../};

use OdysseyDB::WebText;

use base qw(Odyssey);
use Date::Manip;
use Digest::MD5 qw{md5_hex};

use MIME::Lite;
use Email::Valid;

use Data::Dumper;

our $VERSION = '0.01';

# Preloaded methods go here.

sub setup {
	my $app = shift;
	
	$app->mode_param('mode');

	$app->run_modes(
		register => 'register',
		confirm => 'confirm',
		forgotpassword => 'forgotpassword',
		forgotnewpasswd => 'forgotnewpasswd',
		newpasswd => 'newpasswd',
	);

	$app->start_mode('register');
	$app->error_mode('errhndlr');
}


sub register {
	use Email::Valid;
	
	my $app = shift;
	my $tpl = $app->load_tmpl('register.tpl', die_on_bad_params => 0);
	
	my $righttext = addptags(OdysseyDB::WebText->retrieve(web_id => 29)->writeup);
	my $lefttext = addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup . '<br />
					<a href="index.cgi?mode=links&id=16">Click here</a> to view our Privacy Policy');
	
	$tpl->param(
		LEFTTEXT => $lefttext,
		RIGHTTEXT => $righttext,
	);

	if (! $app->query->param('submit')) {
		return $tpl->output;
	}
	
	my $email = $app->query->param('email');
	my $errstr;
	$errstr .= ' Please provide a valid email address' unless Email::Valid->address($email);
	
	if ($errstr) {
		$tpl->param(SHOWERROR => $errstr);
		return $tpl->output;
	}
	
	my $chkqry = 'select rowid from users where username = ' . $app->dbh->quote($email);
	my $sth = $app->dbh->prepare($chkqry);
	$sth->execute;
	my ($userid) = $sth->fetchrow_array;
	
	if (! $userid) {

		my $insqry = "insert into users (username, active, registeredon) values (?, 1, ?)";
		$sth = $app->dbh->prepare($insqry);
		$sth->execute($email, UnixDate('now', '%a, %e %b %y %H:%M:%S'));
		$app->dbh->commit;
	}

	$app->session->param(username => $email);
	$app->redirect('/my-travellers-palm');
}

sub newpasswd {
	
	my $app = shift;
	my $q = $app->query;
	
	$app->redirect('index.cgi') unless
		$q->param('mailpasswd');
		
	my $userid = $q->param('userid');
	my $dbh = $app->dbh;

	my $qry = "select username from users where rowid = $userid";
	my $sth = $dbh->prepare($qry);
	$sth->execute;
	
	my ($email) = $sth->fetchrow_array;
	
	my $passwd = generate_password();
	my $md5passwd = md5_hex($passwd);

	$qry = 'update users set password = ' . $dbh->quote($md5passwd) . ' where rowid = ' . $userid;
	
	$sth = $dbh->prepare($qry);
	$sth->execute;
	
	my $msg = MIME::Lite->new(
		From => 'Traveller\'s Palm Administrator <admin@travellers-palm.com>',
		To => $email,
		Subject => 'Your request for a Password',
		Data => "Dear User\n\n
			Thank you for registering with Traveller's Palm.\n
			Following your request, we have generated a password for your use.\n
			Please use $passwd to login and use our services.\n\n
			Happy Traveling!\n
			Traveller's Palm Administrator\n",
	);
	
	MIME::Lite->send(
		'smtp', 
		'mail.traveljadoo.com', 
		Timeout => 30,
		AuthUser => 'admin+traveljadoo.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	
	$msg->send;
	
	my $righttext = addptags(OdysseyDB::WebText->retrieve(web_id => 29)->writeup);
	my $lefttext = addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup . '<br />
					<a href="index.cgi?mode=links&id=16">Click here</a> to view our Privacy Policy');

	my $tpl = $app->load_tmpl('mailedpassword.tpl', die_on_bad_params => 0);
	
	$tpl->param(
		LEFTTEXT => $lefttext,
		RIGHTTEXT => $righttext,
	);

	return $tpl->output;
}

sub forgotnewpasswd {
	
	my $app = shift;
	my $q = $app->query;
	
	$app->redirect('index.cgi') unless
		$q->param('mailpasswd');
		
	my $username = $q->param('userid');
	my $dbh = $app->dbh;

	my $qry = "select rowid from users where username = ?";
	my $sth = $dbh->prepare($qry);
	$sth->execute($username);
	
	my ($rowid) = $sth->fetchrow_array;
	
	my $righttext = addptags(OdysseyDB::WebText->retrieve(web_id => 29)->writeup);
	my $lefttext = addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup . '<br />
					<a href="index.cgi?mode=links&id=16">Click here</a> to view our Privacy Policy');

	if (! $rowid ) {
		my $tpl = $app->load_tmpl('forgotpassword.tpl', die_on_bad_params => 1);
		$tpl->param(nosuchuser => 1);
		$tpl->param(
			LEFTTEXT => $lefttext,
			RIGHTTEXT => $righttext,
		);
		return $tpl->output;
	}
	
	my $passwd = generate_password();
	my $md5passwd = md5_hex($passwd); 

	$qry = 'update users set password = ? where username = ?';
	
	$sth = $dbh->prepare($qry);
	$sth->execute($md5passwd, $username);
	
	my $msg = MIME::Lite->new(
		From => 'Traveller\'s Palm Administrator <admin@travellers-palm.com>',
		To => $username,
		Subject => 'Your request for a Password',
		Data => "Dear User\n\n
			Thank you for registering with Traveller's Palm.\n
			Following your request, we have generated a password for your use.\n
			Please use $passwd to login and use our services.\n\n
			Happy Traveling!\n
			Traveller's Palm Administrator\n",
	);
	
	MIME::Lite->send(
		'smtp', 
		'traveljadoo.com', 
		Timeout => 30,
		AuthUser => 'admin+traveljadoo.com',
		AuthPass => 'ip31415',
		Debug => 1,
	);
	
	$msg->send;

	my $tpl = $app->load_tmpl('mailedpassword.tpl');
	$tpl->param(
		LEFTTEXT => $lefttext,
		RIGHTTEXT => $righttext,
	);
	return $tpl->output;
}

sub addptags {

	return '' unless (my $str = shift);

	my @lines = split m{
						(?:					# make capturing if saving terminators 
								\x0D \x0A	# CRLF         
							|   \x0A		# LF 
							|   \x0D		# CR 
							|   \x0C		# FF 
							|   \x{2028}	# Unicode LS 
							|   \x{2029}	# Unicode PS 
						)
					}x, $str;
					
	return '<p class="writeup">' . join('</p><p class="writeup">', @lines) . '</p>';
}

sub generate_password {
	
	my $str;
	foreach (1 ..8) {
		$str .= chr(97 + int(rand(26)));
	}
	return $str;
}

sub forgotpassword {
	
	my $app = shift;

	my $righttext = addptags(OdysseyDB::WebText->retrieve(web_id => 29)->writeup);
	my $lefttext = addptags(OdysseyDB::WebText->retrieve(web_id => 30)->writeup . '<br />
					<a href="index.cgi?mode=links&id=16">Click here</a> to view our Privacy Policy');
	
	my $tpl = $app->load_tmpl('forgotpassword.tpl', die_on_bad_params => 1);
	
	$tpl->param(
		LEFTTEXT => $lefttext,
		RIGHTTEXT => $righttext,
	);

	return $tpl->output;
}
