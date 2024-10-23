from flask import Flask, render_template, request, redirect, url_for, flash
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from NuevaVenta import Estampa, Camiseta, Usuario, Factura, Venta  
import Conexion 

#app Flask
app = Flask(__name__)
app.config['DEBUG'] = True  #depuración
app.secret_key = 'tu_clave_secreta'

#conexión a la base de datos
engine = create_engine('mysql+mysqlconnector://root:1234@localhost/agenda')
Conexion.Base.metadata.create_all(engine)
Session = scoped_session(sessionmaker(bind=engine))

def get_session():
    """Crea una nueva sesión y la retorna."""
    return Session()

@app.route('/')
def index():
    print("Accediendo a la página de inicio")
    session = get_session()
    camisetas = session.query(Camiseta).all()  # Obtener camisetas
    estampas = session.query(Estampa).all()  # Obtener estampas
    session.close()
    return render_template('index.html', camisetas=camisetas, estampas=estampas)

@app.route('/realizar_venta', methods=['POST'])
def realizar_venta():
    session = Session()  #nueva sesión en cada solicitud

    # Obtener datos del formulario
    cliente_id = int(request.form['cliente_id'])
    camiseta_id = int(request.form['camiseta_id'])
    cantidad = int(request.form['cantidad'])
    idestampa_frontal = int(request.form['idestampa_frontal'])
    idestampa_trasera = int(request.form['idestampa_trasera'])

    # Verificar si la camiseta y las estampas existen
    camiseta = session.query(Camiseta).filter_by(idcamiseta=camiseta_id).first()
    estampa1 = session.query(Estampa).filter_by(idestampa=idestampa_frontal).first() if idestampa_frontal > 0 else None
    estampa2 = session.query(Estampa).filter_by(idestampa=idestampa_trasera).first() if idestampa_trasera > 0 else None

    # Verificar que el cliente sea válido y de tipo 'cliente'
    cliente = session.query(Usuario).filter_by(idusuario=cliente_id, tipo='cliente').first()
    if not cliente:
        flash("Error: El cliente especificado no existe o no es un cliente.")
        return redirect(url_for('index'))

    # Verificar stock suficiente
    if not camiseta or camiseta.stock < cantidad:
        flash("Error: No hay suficiente stock de la camiseta seleccionada.")
        return redirect(url_for('index'))

    if idestampa_frontal > 0 and (not estampa1 or estampa1.stock < cantidad):
        flash("Error: No hay suficiente stock de la estampa frontal seleccionada.")
        return redirect(url_for('index'))

    if idestampa_trasera > 0 and (not estampa2 or estampa2.stock < cantidad):
        flash("Error: No hay suficiente stock de la estampa trasera seleccionada.")
        return redirect(url_for('index'))

    # Crear nueva venta 
    nueva_venta = Venta(
        camiseta_id=camiseta_id,
        idestampa_frontal=idestampa_frontal if idestampa_frontal > 0 else None,
        idestampa_trasera=idestampa_trasera if idestampa_trasera > 0 else None,
        cantidad=cantidad,
        cliente_id=cliente_id
    )
    
    nueva_venta.calcular_total()
    session.add(nueva_venta)

    
    session.commit()

    idventa = nueva_venta.idventa

    
    factura = session.query(Factura).filter(Factura.cliente_id == cliente_id).order_by(Factura.idventa.desc()).first()

    # Crea una factura
    if not factura:
        factura = Factura(
            idventa=idventa,
            cliente_id=cliente_id,
            total=0,
            nombre_usuario=cliente.nombre,  
            num_documento=cliente.num_documento  #usar datos cliente
        )
        session.add(factura)
    
    # Actualizar el stock de la camiseta y estampas
    camiseta.stock -= cantidad
    if estampa1:
        estampa1.stock -= cantidad
    if estampa2:
        estampa2.stock -= cantidad

    # Actualizar el total de la factura
    factura.total += nueva_venta.total

    # Asociar la venta con la factura
    nueva_venta.factura = factura

    #guardar todos los cambios
    session.commit()

    flash(f'Venta realizada: {cantidad} camisetas de ID {camiseta_id} con estampas ID {idestampa_frontal} y {idestampa_trasera}.')
    return redirect(url_for('factura', idventa=nueva_venta.idventa))


@app.route('/factura/<int:idventa>')
def factura(idventa):
    session = get_session()
    venta = session.query(Venta).filter_by(idventa=idventa).first()
    
    # verifica que la venta exista
    if not venta:
        flash("Error: La venta no existe.")
        return redirect(url_for('index'))

    # Obtener info del cliente
    cliente = session.query(Usuario).filter_by(idusuario=venta.cliente_id).first()
    
    session.close()
    return render_template('factura.html', venta=venta, cliente=cliente)


@app.teardown_appcontext
def shutdown_session(exception=None):
    Session.remove()  # Cerrar todas las sesiones 

if __name__ == "__main__":
    app.run(debug=True)








