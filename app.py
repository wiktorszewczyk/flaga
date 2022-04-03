from flask import Flask, render_template

app=Flask(__name__,
          static_url_path='',
          static_folder='web/static',
          template_folder='web/templates')

@app.route('/')
def index():
    text = open('data/data.txt').read()
    return render_template("index.html", text = text)

@app.route('/subdomain')
def subdomain():
    return render_template("subdomain.html")

# TEST SUBDOMAIN
@app.route('/tests')
def test():
    return render_template("tests.html")

# PASSWORD GENERATOR
from python_projects import password_generator

@app.route('/password_generator')
def passwd_gen():
    get_password = password_generator.password_generator()
    return render_template("password_generator.html", generated_password = get_password)

# STRONA Z LICEUM XD
@app.route('/strona')
def strona():
    return render_template("strona.html")

@app.route('/kontakt-i-wspolpraca')
def kontaktiwspolpraca():
    return render_template("kontakt-i-wspolpraca.html")

@app.route('/polecane-strony')
def polecanestrony():
    return render_template("polecane-strony.html")

@app.route('/zdjecia-kotow')
def zdjeciakotow():
    return render_template("zdjecia-kotow.html")

@app.route('/zdjecia-psow')
def zdjeciapsow():
    return render_template("zdjecia-psow.html")

@app.route('/zdjecia-zwierzat')
def zdjeciazwierzat():
    return render_template("zdjecia-zwierzat.html")

if __name__=="__main__":
    app.run()
