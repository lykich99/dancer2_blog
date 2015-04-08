Ext.define('AM.view.UploadForm', {
    extend: 'Ext.window.Window',
    alias : 'widget.uploadform',

    requires: ['Ext.form.Panel','Ext.form.field.Text'],

    title : 'Upload file',
    layout: 'fit',
    autoShow: true,
    width: 580,
    modal: true,
    
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
						height: 100,
						fieldDefaults: {
							labelAlign: 'left',
							allowBlank: false,
							combineErrors: true,
							msgTarget: 'side'
							},
					         
                    items: [   
							  {
								xtype: 'filefield',
								id: 'form-file',
								emptyText: 'Select an image',
								fieldLabel: 'Photo',
								name: 'photo-path'
							  }
						  ]
                }
        ];
        
        this.dockedItems = [{
            xtype: 'toolbar',
            dock: 'bottom',
            id:'buttonsUpload',
            ui: 'footer',
            items: ['->', {
                iconCls: 'icon-save',
                text: 'Save',
                action: 'saveFile'
            },{
                iconCls: 'icon-reset',
                text: 'Close',
                //actions:'canselUpload'
                scope: this,
                handler: this.close
            }]
        }];

        this.callParent(arguments);
    }
});
