import flask
from flask import Flask,redirect,render_template,request,url_for,session,flash
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
        conn.commit()
        conn.close()
        return render_template('sign_up.html',results=results)

    except Exception as e:
        print "Error :",e


@app.route('/signup',methods=['POST'])
def signUp():
    if request.method == 'POST':
        _username = request.form.get('username',None)
        _email = request.form.get('email',None)
        _password = request.form.get('password',None)

        answers_for_questions = []                                          # for storing user response to following questions
        for number in range(1,6):
            question = 'question_' + str(number)
            answers_for_questions.append(str(request.form.get(question,None)))       # finds value for particular name attribute

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
            cursor.execute(insert_query_for_user,(_email,_username,password_hash))
            conn.commit()

            # for finding last inserted user_id
            print cursor.lastrowid

            user_id = cursor.lastrowid

            # storing user_id in session
            session['uid'] = user_id
            session['user_response'] = user_response_for_yes_answers

            # inserting question numbers into user prefernce table

            for question_number in user_response_for_yes_answers:
                insert_into_user_preference = "INSERT INTO user_preference(user_id,QuesNo) VALUES(%s,%s)"
                cursor.execute(insert_into_user_preference,(user_id,question_number))
                conn.commit()
            conn.close()

            return redirect(url_for('home'))

        except Exception as e:
                print "error :",e
                flash("email already exists!!")
                return redirect(url_for('load_questions'))

    else:
        flash("email already exists!!")
        return render_template('signup.html')

@app.route('/home')
def home():
    try:
        user_response = session['user_response']                # user reponse is a list containing answers
        conn = mysql.connect()
        cursor = conn.cursor()
        answers_tuple = tuple(user_response)                 # converting user response into tuple
        query = "SELECT cc.card_name ,Sum(qc.Points) AS sum FROM questions_for_credit_cards AS qc INNER JOIN credit_card AS cc ON cc.CID = qc.CardNo WHERE QuesNo in " + str(answers_tuple) + "GROUP BY cc.CId,cc.card_name ORDER BY sum DESC;"
        cursor.execute(query)
        results = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('home.html',results=results)

    except Exception as e:
        print "Error :",e


if __name__ == "__main__":
    app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
    app.run()



