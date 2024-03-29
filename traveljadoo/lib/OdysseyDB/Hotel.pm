package OdysseyDB::Hotel;

use strict;
use warnings;

use lib qw{../};

use base qw(OdysseyDB);

__PACKAGE__->table('vw_hoteldetails');

__PACKAGE__->columns(Primary => 'addressbook_id');
__PACKAGE__->columns(Temp => qw/costcategory costcategoryid/);
__PACKAGE__->columns(Others => qw{
	image1
	description
	showhotel
	image2
	image3
	image4
	starcategories_id
	cuisine
	bars
	restaurants
	checkout
	accessrail
	accessair
	accessbus
	advantage
	logo
	rooms
	ac
	roomfacility
	otherfacility
	services
	creditcards
	fhra
	webwriteup1
	webwriteup2
	organisation
	address
	city
	postalcode
	countries_id
	phone
	fax
	pan
	email
	www
	branch_cities_id
	note
	areacode
	bank_addressbook_id
	through_addressbook_id
	mailto_addressbook_id
	cities_id
	states_id
	currencies_id
	web
	company
	taxno
	includeinbalancesheet
	invoiceto_addressbook_id
	invoiceorderno
	metatype
	descr
	keywords
	url
});

__PACKAGE__->has_a(countries_id => 'OdysseyDB::Country');
__PACKAGE__->has_a(states_id => 'OdysseyDB::State');
__PACKAGE__->has_a(cities_id => 'OdysseyDB::City');

__PACKAGE__->has_many(categories => ['OdysseyDB::HotelCategory' => 'categories_id']);

__PACKAGE__->set_sql(webhotels => qq{
	select 
		vw_hoteldetails.addressbook_id 
	from
		vw_hoteldetails,
		addresscategories
	where
		addresscategories.categories_id = 27 and
		addresscategories.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ? and
		vw_hoteldetails.addressbook_id != ?
});

__PACKAGE__->set_sql(defaulthotels => qq{
	select
		vw_hoteldetails.addressbook_id,
		case a2.categories_id 
			when 23 then '\$'
			when 36 then '\$' 
			when 22 then '\$\$' 
			when 8 then '\$\$\$' 
			when 35 then '\$\$\$\$' 
		end costcategory,
		case a2.categories_id 
			when 23 then 2 
			when 36 then 3
			when 22 then 4 
			when  8 then 5
			when 35 then 6 
		end costcategoryid
	from
		vw_hoteldetails,
		vw_defaulthotels,
		addresscategories a2
	where
		vw_hoteldetails.addressbook_id = vw_defaulthotels.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_defaulthotels.cities_id = ? and 
		a2.categories_id in (8, 22, 23, 35, 36)
	order by
		costcategoryid
});

sub webhotels_bycity {

	my $class= shift;
	my $cityid = shift;
	
	my $dbh = $class->db_Main();

	my $qry = qq{
		select
			vw_hoteldetails.addressbook_id hotelid,
			vw_hoteldetails.organisation hotelname,
			vw_hoteldetails.description hoteldescription,
			vw_hoteldetails.city hotelcity,
			case a2.categories_id 
				when 23 then '\$' 
				when 36 then '\$'
				when 22 then '\$\$' 
				when 8 then '\$\$\$' 
				when 35 then '\$\$\$\$' 
			end as hotelcategory
		from
			vw_hoteldetails,
			addresscategories a1,
	    	addresscategories a2
		where
			a1.categories_id = 27 and
			a2.categories_id in (23, 36, 22, 8, 35) and
			a1.addressbook_id = vw_hoteldetails.addressbook_id and
			a2.addressbook_id = vw_hoteldetails.addressbook_id and
			vw_hoteldetails.cities_id = ?
		order by
			5 asc
	};
	my $sth = $dbh->prepare($qry);
	$sth->execute($cityid);
	
	return $sth->fetchall_arrayref({});	
}

__PACKAGE__->set_sql(alltypes_bycity => qq{
	select
		vw_hoteldetails.addressbook_id,
		vw_hoteldetails.organisation,
		vw_hoteldetails.description,
		vw_hoteldetails.city,
		case a2.categories_id 
			when 23 then '(M)' 
			when 36 then '(M)'
			when 22 then '(MM)' 
			when 8 then '(MMM)' 
			when 35 then '(MMMM)' 
		end as costcategory
	from
		vw_hoteldetails,
		addresscategories a1,
    	addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id in (23, 36, 22, 8, 35) and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ?
	order by
		a2.categories_id desc
});

__PACKAGE__->set_sql(moderate_bycity => qq{
	select
		vw_hoteldetails.addressbook_id,
		vw_hoteldetails.organisation,
		vw_hoteldetails.description,
		vw_hoteldetails.city
	from
		vw_hoteldetails,
		addresscategories a1,
    	addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 23 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ?
});

__PACKAGE__->set_sql(comfortable_bycity => qq{
    select
        vw_hoteldetails.addressbook_id,
        vw_hoteldetails.organisation,
        vw_hoteldetails.description,
        vw_hoteldetails.city
    from
        vw_hoteldetails,
        addresscategories a1,
        addresscategories a2
    where
        a1.categories_id = 27 and
        a2.categories_id = 36 and
        a1.addressbook_id = vw_hoteldetails.addressbook_id and
        a2.addressbook_id = vw_hoteldetails.addressbook_id and
        vw_hoteldetails.cities_id = ?
});

__PACKAGE__->set_sql(superior_bycity => qq{
	select
		vw_hoteldetails.addressbook_id,
		vw_hoteldetails.organisation,
		vw_hoteldetails.description,
		vw_hoteldetails.city
	from
		vw_hoteldetails,
		addresscategories a1,
    	addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 22 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ?
});

__PACKAGE__->set_sql(luxury_bycity => qq{
	select
		vw_hoteldetails.addressbook_id,
		vw_hoteldetails.organisation,
		vw_hoteldetails.description,
		vw_hoteldetails.city
	from
		vw_hoteldetails,
		addresscategories a1,
    	addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 8 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ?
});

__PACKAGE__->set_sql(topofline_bycity => qq{
	select
		vw_hoteldetails.addressbook_id,
		vw_hoteldetails.organisation,
		vw_hoteldetails.description,
		vw_hoteldetails.city
	from
		vw_hoteldetails,
		addresscategories a1,
    	addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 35 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.cities_id = ?
});

__PACKAGE__->set_sql(hotelname => qq{
	select 
		vw_hoteldetails.addressbook_id 
	from
		vw_hoteldetails,
		addresscategories
	where
		addresscategories.categories_id = 27 and
		addresscategories.addressbook_id = vw_hoteldetails.addressbook_id and
		upper(organisation) like ?
	}
);

__PACKAGE__->set_sql(heritagehotels_by_state => qq{
	select 
		vw_hoteldetails.addressbook_id 
	from
		vw_hoteldetails,
		addresscategories a1,
		addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 15 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.states_id = ?
	order by 
		organisation
});

__PACKAGE__->set_sql(homestays_by_state => qq{
	select 
		vw_hoteldetails.addressbook_id 
	from
		vw_hoteldetails,
		addresscategories a1, 
		addresscategories a2
	where
		a1.categories_id = 27 and
		a2.categories_id = 33 and
		a1.addressbook_id = vw_hoteldetails.addressbook_id and
		a2.addressbook_id = vw_hoteldetails.addressbook_id and
		vw_hoteldetails.states_id = ?
	order by
		organisation
});

1;
