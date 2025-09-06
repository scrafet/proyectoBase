# backend/app/main.py
from fastapi import FastAPI
from backend.app.db.session import engine
from backend.app.db.base import Base
from backend.app.core.config import settings
from backend.app.api.v1.api import api_router

# Crea la aplicación FastAPI
app = FastAPI(
    title=settings.PROJECT_NAME,
    version="0.0.1",
    description="API para la aplicación AdminLTE con Flet y FastAPI",
)

# Incluir el router principal de la API v1
app.include_router(api_router, prefix="/api/v1")

# Este evento se ejecuta cuando la aplicación se inicia
@app.on_event("startup")
def on_startup():
    print("Aplicación FastAPI iniciando...")
    # Crea todas las tablas en la base de datos si no existen
    # Esto es solo para desarrollo. En producción, usa migraciones (Alembic).
    Base.metadata.create_all(bind=engine)
    print("Tablas de la base de datos creadas/verificadas.")

# Ruta de prueba simple
@app.get("/")
def read_root():
    return {"message": "¡Bienvenido a tu API de AdminLTE con FastAPI!"}