import:py flet as ft;

obj Task :ft.Column: {

    has task_name:str , task_status_change:Any, task_delete:Any;
    has completed:bool = False;
    has display_task:Any by postinit;
    has edit_name:Any by postinit;
    has display_view:Any by postinit;
    has edit_view:Any by postinit;
    has controls:list by postinit;

    can postinit(){
        super.init();
        self.display_task = ft.Checkbox(
            value=False, label=self.task_name, on_change=self.status_changed
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

    can edit_clicked(e:ft.ControlEvent){
        self.edit_name.value = self.display_task.label;
        self.display_view.visible = False;
        self.edit_view.visible = True;
        self.update();
    }

    can save_clicked(e:ft.ControlEvent){
        self.display_task.label = self.edit_name.value;
        self.display_view.visible = True;
        self.edit_view.visible = False;
        self.update();
    }

    can delete_clicked(e:ft.ControlEvent){
        self.task_delete(self);
    }

    can status_changed(e:ft.ControlEvent){
        self.completed = self.display_task.value;
        self.task_status_change();
    }
}

obj TodoApp:ft.Column:{
    
    can init(){
        super.init();
        self.new_task = ft.TextField(hint_text="What needs to be done?", expand=True);
        self.tasks = ft.Column();

        self.filter = ft.Tabs(
            selected_index=0,
            on_change=self.tabs_changed,
            tabs=[ft.Tab(text="all"), ft.Tab(text="active"), ft.Tab(text="completed")]
        );

        self.items_left = ft.Text("0 items left");

        self.width = 600;
        self.controls = [
            ft.Row(
                [ft.Text(value="Todos", theme_style=ft.TextThemeStyle.HEADLINE_MEDIUM)],
                alignment=ft.MainAxisAlignment.CENTER
            ),
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
                    ft.Row(
                        alignment=ft.MainAxisAlignment.SPACE_BETWEEN,
                        vertical_alignment=ft.CrossAxisAlignment.CENTER,
                        controls=[
                            self.items_left,
                            ft.OutlinedButton(
                                text="Clear completed", on_click=self.clear_clicked
                            )
                        ]
                    )
                ]
            )
        ];
    }

    can add_clicked(e:ft.ControlEvent){
        task = Task(self.new_task.value, self.task_status_change, self.task_delete);
        self.tasks.controls.append(task);
        self.new_task.value = "";
        self.update();
    }

    can task_delete(task:Task){
        self.tasks.controls.remove(task);
        self.update();
    }

    can task_status_change(){
        self.update();
    }

    can tabs_changed(e:ft.ControlEvent){
        self.update();
    }

    can clear_clicked(e:ft.ControlEvent){
        for task in self.tasks.controls[:]{
            if task.completed{
                self.task_delete(task);
            }
        }
    }

    can before_update(){
        status = self.filter.tabs[self.filter.selected_index].text;
        count = 0;
        for task in self.tasks.controls{
            task.visible = (
                status == "all"
                or (status == "active" and task.completed == False)
                or (status == "completed" and task.completed)
            );
            if not task.completed{
                count += 1;
            }
        }
        self.items_left.value = f"{count} active item(s) left";
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
    ft.app(main);
}