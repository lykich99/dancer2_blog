Ext.define('AM.controller.Main', {
    extend: 'Ext.app.Controller',
    views: [ 'MenuTree','BlogPanel','BlogGrid','GridForm' ],
    stores: [ 'MenuStore','BlogStore' ],
    models: [ 'MenuModel','BlogModel' ],
    init: function() {
        
          this.control({
            'viewport > panel': {
                render: this.onPanelRendered
            },
            'blogGrid dataview': {
                itemdblclick: this.editGrid
            }
            
            
         });
        
         },
      
    editGrid: function(grid, record) {    
       var edit = Ext.create('AM.view.GridForm').show();
       if(record){
        	edit.down('form').loadRecord(record);
        }
       
    },
      
             
    onPanelRendered: function() {
        console.log('The panel was rendered');
    }
         
         
});
