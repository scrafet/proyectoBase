import flet as ft

def login_view():
    """
    Crea y retorna la vista de la página de inicio de sesión.
    """
    username_field = ft.TextField(
        label="Nombre de usuario",
        width=300,
        autofocus=True,
        border_radius=ft.border_radius.all(10)
    )

    password_field = ft.TextField(
        label="Contraseña",
        password=True,
        can_reveal_password=True,
        width=300,
        border_radius=ft.border_radius.all(10)
    )

    def login_button_click(e):
        """
        Manejador del evento click del botón de login.
        TODO: Implementar la lógica de autenticación con el backend.
        """
        # Por ahora, solo redirige a la página principal.
        e.page.go("/dashboard")

    login_button = ft.ElevatedButton(
        text="Iniciar Sesión",
        on_click=login_button_click,
        width=300,
        height=40,
        style=ft.ButtonStyle(
            shape=ft.RoundedRectangleBorder(radius=10),
        )
    )

    return ft.View(
        route="/login",
        controls=[
            ft.Column(
                [
                    ft.Text("Inicio de Sesión", size=32, weight=ft.FontWeight.BOLD),
                    ft.Container(height=20), # Espaciador
                    username_field,
                    password_field,
                    ft.Container(height=10), # Espaciador
                    login_button,
                ],
                alignment=ft.MainAxisAlignment.CENTER,
                horizontal_alignment=ft.CrossAxisAlignment.CENTER,
                spacing=15,
                expand=True, # Para centrar verticalmente en la vista
            )
        ],
        vertical_alignment=ft.MainAxisAlignment.CENTER,
        horizontal_alignment=ft.CrossAxisAlignment.CENTER,
        padding=ft.padding.all(50)
    )
