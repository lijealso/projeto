from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re
from dbconnect import connection
from passlib.hash import sha256_crypt
import random

app = Flask(__name__)

app.secret_key = 'segredo'

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
        cursor.execute('SELECT * FROM accounts WHERE username = %s', (username,))
        # Retorna resultado
        account = cursor.fetchone()
        validatePassword = sha256_crypt.verify(password, account['password'])
        if account and validatePassword:
            # Criar dados de sessão
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['username']
            # Redirecionar para página principal
            return redirect(url_for('home'))
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


# http://localhost:5000/home
# Página principal
@app.route('/home')
def home():
    # VErificar se utilizar fez login
    if 'loggedin' in session:
        # Mostrar a página principal
        return render_template('home.html', username=session['username'])
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
        password_form = request.form['password']
        password = sha256_crypt.encrypt(password_form)
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
            cursor.execute('INSERT INTO accounts VALUES (NULL, %s, %s, %s)', (username, email, password,))
            mysql.connection.commit()
            msg = 'Registo efetuado com sucesso!'
    elif request.method == 'POST':
        # Formulário vazio
        msg = 'Please fill out the form!'
    return render_template('register.html', msg=msg)

# http://localhost:5000/profile
# Página de perfil
@app.route('/profile')
def profile():
    # Verificar se utilizar fez login
    if 'loggedin' in session:
        # Buscar à base de dados a informação da conta
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM accounts WHERE id = %s', (session['id'],))
        account = cursor.fetchone()
        # Mostra a página de perfil com a informação da conta
        return render_template('profile.html', account=account)
    return redirect(url_for('login'))

@app.route("/update", methods =['GET', 'POST'])
def update():
    msg = ''
    if 'loggedin' in session:
        if request.method == 'POST' and 'username' in request.form and 'email' in request.form and 'password' in request.form:
            username = request.form['username']
            email = request.form['email']
            password = request.form['password']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM accounts WHERE username = %s', (username, ))
            account = cursor.fetchone()
            # Validações e erros
            if account:
                msg = 'A conta já existe!'
            else:
                cursor.execute('UPDATE accounts SET username = %s, email = %s, password = %s WHERE id = %s', (username, email, password, (session['id'], )))
                mysql.connection.commit()
                msg = 'Dados atualizados com sucesso!'
        elif request.method == 'POST':
            msg = 'Por favor preencha o formulário!'
        return render_template("update.html", msg = msg)
    return redirect(url_for('login'))

# http://localhost:5000/addquestions
# Página de perfil
@app.route('/addquestions', methods =['GET', 'POST'])
def addquestions():
    msg = ''
    if 'loggedin' in session:
        # Verificar se dados estão preenchidos
        if request.method == 'POST' and 'quizId' in request.form and 'type' in request.form and 'active' in request.form and 'level' in request.form and 'score' in request.form and 'createdAt' in request.form and 'updatedAt' in request.form and 'content' in request.form:
            # Criar variáveis
            quizId = request.form['quizId']
            type = request.form['type']
            active = request.form['active']
            level = request.form['level']
            score = request.form['score']
            createdAt = request.form['createdAt']
            updatedAt = request.form['updatedAt']
            content = request.form['content']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('INSERT INTO quiz_question VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s)', (quizId, type, active, level, score, createdAt, updatedAt, content, ))
            mysql.connection.commit()
            msg = 'Questão adicionada'
        elif request.method == 'POST':
            # Formulário vazio
            msg = 'Preencha os dados!'
        return render_template('addquestions.html', msg=msg)
    return redirect(url_for(addquestions))

# http://localhost:5000/addanswers
# Página de perfil
@app.route('/addanswers', methods =['GET', 'POST'])
def addanswers():
    msg = ''
    if 'loggedin' in session:
        # Verificar se dados estão preenchidos
        if request.method == 'POST' and 'quizId' in request.form and 'questionId' in request.form and 'active' in request.form and 'correct' in request.form and 'createdAt' in request.form and 'updatedAt' in request.form and 'content' in request.form:
            # Criar variáveis
            quizId = request.form['quizId']
            questionId = request.form['questionId']
            active = request.form['active']
            correct = request.form['correct']
            createdAt = request.form['createdAt']
            updatedAt = request.form['updatedAt']
            content = request.form['content']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('INSERT INTO quiz_answer VALUES (NULL, %s, %s, %s, %s, %s, %s, %s)', (quizId, questionId, active, correct, createdAt, updatedAt, content, ))
            mysql.connection.commit()
            msg = 'Resposta adicionada'
        elif request.method == 'POST':
            # Formulário vazio
            msg = 'Preencha os dados!'
        return render_template('addanswers.html', msg=msg)
    return redirect(url_for(addanswers))

@app.route('/list_users')       
def display_users():
    if 'loggedin' in session:
        c, conn = connection()
        query = "SELECT * FROM accounts"
        c.execute(query)
        data = c.fetchall()
        conn.close()
        return render_template("list_users.html", data=data)
    return redirect(url_for('login'))

@app.route('/list_questions')       
def display_questions():
    if 'loggedin' in session:
        c, conn = connection()
        query = "SELECT * FROM quiz_question"
        c.execute(query)
        data = c.fetchall()
        conn.close()
        return render_template("list_questions.html", data=data)
    return redirect(url_for('login'))

@app.route('/list_answers')       
def display_answers():
    if 'loggedin' in session:
        c, conn = connection()
        query = "SELECT * FROM quiz_answer"
        c.execute(query)
        data = c.fetchall()
        conn.close()
        return render_template("list_answers.html", data=data)
    return redirect(url_for('login'))

@app.route('/list_quizzes')       
def display_quizzes():
    if 'loggedin' in session:
        c, conn = connection()
        query = "SELECT * FROM quiz"
        c.execute(query)
        data = c.fetchall()
        conn.close()
        return render_template("list_quizzes.html", data=data)
    return redirect(url_for('login'))

@app.route('/teste')
def display_teste():
    if 'loggedin' in session:
        c, conn = connection()
        query = "SELECT COUNT(id) FROM quiz"
        c.execute(query)
        number_quizzes = c.fetchone()
        number_quizzes2 = number_quizzes[0]
        # escolher, aleatoriamente, quiz dentro da quantidade existente
        random_quiz = random.randint(1, number_quizzes2)
        query1 = "SELECT id,content,score FROM quiz_question WHERE quizId = %s" % random_quiz
        c.execute(query1)
        questions_data = c.fetchall()
        query2 = "SELECT questionId,content FROM quiz_answer"
        c.execute(query2)
        answers_data = c.fetchall()
        conn.close()
        questions = []
        for question in questions_data:
            temp1 = []
            temp = []
            temp1.append(question[2])
            temp1.append(question[1])
            for answer in answers_data:
                if answer[0] == question[0]:
                    temp.append(answer[1])
                    # randomizar respostas
                    random.shuffle(temp)
            for x in temp:
                temp1.append(x)
            questions.append(temp1)
        # randomizar perguntas
        random.shuffle(questions)

        return render_template("teste.html", questions = questions)
    return redirect(url_for('login'))

