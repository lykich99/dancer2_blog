# dancer2_blog
Dancer2 blog, responsive web design bootstrap
#-------------------------------------------

This is not finished relise. Every day more code. <a href="ylukashov.tk"> This example you can see.</a>


#----------------------------------------------
  1. Copy for this repository in directory accessible to the Web server.
     I use plack for the debug and develop example below.
     cd App/
     plackup -r ./bin/app.psgi 
     After run you can see HTTP::Server::PSGI: Accepting connections at http://0:5000/
     In the production I use fcgi. Below my http.conf
       
     <VirtualHost *:80>
		  ServerName ylukashov.my
		  UseCanonicalName on
		  ServerAlias www.ylukashov.my
		  DocumentRoot /home/www/ylukashov/ylukashov.tk/www/App  
          ScriptAlias / /home/www/ylukashov/ylukashov.tk/www/App/public/dispatch.fcgi/
     </VirtualHost>
     
   2. Create table for mysql.
      
      CREATE TABLE `blog` (
		  `id` int(10) NOT NULL,
		  `h1` char(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
		  `img_link` char(20) NOT NULL,
		  `date` datetime NOT NULL,
		  `small_post` varchar(255) NOT NULL,
		  `big_post` text NOT NULL,
		  `categories_id` int(10) NOT NULL,
		  KEY `date` (`date`),
		  KEY `categories_id` (`categories_id`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Content for blog';
        
      For test you can use the data dump blog.sql
       mysql -u user -p blog < blog.sql
      
    3. Configure file config.yml for connect to database.
       
       database: 'you database'
       host: 'you host'
       username: 'user for connect'
       password: 'password for conect'
      
 
      
       
      


