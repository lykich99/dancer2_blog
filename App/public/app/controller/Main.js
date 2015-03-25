Ext.define('AM.controller.Main', {
    extend: 'Ext.app.Controller',
    views: [ 'MenuTree','BlogPanel','BlogGrid' ],
    stores: [ 'MenuStore','BlogStore' ],
    models: [ 'MenuModel','BlogModel' ],
    init: function() {
        
          this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            }
         });
        
         },
             
    onPanelRendered: function() {
        console.log('The panel was rendered');
    }
         
         
});
