Ext.define('AM.store.BlogStore', {
    extend: 'Ext.data.Store',
    model: 'AM.model.BlogModel',
    autoLoad: true,   
    pageSize: 35,
    autoLoad: {start: 0, limit: 35}, 
    
    proxy: {
        type: 'ajax',
        api: {
            read:    './crud/read',
            update:  './crud/update',
            create:  './crud/create',
            destroy: './crud/delete'
        },

        reader: {
            type: 'json',
            root: 'blogrow',
            //idProperty: 'id',
            successProperty: 'success'
        },
        writer: {
            type: 'json',
            writeAllFields: true,
            encode: true,
            root: 'blogrow'
        },
    },
     
    
listeners: {
    'load' : function() {
        
    }}
     
    
    
});
