
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

#engine = create_engine(mysql.connector.connect(user="root", password="1234", host="localhost", database="agenda", port="3306"))
connection_string = "mysql+mysqlconnector://root:1234@localhost:3306/agenda"
engine = create_engine(connection_string, echo=True)

Session = sessionmaker(bind=engine)
session = Session()

Base = declarative_base()

# Crear el sessionmaker para gestionar las sesiones
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
