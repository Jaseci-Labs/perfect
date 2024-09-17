:obj:Task:can:postinit{
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

:obj:Task:can:edit_clicked(e:ft.ControlEvent){
        self.edit_name.value = self.display_task.label;
        self.display_view.visible = False;
        self.edit_view.visible = True;
        self.update();
    }

:obj:Task:can:save_clicked(e:ft.ControlEvent){
        self.display_task.label = self.edit_name.value;
        self.display_view.visible = True;
        self.edit_view.visible = False;
        self.update();
    }

:obj:Task:can:delete_clicked(e:ft.ControlEvent){
        self.task_delete(self);
    }

:obj:Task:can:status_changed(e:ft.ControlEvent){
        self.completed = self.display_task.value;
        self.task_status_change();
    }