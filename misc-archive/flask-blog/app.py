from flask import Flask, render_template, flash, redirect, url_for, session, logging, request
# import data as d
from flask_mysqldb import MySQL
from wtforms import Form, StringField, TextAreaField, PasswordField, validators
from passlib.hash import sha256_crypt
from functools import wraps

app = Flask(__name__)

app.secret_key = 'flask_rocks_php_sucks'

# Config MySQL

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'myflaskapp'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'  # The default cursor

# MySQL init
mysql = MySQL(app)

# Articles = d.Articles()

# Index

@app.route('/')
def index():
	return render_template('home.html')

# About Page

@app.route('/about')
def about():
	return render_template('about.html')

# List articles

@app.route('/articles')
def articles():
	# create cursor
    cur = mysql.connection.cursor()

    # get articles
    result = cur.execute("SELECT * FROM articles")

    articles = cur.fetchall()

    if result > 0:
        return render_template('articles.html',articles=articles)

    else:
        msg = 'No Articles found!'
        return render_template('articles.html',msg=msg)

    cur.close()

# Article Page

@app.route('/article/<string:id>/')
def article(id):
	# create cursor
    cur = mysql.connection.cursor()

    # get article
    result = cur.execute("SELECT * FROM articles WHERE id = %s",[id])
    article = cur.fetchone()
    return render_template('article.html',article=article)

# User Registration

class RegisterForm(Form):
    name = StringField('Name', [validators.Length(min=1,max=100), validators.DataRequired()])
    username = StringField('Username', [validators.Length(min=8,max=50), validators.DataRequired()])
    email = StringField('Email',[validators.Length(min=6, max=50)])
    password = PasswordField('Password',[validators.EqualTo('confirm', message="Passwords Don't Match !"), validators.DataRequired()])
    confirm = PasswordField('Confirm Password')

@app.route('/register',methods=['GET','POST'])
def register():
    form = RegisterForm(request.form)
    if request.method == 'POST' and form.validate():
        name = form.name.data
        username = form.username.data
        email = form.email.data
        password = sha256_crypt.encrypt(str(form.password.data))

        # create cursor
        cur = mysql.connection.cursor()
        try:
            cur.execute("INSERT INTO users(name,email,username,password) VALUES(%s, %s, %s, %s)",(name,email,username,password))
            # commit to db
            mysql.connection.commit()
        except:
            flash("Something wrong happened from our side", 'danger')
            redirect(url_for('index'))


        # close connection
        cur.close()

        flash("You're registered & can log in", 'success')
        redirect(url_for('index'))

    return render_template('register.html',form=form)

# User Login

@app.route('/login',methods=['GET','POST'])
def login():
    if request.method == 'POST':
        # get form details
        username = request.form['username']
        password_candidate = request.form['password']

        # create cursor
        cur = mysql.connection.cursor()

        # Get user by username
        result = cur.execute("SELECT * FROM users WHERE username = %s",[username])
        if result > 0:
            # get stored hash
            data = cur.fetchone()
            password = data['password']

            # compare hashes
            if sha256_crypt.verify(password_candidate, password):
                # Passed
                session['logged_in'] = True
                session['username'] = username

                flash('You are logged in !','success')
                return redirect(url_for('dashboard'))
            else:
                error = 'Invalid Login'
                return render_template('login.html', error=error)
            cur.close()
        else:
            error = 'Username not found'
            return render_template('login.html', error=error)
    return render_template('login.html')

# check if user logged in
def is_logged_in(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if 'logged_in' in session:
            return f(*args, **kwargs)
        else:
            flash('Unauthorized. Please log in', 'danger')
            return redirect(url_for('login'))
    return wrap


# Logout

@app.route('/logout')
def logout():
    session.clear()
    flash('You are logged out !', 'success')
    return redirect(url_for('login'))

# Dashboard

@app.route('/dashboard')
@is_logged_in
def dashboard():
    # create cursor
    cur = mysql.connection.cursor()

    # get articles
    result = cur.execute("SELECT * FROM articles")

    articles = cur.fetchall()

    if result > 0:
        return render_template('dashboard.html',articles=articles)

    else:
        msg = 'No Articles found!'
        return render_template('dashboard.html',msg=msg)

    cur.close()

# Article Form class

class ArticleForm(Form):
    title = StringField('Title', [validators.Length(min=1,max=200), validators.DataRequired()])
    body = TextAreaField('Body', [validators.Length(min=30), validators.DataRequired()])

# Add Article

@app.route('/add_article',methods=['GET','POST'])
@is_logged_in
def add_article():
    form = ArticleForm(request.form)
    if request.method == 'POST' and form.validate():
        title = form.title.data
        body = form.body.data

        # Cursor
        cur = mysql.connection.cursor()
        # Execute
        cur.execute("INSERT INTO articles (title,body,author) VALUES (%s, %s, %s)",(title,body,session['username']))

        # commit to db
        mysql.connection.commit()

        # close connection
        cur.close()

        flash('Article Created !','success')
        return redirect(url_for('dashboard'))
    return render_template('add_article.html',form=form)

# Edit Article

@app.route('/edit_article/<string:id>',methods=['GET','POST'])
@is_logged_in
def edit_article(id):

    # create cursor
    cur = mysql.connection.cursor()
    
    # get article by id
    result = cur.execute("SELECT * FROM articles WHERE id = %s",[id])

    article = cur.fetchone()

    form = ArticleForm(request.form)

    # populate stuff

    form.title.data = article['title']
    form.body.data = article['body']

    if request.method == 'POST' and form.validate():
        title = request.form['title']
        body = request.form['body']

        # Cursor
        cur = mysql.connection.cursor()
        # Execute
        cur.execute("UPDATE articles SET title = %s, body = %s WHERE id = %s",(title,body,id))

        # commit to db
        mysql.connection.commit()

        # close connection
        cur.close()

        flash('Article Updated !','success')
        return redirect(url_for('dashboard'))
    return render_template('edit_article.html',form=form)

@app.route('/delete_article/<string:id>',methods=['POST'])
@is_logged_in
def delete_article(id):
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM articles WHERE id = %s",[id])
    mysql.connection.commit()
    cur.close()
    flash('Article Deleted Successfully!','success')
    return redirect(url_for('dashboard'))


if __name__ == "__main__":
	app.run(debug=True)