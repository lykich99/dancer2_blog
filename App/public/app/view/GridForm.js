Ext.define('AM.view.GridForm', {
    extend: 'Ext.window.Window',
    alias : 'widget.gridform',

    requires: ['Ext.form.Panel','Ext.form.field.Text'],

    title : 'Grid row',
    layout: 'fit',
    autoShow: true,
    width: 580,
    
    iconCls: 'icon-grid',

    initComponent: function() {
        this.items = [
            {
                xtype: 'form',
                layout: 'form',
                padding: '5 5 5 5',
                border: false,
                style: 'background-color: #fff;',
                width: 750,
               //height: 550,
                fieldDefaults: {
                    //anchor: '100%',
                    //labelWidth: 75,
                    labelAlign: 'left',
                    allowBlank: false,
                    combineErrors: true,
                    msgTarget: 'side'
                },

                items: [
					 {
					    xtype: 'textfield',
					    name : 'id',
					    fieldLabel: 'id',
					    hidden:true
					 },    
                     {
                        xtype: 'textfield',
                        name : 'h1',
                        fieldLabel: 'h1'
                     },
                     {
                        xtype: 'textfield',
                        name : 'img_link',
                        fieldLabel: 'img_link'
                      },
                      {
                        xtype: 'textfield',
                        name : 'date',
                        fieldLabel: 'date'
                      },
                       {
                        xtype: 'textareafield',
                        name : 'small_post',
                        fieldLabel: 'small_post',
                        anchor    : '100%',
					    grow      : true
                      },{
						title: 'HTML Editor',
						anchor: '100%',
						height: 250,
						xtype: 'htmleditor',
						fieldLabel: 'big_post',
						name : 'big_post'
					  },{
						xtype: 'textfield',
                        name : 'categories_id',
                        fieldLabel: 'categories_id',
                        anchor    : '100%',
					    grow      : true  
					  },/*{
                        xtype: 'filefield',
                        id: 'form-file',
                        emptyText: 'Select an image',
                        fieldLabel: 'Photo',
                        name: 'photo-path',
                        buttonText: '',
                        buttonConfig: {
                            iconCls: 'icon-add'
                         }
		               },*/      
		               {
						 margin: '0 0 0 105',
						 xtype: 'button',
						 text : 'Add file',
						 iconCls: 'icon-add' 
					    }
                             			    	  
                   ]
            }
        ];
        
        this.dockedItems = [{
            xtype: 'toolbar',
            dock: 'bottom',
            id:'buttons',
            ui: 'footer',
            items: ['->', {
                iconCls: 'icon-save',
                text: 'Save',
                action: 'save'
            },{
                iconCls: 'icon-reset',
                text: 'Cancel',
                scope: this,
                handler: this.close
            }]
        }];

        this.callParent(arguments);
    }
});
