Ext.define('AM.view.BlogPanel', {
    extend: 'Ext.panel.Panel',
    alias: 'widget.blogPanel',
    layout: 'card',
    name: 'blogPanel',
    items: [
     {
        xtype: 'blogGrid',
        height: 300,
     }

    ],
    initComponent: function() {
        this.callParent(arguments);
    }
});
