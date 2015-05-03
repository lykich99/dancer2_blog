# dancer2_blog
Dancer2 blog, responsive web design bootstrap, Admin for ExtJS 4.2 mvc<br>
Admin access for url ./admin<br>
Access for ./admin through ./login<br>
#-------------------------------------------

This is not finished relise. Every day more code. <a href="http://ylukashov.tk"> This example you can see.</a>


#----------------------------------------------
  A. Copy for this repository in directory accessible to the Web server.<br>
     I use plack for the debug and develop example below.<br>
     cd App/<br>
     plackup -r ./bin/app.psgi<br> 
     After run you can see HTTP::Server::PSGI: Accepting connections at http://0:5000/<br>
     In the production I use fcgi. Below my http.conf<br>
      <br>
     \<VirtualHost *:80\><br>
		  ServerName ylukashov.tk<br>
		  UseCanonicalName on<br>
		  ServerAlias www.ylukashov.tk<br>
		  DocumentRoot /home/www/ylukashov/ylukashov.tk/www/App  <br>
          ScriptAlias / /home/www/ylukashov/ylukashov.tk/www/App/public/dispatch.fcgi/<br>
     \</VirtualHost\><br>
     <br>
   B. Create table for mysql.
  
         CREATE TABLE `blog` (
               `id` int(11) NOT NULL AUTO_INCREMENT,
               `h1` char(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
               `img_link` char(40) NOT NULL,
               `date` datetime NOT NULL,
               `small_post` varchar(255) NOT NULL,
               `big_post` text NOT NULL,
               `categories_id` int(10) NOT NULL,
               PRIMARY KEY (`id`),
               KEY `date` (`date`),
               KEY `categories_id` (`categories_id`)
              ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Content for blog' 
              
        CREATE TABLE `categories` (
		  `id` int(10) NOT NULL AUTO_INCREMENT,
	           `categories_name` char(20) NOT NULL,
  		   PRIMARY KEY (`id`),
  		   UNIQUE KEY `categories_name` (`categories_name`)
            ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8
        
        CREATE TABLE `users` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `username` varchar(32) NOT NULL,
                  `password` varchar(100) DEFAULT NULL,
                   PRIMARY KEY (`id`),
                   UNIQUE KEY `username` (`username`)
               ) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8      

  
      For test you can use the data dump blog.sql<br>
       mysql -u user -p blog < blog.sql<br>
      <br>
    C. Configure file config.yml for connect to database.<br>
       <br>
       database: 'you database'<br>
       host: 'you host'<br>
       username: 'user for connect'<br>
       password: 'password for conect'<br>
       
    D. For access to /admin  I use Dancer2::Plugin::Passphrase.
       You have to create login and password and add to table users.
       You can make this uncomment route /secret in App.pm.<br>
     
    E. For the comment I use disqus. You can make account this disqus 
       and change javascript code in the index.tt for you javacript code.

      
 
      
       
      


