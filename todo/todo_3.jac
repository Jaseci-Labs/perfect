import:py flet as ft ;

obj TodoApp :ft.Column: {
    can init(){
        super.init();
        self.new_task = ft.TextField(hint_text="What needs to be done?", expand=True);
        self.tasks_view = ft.Column();
        self.width = 600;
        self.controls = [
            ft.Row(
                controls=[
                    self.new_task,
                    ft.FloatingActionButton(
                        icon=ft.icons.ADD, on_click=self.add_clicked
                    )
                ]
            ),
            self.tasks_view
        ];
    }

    can add_clicked(e:flet_core.control_event.ControlEvent){
        self.tasks_view.controls.append(ft.Checkbox(label=self.new_task.value));
        self.new_task.value = "";
        self.update();
    }
}

can main(page: ft.page){
    page.title = "To-Do App";
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER;
    page.update();

    app_1 = TodoApp();

    page.add(app_1);
}

with entry{
    ft.app(main);
}