# backend/app/db/session.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from backend.app.core.config import settings # Importa la configuración de la app
from backend.app.db.base import Base # Importa la base declarativa

# Crea el motor de la base de datos usando la URL de configuración
engine = create_engine(settings.DATABASE_URL)

# Configura el SessionLocal para interactuar con la base de datos
# autocommit=False: La transacción no se envía automáticamente a la base de datos
# autoflush=False: Los objetos no se envían automáticamente a la base de datos hasta que se hace commit
# bind=engine: Conecta esta sesión a nuestro motor de base de datos
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db # Retorna la sesión de la base de datos
    finally:
        db.close() # Cierra la sesión cuando se completa la solicitud