import flet as ft
from components.navbar import Navbar

def dashboard_view(page: ft.Page):
    """
    Crea y retorna la vista principal del dashboard.
    """

    # Contenedor para el contenido principal que cambiará dinámicamente
    main_content = ft.Container(
        content=ft.Text("Selecciona una opción del menú de la izquierda"),
        expand=True,
        padding=20,
        alignment=ft.alignment.top_left,
    )

    def change_view_content(selected_index: int):
        """
        Cambia el contenido de `main_content` basado en la selección del NavigationRail.
        """
        if selected_index == 0:
            main_content.content = ft.Column([
                ft.Text("Vista Principal del Dashboard", size=24, weight=ft.FontWeight.BOLD),
                ft.Text("Aquí irían las estadísticas y gráficos principales.")
            ])
        elif selected_index == 1:
            main_content.content = ft.Text("Gestión de Usuarios", size=24)
        elif selected_index == 2:
            main_content.content = ft.Text("Gestión de Roles", size=24)
        elif selected_index == 3:
            main_content.content = ft.Text("Gestión de Menús", size=24)

        page.update()

    # El layout principal de la vista
    layout = ft.Row(
        [
            Navbar(page=page, on_change_view=change_view_content),
            ft.VerticalDivider(width=1),
            main_content,
        ],
        expand=True,
    )

    return ft.View(
        route="/dashboard",
        controls=[
            ft.AppBar(
                title=ft.Text("Admin Dashboard"),
                bgcolor=ft.colors.SURFACE_VARIANT
            ),
            layout,
        ]
    )
