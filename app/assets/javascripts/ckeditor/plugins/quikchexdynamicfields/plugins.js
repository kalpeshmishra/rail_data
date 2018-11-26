CKEDITOR.plugins.add( 'quikchexdynamicfields', {
    init: function(editor){

        editor.addCommand("openDynamicFieldsModal", {
            exec: function(editor){
                // app.globals.dynamicFields.render()
                $('#quikchex-dynamic-fields').modal('show');

            }
        });

        editor.ui.addButton("QuikchexDynamicFields", {
            label: "Quikchex Dynamic Fields",
            command: "openDynamicFieldsModal",
            icon: this.path + "icons/quikchexdynamicfields-chevrons.png"
        });
    }
});