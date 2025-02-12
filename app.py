from flask import Flask, render_template, request, redirect, url_for, session
import pyodbc

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta'  # Necesario para manejar sesiones

def conectar_bd(usuario, password):
    """Crea la conexión a SQL Server."""
    try:
        conn = pyodbc.connect(
            f'DRIVER={{ODBC Driver 17 for SQL Server}};'
            f'SERVER=nx23.ddns.net,7433;'
            f'DATABASE=alimentosmasivos;'
            f'UID={usuario};PWD={password}'
        )
        return conn
    except Exception as e:
        return str(e)

@app.route('/', methods=['GET', 'POST'])
def login():
    """Página de inicio de sesión."""
    if request.method == 'POST':
        usuario = request.form['usuario']
        password = request.form['password']
        conn = conectar_bd(usuario, password)
        
        if isinstance(conn, str):  # Si hay un error en la conexión
            return render_template('login.html', error=conn)
        
        session['usuario'] = usuario
        session['password'] = password
        return redirect(url_for('consulta'))
    
    return render_template('login.html')

@app.route('/consulta')
def consulta():
    """Ejecuta la consulta y muestra los datos."""
    if 'usuario' not in session:
        return redirect(url_for('login'))
    
    conn = conectar_bd(session['usuario'], session['password'])
    if isinstance(conn, str):  # Si hay error en la conexión
        return redirect(url_for('login'))
    
    try:
        cursor = conn.cursor()
        query = """
            SELECT 
                s.articuloID AS Codigo_del_Articulo,
                a.detalle AS Descripcion,
                s.saldocantidad,
                s.nombodega
            FROM [dbo].[fnInventSaldosInventario] (
                GETDATE(), NULL, NULL, '0'
            ) s
            INNER JOIN articulo a ON a.codigo = s.articuloID
        """
        cursor.execute(query)
        datos = cursor.fetchall()
    except Exception as e:
        return f"Error al ejecutar la consulta: {str(e)}"
    
    return render_template('consulta.html', datos=datos)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=10000, debug=True)


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 10000))
    app.run(host='0.0.0.0', port=port, debug=True)

