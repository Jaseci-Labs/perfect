import flet as ft

def main(page: ft.Page):
    def add_clicked(e):
        print(type(e))
        page.add(ft.Checkbox(label=new_task.value))
        new_task.value = ""
        page.update()

    new_task = ft.TextField(hint_text="What's needs to be done?")

    page.add(new_task, ft.FloatingActionButton(icon=ft.icons.ADD, on_click=add_clicked))

ft.app(main)