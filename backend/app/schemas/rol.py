from pydantic import BaseModel
from typing import Optional

# Propiedades compartidas
class RolBase(BaseModel):
    nombre: str
    descripcion: Optional[str] = None
    estado: bool = True

# Propiedades para crear
class RolCreate(RolBase):
    pass

# Propiedades para actualizar
class RolUpdate(BaseModel):
    nombre: Optional[str] = None
    descripcion: Optional[str] = None
    estado: Optional[bool] = None

# Propiedades almacenadas en la BD
class RolInDBBase(RolBase):
    id: int

    class Config:
        orm_mode = True

# Propiedades para retornar al cliente
class Rol(RolInDBBase):
    pass
