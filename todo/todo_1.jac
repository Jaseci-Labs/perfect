import:py flet as ft ;

can main(page: ft.page){
    can add_clicked(e:flet_core.control_event.ControlEvent){
        page.add(ft.Checkbox(label=new_task.value));
        new_task.value = "";
        page.update();
    }

    new_task = ft.TextField(hint_text="What's needs to be done?");

    page.add(new_task, ft.FloatingActionButton(icon=ft.icons.ADD, on_click=add_clicked));
}

with entry{
    ft.app(main);
}

