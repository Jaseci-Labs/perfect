import:py flet as ft;


obj Task : ft.Column : {
    can init(task_name: str, task_status_change: Any, task_delete: Any) {
        super.init();
        self.completed = False;
        self.task_name = task_name;
        self.task_status_change = task_status_change;
        self.task_delete = task_delete;
        self.display_task = ft.Checkbox(
            value=False,
            label=self.task_name,
            on_change=self.status_changed
        );
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

    can edit_clicked(e: ft.ControlEvent) {
        self.edit_name.value = self.display_task.label;
        self.display_view.visible = False;
        self.edit_view.visible = True;
        self.update();
    }

    can save_clicked(e: ft.ControlEvent) {
        self.display_task.label = self.edit_name.value;
        self.display_view.visible = True;
        self.edit_view.visible = False;
        self.update();
    }

     can status_changed() {
        self.completed = self.display_task.value
        self.task_status_change();
    }

    can delete_clicked() {
        self.delete();
    }
}


obj TodoApp : ft.Column : {
    can init() {
        self.new_task = ft.TextField(hint_text="What needs to be done?", expand=True);
        self.tasks = ft.Column();
        
        self.filter = ft.Tabs(
            selected_index=0,
            on_change=self.tabs_changed,
            tabs=[ft.Tab(text="all"), ft.Tab(text="active"), ft.Tab(text="completed")],
        );

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
            ft.Column(
                spacing=25,
                controls=[
                    self.filter,
                    self.tasks,
                ]
            )
        ];
    }

    can add_clicked() {
        task = Task(self.new_task.value, self.task_status_change, self.task_delete);
        self.tasks.controls.append(task);
        self.new_task.value = "";
        self.update();
    }

    can task_status_change():
        self.update();

    can task_delete(task: Task) {
        self.tasks.controls.remove(task);
        self.update();
    }

    can before_update(){
        status = self.filter.tabs[self.filter.selected_index].text;
        for task in self.tasks.controls{
            task.visible = (
                status == "all"
                or (status == "active" and task.completed == False)
                or (status == "completed" and task.completed)
            );
        }     
    }

    can tabs_changed(){
        self.update();
    }
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
    ft.app(target=main);
    }