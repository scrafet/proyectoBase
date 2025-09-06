import flet as ft

def Navbar(page: ft.Page, on_change_view):
    """
    Crea y retorna una barra de navegación lateral (NavigationRail).

    :param page: La página de Flet actual.
    :param on_change_view: Una función de callback para manejar el cambio de vista.
    """

    def on_rail_change(e):
        """
        Manejador para el evento on_change del NavigationRail.
        Llama a la función de callback con el índice seleccionado.
        """
        selected_index = e.control.selected_index
        on_change_view(selected_index)

    return ft.NavigationRail(
        selected_index=0,
        label_type=ft.NavigationRailLabelType.ALL,
        min_width=100,
        min_extended_width=200,
        leading=ft.FloatingActionButton(icon=ft.icons.CREATE, text="Añadir"),
        group_alignment=-0.9,
        destinations=[
            ft.NavigationRailDestination(
                icon=ft.icons.DASHBOARD_OUTLINED,
                selected_icon=ft.icons.DASHBOARD,
                label="Dashboard",
            ),
            ft.NavigationRailDestination(
                icon_content=ft.Icon(ft.icons.PERSON_OUTLINE),
                selected_icon_content=ft.Icon(ft.icons.PERSON),
                label="Usuarios",
            ),
            ft.NavigationRailDestination(
                icon=ft.icons.SECURITY_OUTLINED,
                selected_icon_content=ft.Icon(ft.icons.SECURITY),
                label_content=ft.Text("Roles"),
            ),
            ft.NavigationRailDestination(
                icon=ft.icons.MENU_BOOK_OUTLINED,
                selected_icon=ft.icons.MENU_BOOK,
                label="Menús",
            ),
        ],
        on_change=on_rail_change,
    )
