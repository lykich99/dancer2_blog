Ext.define('AM.store.MenuStore', {
    extend: 'Ext.data.TreeStore',
    model: 'AM.model.MenuModel',
    root: {
        text: 'Menu',
        id: 'src',
        expanded: true
    }
    
});
