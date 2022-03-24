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
        # Verificar se a conta existe
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE username = %s AND password = %s', (username, password,))
        # Retorna resultado
        account = cursor.fetchone()
        if account:
            # Criar dados de sessão
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            # Redirecionar para página principal
            return 'Login efetuado com sucesso!'
        else:
            # Conta não existente ou dados incorretos
            msg = 'Dados incorretos!'
    return render_template('index.html', msg='')

# http://localhost:5000/logout
# Página de logout
@app.route('/logout')
def logout():
    # Remover dados de sessão
   session.pop('loggedin', None)
   session.pop('id', None)
   session.pop('username', None)
   # Redirect
   return redirect(url_for('login'))

# http://localhost:5000/register
# Página de registo
@app.route('/register', methods=['GET', 'POST'])
def register():
    # Mensagem de output
    msg = ''
    # Verificar se dados estão preenchidos
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        # Criar variáveis
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        # VErificar se conta existe
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE username = %s', (username,))
        account = cursor.fetchone()
        # Se existir, validação / erros
        if account:
            msg = 'Conta já existe!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Endereço de email inválido!'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Nome de utilizador só deve ter números e caracteres!'
        elif not username or not password or not email:
            msg = 'Preencha o formulário!'
        else:
            # Se tudo estiver bem, adicionar conta à base de dados
            cursor.execute('INSERT INTO accounts VALUES (NULL, %s, %s, %s)', (username, password, email,))
            mysql.connection.commit()
            msg = 'Registo efetuado com sucesso!'
    elif request.method == 'POST':
        # Formulário vazio
        msg = 'Please fill out the form!'
    return render_template('register.html', msg=msg)