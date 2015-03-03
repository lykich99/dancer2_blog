package App;
use Dancer2;
use Dancer2::Plugin::Database;
use Data::Page;
use Dancer2::Logger::Console;
use Data::Dumper;

our $VERSION = '0.1';
our $logger = Dancer2::Logger::Console->new;



get '/' => sub {
	my $last_post = database->prepare( 'SELECT * FROM blog order by date limit 3' );
	   $last_post->execute() or die $DBI::errstr;
	       
    template 'index', {
		'css_active' => 'about',
		'breadcrumb' => 'About Me',
		'rows'       => $last_post->fetchall_hashref('id'),
	}
};

get '/blog' => sub {
	
    my $sth = database->prepare( 'SELECT * FROM blog limit 4' );
	   $sth->execute() or die $DBI::errstr;
    my $pg = database->prepare( 'select count(*) from blog' );
       $pg->execute() or die $DBI::errstr;
    my ($pg_count) = $pg->fetchrow_array;
    my $carent_page = '1';
    my $page = Data::Page->new( $pg_count, 4, $carent_page );
    	
    #print "MAPPING:" . Dumper($page);	
    #print "Entries:", $page->total_entries, "\n";
    #print "Pages range to: ", $page->last_page, "\n";
    #print "Pages range to: ", $page->last_page, "\n";
    	
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog',	
	  'rows'       => $sth->fetchall_hashref('id'),
	  'c_page'     => $page->current_page,
    }
};

get '/blog/:name' => sub {
	 my $post_date = params->{name};
	 my $post = database->prepare( "SELECT * FROM blog WHERE date = '$post_date'" );
	    $post->execute() or die $DBI::errstr;
     my $cat = database->prepare( "SELECT * FROM categories" );
        $cat->execute() or die $DBI::errstr;
     my $post4 = database->prepare( "SELECT h1,date FROM blog ORDER by date limit 4" );  
        $post4->execute() or die $DBI::errstr;
     #my $p_ar = database->prepare('' );
     #   $p_ar->execute() or die $DBI::errstr;
        
	 template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Blog post',
	  'rows'       => $post->fetchrow_hashref,
	  'rows_c'     => $cat->fetchall_hashref('id'), 
	  'rows_post4' => $post4->fetchall_hashref('h1'),
     }		    
	    
};


get '/blog/categories/:name' => sub {
    my $post_cat = params->{name};
    my $p_cat = database->prepare( "SELECT h1,img_link,date,small_post,big_post FROM blog as b,categories as c WHERE b.categories_id=c.id AND c.categories_name='$post_cat' ORDER by date limit 4" );
       $p_cat->execute() or die $DBI::errstr;
    template 'index', {
	  'css_active' => 'blog',
	  'breadcrumb' => 'Categories',
      'rows_cat'   => $p_cat->fetchall_hashref('h1')		
    }
};


get '/blog/archive/:name' => sub {






};

get '/contact' => sub {
   template 'index', {
	  'css_active' => 'contact',
	   'breadcrumb' => 'Contact'	
		
		
   }
};


true;
