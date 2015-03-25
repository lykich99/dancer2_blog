Ext.define('AM.model.MenuModel', {
    extend: 'Ext.data.Model',
    fields: ['id', 'text'],
    
    proxy: {
        type: 'ajax',
        url: './data/menu.json',
        reader: {
            type: 'json',
            root: 'results'
        }
    }
});
