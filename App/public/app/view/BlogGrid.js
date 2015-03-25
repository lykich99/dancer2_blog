Ext.define('AM.view.BlogGrid', {
    extend: 'Ext.ux.LiveSearchGridPanel',
    alias: 'widget.blogGrid',
    autoScroll: true,
    store: 'BlogStore',
    //    forceFit: true,
    title : 'Blog post',
    iconCls: 'icon-grid',
    //split: true,    

  columns: [
{
            header: 'id',  
            dataIndex: 'id',  
            width: 40
        },{
            header: 'h1', 
            dataIndex: 'h1', 
            width: 180
        },{
            header: 'img_link', 
            dataIndex: 'img_link', 
            width: 120
        },{
            header: 'date', 
            dataIndex: 'date', 
            width: 80
        },{
            header: 'small_post', 
            dataIndex: 'small_post', 
            width: 200
        },{
            header: 'big_post', 
            dataIndex: 'big_post', 
            width: 630
        },{
            header: 'categories_id', 
            dataIndex: 'categories_id', 
            flex: 1 
        }


	],


    initComponent: function() {
       /* this.columns = [
        {
            header: 'id',  
            dataIndex: 'id',  
            width: 40
        },{
            header: 'h1', 
            dataIndex: 'h1', 
            width: 180
        },{
            header: 'img_link', 
            dataIndex: 'img_link', 
            width: 120
        },{
            header: 'date', 
            dataIndex: 'date', 
            width: 80
        },{
            header: 'small_post', 
            dataIndex: 'small_post', 
            width: 200
        },{
            header: 'big_post', 
            dataIndex: 'big_post', 
            width: 630
        },{
            header: 'categories_id', 
            dataIndex: 'categories_id', 
            flex: 1 
        }];*/
         
        this.dockedItems = [{
            xtype: 'toolbar',
            items: [{
                iconCls: 'icon-save',
                itemId: 'add',
                text: 'Save',
                action: 'add'
            },{
                iconCls: 'icon-delete',
                text: 'Delete',
                action: 'delete'
            }]
        },
        {
            xtype: 'pagingtoolbar',
            dock:'top',
            store: 'BlogStore',
            displayInfo: true,
            displayMsg: 'Show {0} - {1} of {2} rows',
            emptyMsg: "Not row what"
        }];
         
         
         
        this.callParent(arguments);
    }
});
