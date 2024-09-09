import:py flet as ft ;

obj TodoApp :ft.Column: {
    can init(){
        super.init();
        self.new_task = ft.TextField(hint_text="What needs to be done?", expand=True);
        self.tasks = ft.Column();
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
            self.tasks
        ];
    }

    can add_clicked(e:flet_core.control_event.ControlEvent){
        task = Task(self.new_task.value, self.task_delete);
        self.tasks.controls.append(task);
        self.new_task.value = "";
        self.update();
    }

    can task_delete(task:Task){
        self.tasks.controls.remove(task);
        self.update();
    }
}

obj Task :ft.Column: {
    can init(task_name:str , task_delete:Any){
        super.init();
        self.task_name = task_name;
        self.task_delete = task_delete;
        self.display_task = ft.Checkbox(value=False, label=self.task_name);
        self.edit_name = ft.TextField(expand=1);

        self.display_view = ft.Row(
            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
            vertical_alignment=ft.CrossAxisAlignment.CENTER,
            controls=[
                self.display_task,
                ft.Row(
                    spacing=0,
                    controls=[
                        ft.IconButton(
                            icon=ft.icons.CREATE_OUTLINED,
                            tooltip="Edit To-Do",
                            on_click=self.edit_clicked
                        ),
                        ft.IconButton(
                            ft.icons.DELETE_OUTLINE,
                            tooltip="Delete To-Do",
                            on_click=self.delete_clicked
                        )
                    ]
                )
            ]
        );

        self.edit_view = ft.Row(
            visible=False,
            alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
            vertical_alignment=ft.CrossAxisAlignment.CENTER,
            controls=[
                self.edit_name,
                ft.IconButton(
                    icon=ft.icons.DONE_OUTLINE_OUTLINED,
                    icon_color=ft.colors.GREEN,
                    tooltip="Update To-Do",
                    on_click=self.save_clicked
                )
            ]
        );

        self.controls = [self.display_view, self.edit_view];
    }

    can edit_clicked(e:flet_core.control_event.ControlEvent){
        self.edit_name.value = self.display_task.label;
        self.display_view.visible = False;
        self.edit_view.visible = True;
        self.update();
    }

    can save_clicked(e:flet_core.control_event.ControlEvent){
        self.display_task.label = self.edit_name.value;
        self.display_view.visible = True;
        self.edit_view.visible = False;
        self.update();
    }

    can delete_clicked(e:flet_core.control_event.ControlEvent){
        self.task_delete(self);
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