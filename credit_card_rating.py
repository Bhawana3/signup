import flask
from flask import Flask,redirect,render_template,request,url_for,session
from flask.ext.mysql import MySQL
from passlib.hash import sha256_crypt

app = Flask(__name__)

mysql = MySQL()

#MySQL Configurations
try:
    app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_PASSWORD'] = 'cutiepie07'
    app.config['MYSQL_DATABASE_DB'] = 'credit_card_ranking'
    app.config['MYSQL_DATABASE_HOST'] = 'localhost'
    mysql.init_app(app)
except Exception as e:
    print "Error : ",e


@app.route('/signup',methods=['GET'])
def load_questions():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "SELECT * FROM question_table "
        cursor.execute(query)
        results = cursor.fetchall()
        return render_template('sign_up.html',results=results)

    except Exception as e:
        print "Error :",e


@app.route('/signup',methods=['POST'])
def signUp():
    if request.method == 'POST':
        _username = request.form['username']
        _email = request.form['email']
        _password = request.form['password']

        answers_for_questions = []                                          # for storing user response to following questions
        for number in range(1,6):
            question = 'question_' + str(number)
            answers_for_questions.append(str(request.form[question]))       # finds value for particular name attribute

        user_response_for_yes_answers = []                                  #stores question number for user response with yes
        for answer in answers_for_questions:
            if 'yes' in answer:
                user_response_for_yes_answers.append(answer.split('_')[0])
        user_response_for_yes_answers = map(int,user_response_for_yes_answers)

        print user_response_for_yes_answers

        password_hash = sha256_crypt.encrypt(_password)

        try:
            conn = mysql.connect()
            cursor = conn.cursor()

            insert_query_for_user = "INSERT INTO user(email_id,username,password) VALUES(%s,%s,%s)"
            print insert_query_for_user
            cursor.execute(insert_query_for_user,(_email,_username,password_hash))
            conn.commit()

            # for finding last inserted user_id
            print cursor.lastrowid

            user_id = cursor.lastrowid

            # storing user_id in session
            session['uid'] = user_id

            # inserting question numbers into user prefernce table

            for question_number in user_response_for_yes_answers:
                insert_into_user_preference = "INSERT INTO user_preference(user_id,QuesNo) VALUES(%s,%s)"
                cursor.execute(insert_into_user_preference,(user_id,question_number))
                conn.commit()
            conn.close()

            return redirect(url_for('home',answers_list = user_response_for_yes_answers,uid=user_id))

        except Exception as e:
                print "error :",e
                return redirect(url_for('load_questions'))

    else:
        return render_template('signup.html')

@app.route('/home/<uid>')
def home(answers_list):
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        answers_set = set(answers_list)
        query = "SELECT COUNT(Points) FROM questions_for_credit_cards WHERE QuesNo in %s ORDER BY DESC"
        cursor.execute(query,answers_set)
        results = cursor.fetchall()
        print results
#        return render_template('sign_up.html',results=results)

    except Exception as e:
        print "Error :",e


if __name__ == "__main__":
    app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
    app.run()



