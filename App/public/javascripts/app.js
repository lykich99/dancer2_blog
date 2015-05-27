/*
    This file is generated and updated by Sencha Cmd. You can edit this file as
    needed for your application, but these edits will have to be merged by
    Sencha Cmd when upgrading.
*/
Ext.application({
    requires: ['Ext.container.Viewport', 'Ext.ux.CheckColumn', 'Ext.ux.LiveSearchGridPanel'],
    name: 'AM',

    appFolder: 'app',

       controllers: [
        'Main'
    ],


    launch: function() {
        Ext.create('Ext.container.Viewport', {
            layout: 'fit',
            items: [
                {
                    xtype: 'panel',
                    title: 'Admins for blog',
                    layout: 'border',
                    items: [
                     {
                       xtype: 'panel',
                       region: 'west',
                       animCollapse: true,
                       width: 200,
                       minWidth: 150,
                       maxWidth: 400,
                       split: true,
                       collapsible: true,
                       layout: 'fit',
                     items: [
                       {
                          xtype: 'menuTree'
                       } 
                     ] 
                   },
                   {
                     xtype: 'tabpanel',
                     region: 'center',
                     tabBar: {
                        hidden: true
                     },
                     items: [
						   {
							 xtype: 'blogGrid'
						   },
						   {
							 xtype: 'dayPhoto'
						   }
                     ] 
                  }
                ]
                    
                    
                    
                }
            ]
        });
    }
});
