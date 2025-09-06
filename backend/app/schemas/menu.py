from pydantic import BaseModel
from typing import Optional, List

# Propiedades compartidas
class MenuBase(BaseModel):
    nombre: str
    url: Optional[str] = None
    icono: Optional[str] = None
    orden: Optional[int] = None
    idMenuPadre: Optional[int] = None
    estado: bool = True

# Propiedades para crear
class MenuCreate(MenuBase):
    pass

# Propiedades para actualizar
class MenuUpdate(BaseModel):
    nombre: Optional[str] = None
    url: Optional[str] = None
    icono: Optional[str] = None
    orden: Optional[int] = None
    idMenuPadre: Optional[int] = None
    estado: Optional[bool] = None

# Propiedades almacenadas en la BD
class MenuInDBBase(MenuBase):
    id: int

    class Config:
        orm_mode = True

# Propiedades para retornar al cliente
class Menu(MenuInDBBase):
    children: List['Menu'] = []

# Actualizar las referencias adelantadas para manejar la relación anidada
Menu.update_forward_refs()
