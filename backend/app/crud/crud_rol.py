from sqlalchemy.orm import Session
from backend.app.models.rol import Rol
from backend.app.schemas.rol import RolCreate, RolUpdate

def get_rol(db: Session, rol_id: int):
    return db.query(Rol).filter(Rol.id == rol_id).first()

def get_rol_by_name(db: Session, name: str):
    return db.query(Rol).filter(Rol.nombre == name).first()

def get_roles(db: Session, skip: int = 0, limit: int = 100):
    return db.query(Rol).offset(skip).limit(limit).all()

def create_rol(db: Session, rol: RolCreate):
    db_rol = Rol(
        nombre=rol.nombre,
        descripcion=rol.descripcion,
        estado=rol.estado
    )
    db.add(db_rol)
    db.commit()
    db.refresh(db_rol)
    return db_rol

def update_rol(db: Session, db_rol: Rol, rol_in: RolUpdate):
    update_data = rol_in.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_rol, field, value)

    db.add(db_rol)
    db.commit()
    db.refresh(db_rol)
    return db_rol

def delete_rol(db: Session, rol_id: int):
    db_rol = db.query(Rol).filter(Rol.id == rol_id).first()
    if db_rol:
        db.delete(db_rol)
        db.commit()
    return db_rol
