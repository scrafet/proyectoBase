import flet as ft

def dashboard_view():
    """
    Crea y retorna la vista del Dashboard.
    """
    return ft.View(
        route="/dashboard",
        controls=[
            ft.AppBar(title=ft.Text("Dashboard"), bgcolor=ft.colors.SURFACE_VARIANT),
            ft.Column(
                [
                    ft.Text("Bienvenido al Dashboard", size=30)
                ],
                alignment=ft.MainAxisAlignment.CENTER,
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                expand=True,
            )
        ]
    )
