import:py flet as ft;


obj Task :ft.Column: {

    has task_name:str , task_status_change:Any, task_delete:Any;
    has completed:bool = False;

    can postinit;
    can edit_clicked(e:ft.ControlEvent);
    can save_clicked(e:ft.ControlEvent);
    can delete_clicked(e:ft.ControlEvent);
    can status_changed(e:ft.ControlEvent);
}



obj TodoApp:ft.Column:{
    can init();
    can add_clicked(e:ft.ControlEvent);
    can task_delete(task:Task);
    can task_status_change();
    can tabs_changed(e:ft.ControlEvent);
    can clear_clicked(e:ft.ControlEvent);

    can before_update();
}


can main(page: ft.Page) {
    page.title = "To-Do App";
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER;
    page.update();

    # create application instance
    app = TodoApp();

    # add application's root control to the page
    page.add(app);
}

with entry{
    ft.app(main);
}