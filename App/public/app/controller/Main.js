Ext.define('AM.controller.Main', {
    extend: 'Ext.app.Controller',
    views: [ 'MenuTree','BlogPanel','BlogGrid','GridForm','UploadForm' ],
    stores: [ 'MenuStore','BlogStore' ],
    models: [ 'MenuModel','BlogModel' ],
    init: function() {
        
          this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            },
            'blogGrid dataview': {
                itemdblclick: this.editGrid
            },
            'blogGrid button[action=add]': {
            	click: this.addNewPost
            },
            'gridform button[action=addfile]': {
            	click: this.addFile
            },
            //canselUpload
            'uploadform button[action=saveFile] ':{
                click: this.fileUpload
		    },
		   'gridform button[action=save]': {
            	click: this.saveDataForm
            }
            
         });
        
         },
      
    saveDataForm: function(b,e){
       var formAdd = b.up('window').down('form').getForm();
       var win    = b.up('window'),
           form   = win.down('form'),
           record = form.getRecord(),
           values = form.getValues();   

         if(formAdd.isValid()){
			record = Ext.create('AM.model.BlogModel');
			record.set(values);
			this.getBlogStoreStore().add(record);	
			this.getBlogStoreStore().sync(); 
			this.getBlogStoreStore().load();
			win.close();
         }
    },
   
    addNewPost: function(a,b,c){
        var addForm   = Ext.create('AM.view.GridForm').show();
        var but       = Ext.getCmp('addfile');    
            but.show();               
    },
   
    fileUpload: function(a,filename){
       //var form = a.up('window').down('form').getForm();
       var win  = a.up('window'),
           form = win.down('form').getForm();
       var field_img =  Ext.getCmp('img_link');
       var but       =  Ext.getCmp('addfile');
            if(form.isValid()){
                    form.submit({
                        url: 'upload',
                        waitMsg: 'Uploading your photo...',
                        success: function(fp, o) {
                                   Ext.Msg.show({
										title: 'Success upload',
										msg: 'Upload foto: ' + o.result.file,
										minWidth: 300,
										modal: true,
										icon: Ext.Msg.INFO,
										buttons: Ext.Msg.OK
									});
                              field_img.setValue( "/img/blog/" + o.result.file );
                              but.setDisabled(true); 
                              win.close();
                            }
                     });
             }
    },
   
    addFile: function(a,b){
         var uploadForm = Ext.create('AM.view.UploadForm').show();
        /*var form = a.up('window').down('form');
          var fileUpload = {
            xtype: 'filefield',
            name: 'file' + this.attachPosition 
            };
        form.insert(this.attachPosition++, fileUpload);
        */ 
    },
   
    editGrid: function(grid, record) {    
       var edit = Ext.create('AM.view.GridForm').show();
       if(record){
        	edit.down('form').loadRecord(record);
        	var fieldDate = Ext.getCmp('date');
        	    fieldDate.show();
        }
       
    },
      
             
    onPanelRendered: function() {
        console.log('The panel was rendered');
    }
              
         
});
