from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from backend.app.db.base import Base

class User(Base):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(100), unique=True, nullable=False, index=True)
    password_hash = Column(String(255), nullable=False)
    email = Column(String(100), unique=True, index=True)
    rol_id = Column(Integer, ForeignKey("roles.id"), nullable=False)
    personal_id = Column(Integer, ForeignKey("personal.id"), unique=True)
    ultimo_login_at = Column(DateTime(timezone=True))
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())

    rol = relationship("Rol", back_populates="usuarios")
    # La relación con Personal se definirá en el modelo Personal
    # personal = relationship("Personal", back_populates="usuario")
