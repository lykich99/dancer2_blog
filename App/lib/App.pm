package App;
use Dancer2;
use Dancer2::Plugin::Passphrase;
use Dancer2::Plugin::Auth::Tiny;
use Dancer2::Plugin::Database;
#use Dancer2::Session::YAML;
use Dancer2::Core::Session;
use Data::Page;
use Dancer2::Logger::Console;
use Data::Pageset::Render;
use Data::Dumper;


our $VERSION = '0.1';
our $logger = Dancer2::Logger::Console->new;


get '/' => sub {
	my $last_post = database->prepare( 'SELECT * FROM blog order by date DESC limit 3' );
	   $last_post->execute() or die $DBI::errstr;
#	my $session = session;  
#	   $session->write('test_var', 'ky-ky');
#	print Dumper($session);
	
    template 'index', {
		'css_active' => 'about',
		'breadcrumb' => 'About Me',
		'rows'       => $last_post->fetchall_hashref('date'),
	}
};

get '/blog' => sub {
    my $sth = database->prepare( 'SELECT * FROM blog order by date DESC limit 4' );
	   $sth->execute() or die $DBI::errstr;
    my $pg = database->prepare( 'select count(*) from blog' );
       $pg->execute() or die $DBI::errstr;
    my ($pg_count) = $pg->fetchrow_array;
    my $carent_page = '1';  
    #my $session = session;   
   # print"blog ses :".Dumper($session);
    my $pager = get_paginator( $pg_count,4,1);
    my $href_p = "./blog/page/";	
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog',	
	  'rows'       => $sth->fetchall_hashref('id'),
	  'pager'      => $pager,
	  'href_p'     => $href_p
    }
};

get '/blog/page/:name' => sub {
    my $param_page = params->{name};   
    my $step_p;
    if( $param_page != 1 ) {
        $step_p = ( $param_page - 1 )*4;
     } else {
		$step_p = 1;
	 }	 
    my $sth = database->prepare( "SELECT * FROM blog WHERE id >= '$step_p' ORDER BY date limit 4" );
       $sth->execute() or die $DBI::errstr;
    my $pg = database->prepare( 'select count(*) from blog' );
       $pg->execute() or die $DBI::errstr;
    my ($pg_count) = $pg->fetchrow_array;
    my $carent_page = '1';    
    my $pager = get_paginator( $pg_count,4,$param_page);
    my $href_p = "";
    my $h_b = "blog/";
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog',	
	  'rows'       => $sth->fetchall_hashref('id'),
	  'pager'      => $pager,
	  'hb'         => $h_b,
	  'href_p'     => $href_p

    }   
};

get '/blog/:name' => sub {
	 my $post_date = params->{name};
	 my $post = database->prepare( "SELECT * FROM blog WHERE date = '$post_date'" );
	    $post->execute() or die $DBI::errstr;
     my $cat = database->prepare( "SELECT * FROM categories" );
        $cat->execute() or die $DBI::errstr;
     my $post4 = database->prepare( "SELECT h1,date FROM blog ORDER by date DESC limit 4" );  
        $post4->execute() or die $DBI::errstr;
     my $p_ar = database->prepare( "SELECT DISTINCT DATE_FORMAT(date,'%M %Y') as ym FROM blog order by date limit 12" );
        $p_ar->execute() or die $DBI::errstr;
     my $href_b = "blog/";   
	 template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog post',
	  'rows'       => $post->fetchrow_hashref,
	  'rows_c'     => $cat->fetchall_hashref('id'), 
	  'rows_post4' => $post4->fetchall_hashref('h1'),
	  'rows_ar'    => $p_ar->fetchall_hashref('ym'),
	  'href_b'     => $href_b
     }		    
	    
};


get '/blog/categories/:name' => sub {
    my $post_cat = params->{name};
    my $p_cat = database->prepare( "SELECT h1,img_link,date,small_post,big_post FROM blog as b,categories as c WHERE b.categories_id=c.id AND c.categories_name='$post_cat' ORDER by date DESC limit 4" );
       $p_cat->execute() or die $DBI::errstr;
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Categories',
      'rows_cat'   => $p_cat->fetchall_hashref('h1')		
    }
};


get '/blog/archive/:name' => sub {
    my $post_arch = params->{name};    
    my $s_arch = database->prepare( "SELECT * FROM blog WHERE date BETWEEN DATE_FORMAT((STR_TO_DATE('$post_arch','%M %Y')),'%Y-%m-01 00:00:00') AND DATE_FORMAT(LAST_DAY(DATE_FORMAT((STR_TO_DATE('$post_arch','%M %Y')),'%Y-%m-01 00:00:00')),'%Y-%m-%d 23:59:59') ORDER by date DESC limit 4" );
       $s_arch->execute() or die $DBI::errstr;
       
    template 'index', {
	   'css_active' => 'blog',
	   'breadcrumb' => 'Archive',
	   'rows_arch'  => $s_arch->fetchall_hashref('id')
    }
};

get '/contact' => sub {
   template 'index', {
	  'css_active' => 'contact',
	   'breadcrumb' => 'Contact'	
   }
};


get '/admin' => needs login => sub {
    template 'admin', {},{ layout => 'admin' }	


};

get '/login' => sub {	
    template 'login', {},{ layout => 'main' }	
};

post '/login' => sub {
    my $username  = param('username');
    my $sql = "SELECT password FROM users WHERE username='$username'";
    my $sth = database->prepare( $sql ); 
      $sth->execute() or die $DBI::errstr;
    my $pass_from_db = $sth->fetch->[0];  
    if ( passphrase( param('password') )->matches( $pass_from_db ) ) {
        session user => $username;
  	    debug( "Login succsess" .$username );
  	    redirect '/admin';
     } else {
		debug( "Login failed - password incorrect for " .$username );
        redirect '/login';
     }
};
#*******************************************************************************
# Uncomment this use route /secret and create login and password.              #
# This step add data login and password for table users                        #
#*******************************************************************************
#get '/secret' => sub {
#	template 'secret', {},{ layout => 'main' }	
#};

#post '/secret' => sub {
#    my $username  = param('username');
#    my $password  = passphrase( param('password') )->generate;
#    my $pass = $password->rfc2307();
#    my $sth = database->prepare( "INSERT INTO users VALUES('','$username','$pass')" );
#       $sth->execute() or die $DBI::errstr;
#       return "Password create";
#};

sub get_paginator {

    my ( $pg_count,$ent_p,$curr_p ) = @_; 
    my $pager = Data::Pageset::Render->new( {
       total_entries    => $pg_count,
       entries_per_page => $ent_p,
       current_page     => $curr_p,
       pages_per_set    => 5,
       mode             => 'slider'
       });

    return $pager;

}


true;
