package App;
use Dancer2;
use JSON qw( decode_json );
use Dancer2::Plugin::Ajax;
use Dancer2::Plugin::Passphrase;
use Dancer2::Plugin::Auth::Tiny;
use Dancer2::Core::Session;
use Dancer2::Plugin::Database;
#use Dancer2::Session::YAML;
use Data::Page;
use Dancer2::Logger::Console;
use Dancer2::Logger::Console::Colored;
use Data::Pageset::Render;
use Data::Dumper;

#use Dancer2::Plugin::Auth::Extensible;
#use Dancer2::Plugin::Auth::Extensible::Provider::Database;

our $VERSION = '0.1';
our $logger = Dancer2::Logger::Console::Colored->new;
our $title = "Yuriy Lukashov - blog engine";     


post '/upload' => needs login => sub {
    my $all_uploads  = request->uploads;
    my $upload = $all_uploads->{'photo-path'};
    my $blog_img_dir = config->{public_dir}."/img/blog/";
    my $result =  $upload->copy_to( $blog_img_dir.$upload->filename ); 
    return to_json { "success" => true, "result" => $result, "file" => $upload->filename };
};

ajax ['get', 'post' ] => '/crud/*' => needs login => sub { 
    my %params  = params(); 
      
    my ( $actions ) = splat;
    my $sql;  
    #********** READ DATA *************************************
    if ( $actions eq 'read' ) {
		  my $page  = $params{'page'};
          my $limit = $params{'limit'};
          my $start = $params{'start'};  
          my $between_two = $start + $limit; 
	      $sql = "SELECT * FROM blog WHERE id BETWEEN '$start' AND '$between_two' ORDER by date DESC";
	      my $st = database->prepare( $sql );
             $st->execute() or die $DBI::errstr;	 	  	 	
          my $r = $st->fetchall_arrayref({});
          my $stc = database->prepare( "SELECT COUNT(*) FROM blog ORDER by date DESC" );
             $stc->execute() or die $DBI::errstr;
          my ( $total ) = $stc->fetchrow_array;
           return to_json { "success" => true, total =>$total, blogrow => [ @$r] };
	 } elsif ( $actions eq 'update' ) {
    #********* UPDATE DATA ***********************************
          my $decoded = decode_json( %params->{'blogrow'});    
	  	  my $id              = $decoded->{'id'};
	  	  my $h1              = $decoded->{'h1'};
	  	  my $img_link       = $decoded->{'img_link'};
	  	  my $date            = $decoded->{'date'};
	  	  my $small_post     = $decoded->{'small_post'};
	  	  my $big_post       = $decoded->{'big_post'};
	  	  my $categories_id  = $decoded->{'categories_id'}; 
             $sql = "UPDATE blog SET  h1= '$h1', img_link = '$img_link',date = '$date', small_post = '$small_post', big_post = '$big_post',  categories_id = '$categories_id' WHERE  id ='$id'";
    	  my $st = database->prepare( $sql );
             $st->execute() or die $DBI::errstr;       
          return to_json { "success" => true, categories_id =>$categories_id };
    
    #******** INSERT DATA ************************************ 	   
	 } elsif ( $actions eq 'create' ) {
		  my $decoded = decode_json( %params->{'blogrow'});    
	  	  #print Dumper($decoded);
	  	  my $id              = $decoded->{'id'};
	  	  my $h1              = $decoded->{'h1'};
	  	  my $img_link       = $decoded->{'img_link'};
	  	  my $date            = $decoded->{'date'};
	  	  my $small_post     = $decoded->{'small_post'};
	  	  my $big_post       = $decoded->{'big_post'};
	  	  my $categories_id  = $decoded->{'categories_id'};  	  
             database->do("INSERT INTO blog VALUES( '','$h1','$img_link',NOW(),'$small_post','$big_post','$categories_id')");
	      return to_json { "success" => true, categories_id =>$categories_id };
	 } else {
	   $sql = "DELETE FROM blog WHERE id=''";
     }	 
    
};
    
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
		'title'      => $title
	}
};

get '/blog' => sub {
		
    my $sth = database->prepare( 'SELECT * FROM blog order by date DESC limit 4' );
	   $sth->execute() or die $DBI::errstr;
    my $pg = database->prepare( 'select count(*) from blog' );
       $pg->execute() or die $DBI::errstr;
    my ($pg_count) = $pg->fetchrow_array;
    my $carent_page = '1';  
    my $pager = get_paginator( $pg_count,4,1);
    my $href_p = "./blog/page/";	
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog',	
	  'rows'       => $sth->fetchall_arrayref({}),
	  'pager'      => $pager,
	  'href_p'     => $href_p,
	  'title'      => $title
    }   
};

