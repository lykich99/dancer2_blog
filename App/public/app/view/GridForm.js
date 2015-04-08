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
                fieldDefaults: {
                    labelAlign: 'left',
                    //allowBlank: false,
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
                        fieldLabel: 'h1',
                        allowBlank: false
                     },
                     {
                        xtype: 'textfield',
                        id: 'img_link',
                        name : 'img_link',
                        fieldLabel: 'img_link',
                        allowBlank: false
                      },
                      {
                        xtype: 'textfield',
                        id:'date',
                        name : 'date',
                        fieldLabel: 'date',
                         hidden: true
                      },
                       {
                        xtype: 'textareafield',
                        name : 'small_post',
                        fieldLabel: 'small_post',
                        anchor    : '100%',
					    grow      : true,
					    allowBlank: false
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
					    grow      : true,
					    allowBlank: false
					  },     
		               {
						 margin: '0 0 0 105',
						 xtype: 'button',
						 hidden: true,
						 id:'addfile',
						 itemId: 'addfile',
						 action: 'addfile',
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
