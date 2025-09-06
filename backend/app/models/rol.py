from sqlalchemy import Column, Integer, String, Boolean
from sqlalchemy.orm import relationship
from backend.app.db.base import Base

class Rol(Base):
    __tablename__ = "roles"

    id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(50), unique=True, nullable=False, index=True)
    descripcion = Column(String)
    estado = Column(Boolean, default=True)

    usuarios = relationship(
        "User",
        back_populates="rol",
        cascade="all, delete-orphan"
    )