get '/blog/page/:name' => sub {
    my $param_page = params->{name};   
    my ( $step_p, $sql );
    #********* All blog rows ********************************
    my $pg = database->prepare( 'select count(*) from blog' );
       $pg->execute() or die $DBI::errstr;
    my ($pg_count) = $pg->fetchrow_array;
    #********************************************************
   
    if( $param_page != 1 ) {
        my $limit = 4;         # limit blog post for page
        $step_p = ( $limit * $param_page ) - $limit;
        if ( $step_p <= 0 ) {
			$step_p = 4;	
		} 		
        $sql = "SELECT * FROM blog ORDER BY date DESC limit $step_p,4";
        #$logger->debug($sql); 
     } else {
		$step_p = 1;
	    $sql = "SELECT * FROM blog WHERE id >= '$step_p' ORDER BY date DESC limit 4";	
	 }	  
    my $sth = database->prepare( $sql );
       $sth->execute() or die $DBI::errstr;
    my $carent_page = '1';    
    my $pager = get_paginator( $pg_count,4,$param_page);
    my $href_p = "";
    my $h_b = "blog/";
    local $title = "Yuriy Lukashov - blog page ".$param_page;  
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog',	
	  'rows'       => $sth->fetchall_arrayref({}),
	  'pager'      => $pager,
	  'hb'         => $h_b,
	  'href_p'     => $href_p,
	  'title'      => $title
    }   
};

get '/blog/:name' => sub {
	 my $post_date = params->{name};
	 my $post = database->prepare( "SELECT * FROM blog WHERE date = '$post_date'" );
	    $post->execute() or die $DBI::errstr;   
	    #rediret for start page blog if database have not data
	    unless( $post-> rows ) {  redirect './blog'; };
     my $cat = database->prepare( "SELECT * FROM categories" );
        $cat->execute() or die $DBI::errstr;
     my $post4 = database->prepare( "SELECT h1,date FROM blog ORDER by date DESC limit 4" );  
        $post4->execute() or die $DBI::errstr;
     my $p_ar = database->prepare( "SELECT DISTINCT DATE_FORMAT(date,'%M %Y') as ym FROM blog order by date DESC limit 12" );
        $p_ar->execute() or die $DBI::errstr;
     my $stm = database->prepare( "SELECT h1 FROM blog WHERE date = '$post_date'" );
        $stm->execute() or die $DBI::errstr; 
     my ( $title_meta ) = $stm->fetchrow_array;
     local $title = $title." ".$title_meta;
     my $href_b = "blog/";   
	 template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog post',
	  'rows'       => $post->fetchrow_hashref,
	  'rows_c'     => $cat->fetchall_hashref('id'), 
	  'rows_post4' => $post4->fetchall_arrayref({}),
	  'rows_ar'    => $p_ar->fetchall_arrayref({}),
	  'href_b'     => $href_b,
	  'title'      => $title
     }		    
	    
};


get '/blog/categories/:name' => sub {
    my $post_cat = params->{name};
    #TODO make pagination for this
    my $p_cat = database->prepare( "SELECT h1,img_link,date,small_post,big_post FROM blog as b,categories as c WHERE b.categories_id=c.id AND c.categories_name='$post_cat' ORDER by date DESC" );
       $p_cat->execute() or die $DBI::errstr;
    local $title = $title." categories ".$post_cat;    
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Categories',
      'rows_cat'   => $p_cat->fetchall_arrayref({}),
      'title'      => $title		
    }
};


get '/blog/archive/:name' => sub {
	#TODO make pagination for this
    my $post_arch = params->{name};    
    my $s_arch = database->prepare( "SELECT * FROM blog WHERE date BETWEEN DATE_FORMAT((STR_TO_DATE('$post_arch','%M %Y')),'%Y-%m-01 00:00:00') AND DATE_FORMAT(LAST_DAY(DATE_FORMAT((STR_TO_DATE('$post_arch','%M %Y')),'%Y-%m-01 00:00:00')),'%Y-%m-%d 23:59:59') ORDER by date DESC" );
       $s_arch->execute() or die $DBI::errstr;
    local $title = $title." archive ".$post_arch;   
    template 'index', {
	   'css_active' => 'blog',
	   'breadcrumb' => 'Archive',
	   'rows_arch'  => $s_arch->fetchall_arrayref({}),
	   'title'      => $title
    }
};

get '/contact' => sub {
   template 'index', {
	  'css_active' => 'contact',
	   'breadcrumb' => 'Contact'	
   }
};


get '/admin' => needs login => sub {
#get '/admin' => sub {	
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
