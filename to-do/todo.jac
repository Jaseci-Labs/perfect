import:py flet as ft;

obj TodoApp:ft.Column:{
    can init{
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

    can add_clicked(e:ft.ControlEvent){
        self.tasks_view.controls.append(ft.Checkbox(label=self.new_task.value));
        self.new_task.value = "";
        self.update();
    }
}


can main(page: ft.Page) {
    page.title = "To-Do App";
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER;
    page.update();

    # create application instance
    todo = TodoApp();

    # add application's root control to the page
    page.add(todo);
}

with entry{
    ft.app(main);
}
