:obj:TodoApp:can:init{
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

:obj:TodoApp:can:add_clicked(e:ft.ControlEvent){
        task = Task(self.new_task.value, self.task_status_change, self.task_delete);
        self.tasks.controls.append(task);
        self.new_task.value = "";
        self.update();
    }

:obj:TodoApp:can:task_delete(task:Task){
        self.tasks.controls.remove(task);
        self.update();
    }

:obj:TodoApp:can:task_status_change(){
        self.update();
    }

:obj:TodoApp:can:tabs_changed(e:ft.ControlEvent){
        self.update();
    }

:obj:TodoApp:can:clear_clicked(e:ft.ControlEvent){
        for task in self.tasks.controls[:]{
            if task.completed{
                self.task_delete(task);
            }
        }
    }

:obj:TodoApp:can:before_update{
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
