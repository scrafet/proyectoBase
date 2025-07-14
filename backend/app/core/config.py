# backend/app/core/config.py
from pydantic_settings import BaseSettings, SettingsConfigDict
from dotenv import load_dotenv
import os

# Carga las variables de entorno desde el archivo .env
load_dotenv()

class Settings(BaseSettings):
    PROJECT_NAME: str = os.getenv("PROJECT_NAME", "AdminLTE Flet FastAPI App")
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")
    DATABASE_URL: str = os.getenv("DATABASE_URL")

    # Configuración para Pydantic Settings
    # model_config = SettingsConfigDict(env_file=".env", extra="ignore")

settings = Settings()

if settings.DATABASE_URL is None:
    raise ValueError("DATABASE_URL no está configurada en el archivo .env")

print(f"DEBUG: Project Name: {settings.PROJECT_NAME}")
print(f"DEBUG: Environment: {settings.ENVIRONMENT}")
# ¡Importante! No imprimas DATABASE_URL en producción por seguridad.
# print(f"DEBUG: Database URL: {settings.DATABASE_URL}")