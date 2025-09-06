# backend/app/models/item.py
from sqlalchemy import Column, Integer, String, Boolean
from backend.app.db.base import Base

class Item(Base):
    __tablename__ = "items" # Nombre de la tabla en la base de datos

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    description = Column(String, index=True)
    is_active = Column(Boolean, default=True)