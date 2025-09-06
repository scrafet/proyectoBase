from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime
from .rol import Rol  # Importar el esquema de Rol

# Propiedades compartidas que todos los usuarios tienen
class UserBase(BaseModel):
    username: str
    email: EmailStr
    is_active: bool = True

# Propiedades para recibir en la creación de un usuario
class UserCreate(UserBase):
    password: str
    rol_id: int
    personal_id: Optional[int] = None

# Propiedades para recibir en la actualización de un usuario
class UserUpdate(BaseModel):
    username: Optional[str] = None
    email: Optional[EmailStr] = None
    password: Optional[str] = None
    is_active: Optional[bool] = None
    rol_id: Optional[int] = None
    personal_id: Optional[int] = None

# Propiedades compartidas por los modelos en la BD
class UserInDBBase(UserBase):
    id: int
    created_at: datetime
    # updated_at is optional because it might not be set on creation
    updated_at: Optional[datetime] = None

    class Config:
        orm_mode = True

# Propiedades para retornar al cliente (API)
class User(UserInDBBase):
    rol: Rol  # Incluir el objeto Rol completo

# Propiedades adicionales almacenadas en la BD
class UserInDB(UserInDBBase):
    password_hash: str
