# dancer2_blog
Dancer2 blog, responsive web design bootstrap
#-------------------------------------------

This is not finished relise. Every day more code. <a href="ylukashov.tk"> This example you can see.</a>


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
   B. Create table for mysql.<br>
      <br>
      CREATE TABLE `blog` (<br>
		  `id` int(10) NOT NULL,<br>
		  `h1` char(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,<br>
		  `img_link` char(20) NOT NULL,<br>
		  `date` datetime NOT NULL,<br>
		  `small_post` varchar(255) NOT NULL,<br>
		  `big_post` text NOT NULL,<br>
		  `categories_id` int(10) NOT NULL,<br>
		  KEY `date` (`date`),<br>
		  KEY `categories_id` (`categories_id`)<br>
		) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Content for blog';<br>
        <br>
      For test you can use the data dump blog.sql<br>
       mysql -u user -p blog < blog.sql<br>
      <br>
    C. Configure file config.yml for connect to database.<br>
       <br>
       database: 'you database'<br>
       host: 'you host'<br>
       username: 'user for connect'<br>
       password: 'password for conect'<br>
      
 
      
       
      


