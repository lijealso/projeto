from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re

app = Flask(__name__)

# Informação para conexão à base de dados
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'mysql'
app.config['MYSQL_DB'] = 'projeto'

# Inicializar MySQL
mysql = MySQL(app)

# http://localhost:5000/login/
# Página de login
@app.route('/login/', methods=['GET', 'POST'])
def login():
    # Mensagem de output
    msg = ''
        # Verificar se campos estão preenchidos
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # Criação de variáveis
        username = request.form['username']
        password = request.form['password']
    return render_template('index.html', msg='')