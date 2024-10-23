from datetime import datetime
from sqlalchemy import Column, Integer, String, DECIMAL, ForeignKey, DateTime
from sqlalchemy.orm import relationship
import Conexion
#Clase usuario
class Usuario(Conexion.Base):
    __tablename__ = 'usuarios'
    idusuario = Column(Integer, primary_key=True, autoincrement=True)
    nombre = Column(String, nullable=True)
    apellido = Column(String, nullable=True)
    email = Column(String, nullable=True)
    num_documento = Column(String, nullable=True)
    tipo = Column(String, nullable=False)  # 'artista' o 'cliente'

    

    def __init__(self, nombre, apellido, email, num_documento, tipo):
        self.nombre = nombre
        self.apellido = apellido
        self.email = email
        self.num_documento = num_documento
        self.tipo = tipo

    def __repr__(self):
        return f'Usuario({self.idusuario}, {self.nombre}, {self.apellido}, {self.tipo})'

# Clase Estampa
class Estampa(Conexion.Base):
    __tablename__ = 'estampas'
    idestampa = Column(Integer, primary_key=True, autoincrement=True)
    nombre = Column(String, nullable=True)
    caracteristicas = Column(String, nullable=True)
    imagen = Column(String, nullable=True)
    estado = Column(String, nullable=True)
    tarifa = Column(DECIMAL(10, 2), nullable=True)
    stock = Column(Integer, nullable=True)

    def __init__(self, nombre, caracteristicas, imagen, estado, tarifa, stock):
        self.nombre = nombre
        self.caracteristicas = caracteristicas
        self.imagen = imagen
        self.estado = estado
        self.tarifa = tarifa
        self.stock = stock

    def __repr__(self):
        return f'Estampa({self.idestampa}, {self.nombre}, {self.tarifa}, {self.stock})'


# Clase Camiseta
class Camiseta(Conexion.Base):
    __tablename__ = 'camisetas'
    idcamiseta = Column(Integer, primary_key=True, autoincrement=True)
    talla = Column(String, nullable=True)
    color = Column(String, nullable=True)
    estado_disponibilidad = Column(String, nullable=True)
    precio = Column(DECIMAL(10, 2), nullable=True)
    estampa_id = Column(Integer, ForeignKey('estampas.idestampa'), nullable=False)
    stock = Column(Integer, nullable=True)

    estampa = relationship("Estampa")

    def __init__(self, talla, color, estado_disponibilidad, precio, estampa_id, stock):
        self.talla = talla
        self.color = color
        self.estado_disponibilidad = estado_disponibilidad
        self.precio = precio
        self.estampa_id = estampa_id
        self.stock = stock

    def __repr__(self):
        return f'Camiseta({self.idcamiseta}, {self.talla}, {self.color}, {self.precio}, {self.stock})'

# clase Factura
class Factura(Conexion.Base):
    __tablename__ = 'factura'

    idfactura = Column(Integer, primary_key=True, autoincrement=True)
    idventa = Column(Integer, ForeignKey('ventas.idventa'), nullable=False)
    nombre_usuario = Column(String(100), nullable=False)
    num_documento = Column(String(20), nullable=False)
    fecha = Column(DateTime, default=datetime.now)
    total = Column(DECIMAL(10, 2), nullable=False)
    cliente_id = Column(Integer, ForeignKey('usuarios.idusuario'))

    # Relacines con tablas
    cliente = relationship("Usuario")  # Relación con el cliente, tabla usuario
    

    def __init__(self, idventa, nombre_usuario, num_documento, total, cliente_id):
        self.idventa = idventa
        self.nombre_usuario = nombre_usuario
        self.num_documento = num_documento
        self.total = total
        self.cliente_id = cliente_id

    def __repr__(self):
        return (f"<Factura(idfactura={self.idfactura}, idventa={self.idventa}, "
                f"nombre_usuario='{self.nombre_usuario}', num_documento='{self.num_documento}', "
                f"fecha={self.fecha}, total={self.total}, cliente_id={self.cliente_id})>")


