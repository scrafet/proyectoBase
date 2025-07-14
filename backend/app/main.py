# backend/app/main.py
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from backend.app.db.session import get_db, engine
from backend.app.models.item import Base, Item
from backend.app.schemas.item import ItemCreate, ItemResponse # Aún no creamos estos, los haremos luego
from backend.app.core.config import settings

# Crea la aplicación FastAPI
app = FastAPI(
    title=settings.PROJECT_NAME,
    version="0.0.1",
    description="API para la aplicación AdminLTE con Flet y FastAPI",
)

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

# Ejemplo de endpoint para crear un ítem (usará los schemas que crearemos)
# @app.post("/items/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
# def create_item(item: ItemCreate, db: Session = Depends(get_db)):
#     db_item = Item(**item.model_dump()) # Usar model_dump() para Pydantic v2
#     db.add(db_item)
#     db.commit()
#     db.refresh(db_item)
#     return db_item