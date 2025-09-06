from fastapi import APIRouter
from backend.app.api.v1.endpoints import auth

api_router = APIRouter()
api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
# Aquí se pueden añadir otros routers de endpoints en el futuro
# api_router.include_router(items.router, prefix="/items", tags=["items"])