# Clase Venta
class Venta(Conexion.Base):
    __tablename__ = 'ventas'
    idventa = Column(Integer, primary_key=True, autoincrement=True)
    camiseta_id = Column(Integer, ForeignKey('camisetas.idcamiseta'))
    idestampa_frontal = Column(Integer, ForeignKey('estampas.idestampa'))
    idestampa_trasera = Column(Integer, ForeignKey('estampas.idestampa'))
    cliente_id = Column(Integer, ForeignKey('usuarios.idusuario'))  # Nueva relación con cliente
    cantidad = Column(Integer, nullable=False)  # Nueva columna para la cantidad de camisetas
    total = Column(DECIMAL(10, 2), nullable=True)
    factura_id = Column(Integer, ForeignKey('factura.idfactura'))

    # Relaciónes con otra tablas
    camiseta = relationship("Camiseta")
    estampa1 = relationship("Estampa", foreign_keys=[idestampa_frontal])
    estampa2 = relationship("Estampa", foreign_keys=[idestampa_trasera])
    cliente = relationship("Usuario")  
    factura = relationship("Factura", foreign_keys=[factura_id])

    def calcular_total(self):
        camiseta = Conexion.session.query(Camiseta).filter_by(idcamiseta=self.camiseta_id).first()
        estampa1 = Conexion.session.query(Estampa).filter_by(idestampa=self.idestampa_frontal).first()
        estampa2 = Conexion.session.query(Estampa).filter_by(idestampa=self.idestampa_trasera).first()

        if camiseta:
            self.total = camiseta.precio * self.cantidad  
            if estampa1 and estampa1.tarifa is not None:
                self.total += estampa1.tarifa
            if estampa2 and estampa2.tarifa is not None:
                self.total += estampa2.tarifa
            return self.total
        return 0

    def __repr__(self):
        return f'Venta({self.idventa}, {self.camiseta_id}, {self.idestampa_frontal}, {self.idestampa_trasera}, {self.cantidad}, {self.total}, {self.cliente_id}, {self.factura_id})'


# Realizar la venta y generar una factura

def realizar_venta(cliente_id, camiseta_id, cantidad ,idestampa_frontal=None, idestampa_trasera=None):
    session = Conexion.session

    # Verificar si el cliente existe y es de tipo 'cliente'
    cliente = session.query(Usuario).filter_by(idusuario=cliente_id, tipo='cliente').first()
    if not cliente:
        print("Error: El cliente especificado no existe o no es un cliente.")
        return

    # Verificar si la camiseta y las estampas existen en la base de datos
    camiseta = session.query(Camiseta).filter_by(idcamiseta=camiseta_id).first()
    estampa1 = session.query(Estampa).filter_by(idestampa=idestampa_frontal).first() if idestampa_frontal else None
    estampa2 = session.query(Estampa).filter_by(idestampa=idestampa_trasera).first() if idestampa_trasera else None

    if not camiseta:
        print("Error: La camiseta especificada no existe.")
        return

    if idestampa_frontal and not estampa1:
        print("Error: La estampa frontal especificada no existe.")
        return

    if idestampa_trasera and not estampa2:
        print("Error: La estampa trasera especificada no existe.")
        return

    # Verificar que haya suficiente stock de la camiseta
    if camiseta.stock < cantidad:
        print("Error: No hay suficiente stock de la camiseta seleccionada.")
        return

    # Crea una nueva venta
    nueva_venta = Venta(camiseta_id=camiseta_id, idestampa_frontal=idestampa_frontal, 
                        idestampa_trasera=idestampa_trasera, cantidad=cantidad, cliente_id=cliente_id,)
    nueva_venta.calcular_total()

    # Descontar el stock de la camiseta
    camiseta.stock -= cantidad
    session.add(nueva_venta) 
    session.commit()

    # Si hay estampas seleccionadas, descontar el stock
    if estampa1:
        if estampa1.stock < cantidad:
            print("Error: No hay suficiente stock de la estampa frontal seleccionada.")
            return
        estampa1.stock -= cantidad
    if estampa2:
        if estampa2.stock < cantidad:
            print("Error: No hay suficiente stock de la estampa trasera seleccionada.")
            return
        estampa2.stock -= cantidad
        

    # Crear o actualizar factura
    factura = session.query(Factura).filter(Factura.idventa == nueva_venta.idventa).first()

    if not factura:
        # Crear nueva factura si no existe
        factura = Factura(
            idventa=nueva_venta.idventa,  
            cliente_id=cliente_id,
            nombre_usuario=cliente.nombre,
            num_documento=cliente.num_documento,
            total=nueva_venta.total
        )
        session.add(factura)
    else:
        # Actualizar el total de la factura existente sumando el total de la nueva venta
        factura.total += nueva_venta.total


    nueva_venta.factura = factura

    # Agregar nueva venta a la sesión
    session.add(nueva_venta)

    # Guardar los cambios
    session.commit()
    print(f'Venta realizada exitosamente: {nueva_venta}')
    print(f'Factura generada: {factura}')

# Prueba de la función realizar_venta
realizar_venta(cliente_id=7, camiseta_id=1, cantidad=3, idestampa_frontal=15, idestampa_trasera=16,)
