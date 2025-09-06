import flet as ft
from pages.login import login_view
from pages.dashboard import dashboard_view

def main(page: ft.Page):
    """
    Función principal de la aplicación Flet.
    Configura el enrutamiento y la navegación.
    """
    page.title = "AdminLTE Flet App"
    page.theme_mode = ft.ThemeMode.LIGHT

    def route_change(route):
        """
        Manejador de cambio de ruta. Limpia las vistas y añade la nueva.
        """
        page.views.clear()
        if page.route == "/login":
            page.views.append(login_view())
        elif page.route == "/dashboard":
            page.views.append(dashboard_view())

        page.update()

    def view_pop(view):
        """
        Manejador para el botón 'atrás' del navegador o la app.
        """
        page.views.pop()
        top_view = page.views[-1]
        page.go(top_view.route)

    page.on_route_change = route_change
    page.on_view_pop = view_pop

    # Iniciar la aplicación en la ruta de login
    page.go("/login")

# Iniciar la aplicación
if __name__ == "__main__":
    ft.app(target=main)
