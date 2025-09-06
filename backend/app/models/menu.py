from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from backend.app.db.base import Base

class Menu(Base):
    __tablename__ = "menus"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(100), nullable=False)
    url = Column(String(255))
    icono = Column(String(50))
    orden = Column(Integer)
    idMenuPadre = Column(Integer, ForeignKey("menus.id"))
    estado = Column(Boolean, default=True)

    parent = relationship("Menu", remote_side=[id], back_populates="children")
    children = relationship("Menu", back_populates="parent", cascade="all, delete-orphan")
