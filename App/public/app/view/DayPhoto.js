Ext.define('AM.view.DayPhoto', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.dayPhoto',
    name: 'dayPhoto',
    //title: 'About',
    html: 'Day Photo',
    layout: 'fit',
    initComponent: function() {
		
		       this.items = [
        {
            xtype: 'form',
            name: 'downlod_form_day_photo',
            bodyPadding: 10,
            border: false,
            fieldDefaults: {
                    labelAlign: 'top',
                    labelWidth: 300
                },
            items: [
            {
                xtype: 'displayfield',
                fieldLabel: 'Day Photo download form',
                labelAlign: 'left',
                labelStyle: 'color: green; font-weight: bold;',
                name: 'id'
            },
            {
                xtype: 'fieldset',
                items: [
                         {
						   xtype: 'filefield',
						   emptyText: 'Select an image',
						   fieldLabel: 'Photo',
						   name: 'day-photo',
						   width: 450,
						   allowBlank: false,
						   regex: (/.(gif|jpg|jpeg|png)$/i),
                           regexText: 'Only image files allowed for upload'
					     },
					     {
                           xtype: 'textfield',
                           name : 'title',
                           fieldLabel: 'Title',
                           allowBlank: false,
                           width: 450
                         },
                         {
                           xtype: 'textfield',
                           name : 'alt',
                           fieldLabel: 'Alt',
                           allowBlank: false,
                           width: 450
                         },
					     {
                           xtype: 'button',
                           iconCls: 'icon-save',
                           action: 'save',
                           text: 'Save',
                           width: 100
                         },
                         {
                           xtype: 'button',
                           action: 'cancel',
                           iconCls: 'icon-reset',
                           text: 'Cancel',
                           margin: '10',
                           width: 100
                         }
                      ]
            }
                    
            ]
        }
        ];
		
        this.callParent(arguments);
    }
});
