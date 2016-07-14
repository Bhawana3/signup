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

@app.route('/')
def layout():
    try:
        if ('uid' in session) and ('user_response' in session):
            print "User:",session['uid']," is already logged in. Redirecting to home page"
            return redirect(url_for('home'))
        else:
            return render_template('layout.html')
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

            uid = cursor.lastrowid

            # storing user_id in session
            session['uid'] = uid
            session['user_response'] = user_response_for_yes_answers

            # inserting question numbers into user prefernce table

            for question_number in user_response_for_yes_answers:
                insert_into_user_preference = "INSERT INTO user_preference(user_id,QuesNo) VALUES(%s,%s)"
                cursor.execute(insert_into_user_preference,(uid,question_number))
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

@app.route('/login',methods=['GET','POST'])
def login():
    if request.method == 'GET':
        try:
            print "Session variable is:",session
            if ('uid' in session) and ('user_response' in session):
                print "User:",session['uid']," is already logged in. Redirecting to home page"
                user_response = session['user_response']
                print "user_response : ",user_response
                return redirect(url_for('home'))
            else:
                return render_template('login.html')
        except Exception as e:
            print "Error occurred:",e

    elif request.method == 'POST':
        if ('uid' in session) and ('user_response' in session):
            print "User:",session['uid']," is already logged in. Redirecting to home page"
            return redirect(url_for('home'))
        else:
            _email = request.form.get('email',None)
            _password = request.form.get('password',None)

            try:
                conn = mysql.connect()
                cursor = conn.cursor()
                print str(_email)
                query = "SELECT userId,password FROM user WHERE email_id = '" + str(_email) + "'"
                cursor.execute(query)
                data = cursor.fetchone()
                conn.commit()

            except Exception as e:
                print "Error in database query: ",e

	    if data == None:
                flash('Please enter a valid email address')
                return render_template('login.html')
		

            elif len(data) > 0:
                uid = data[0]
                password = data[1]

                try:
                    #verify password hash
                    if sha256_crypt.verify(request.form.get('password',None),password):
                        session['logged_in'] = True
                        # User credentials are correct

                        # Delete old values from session
                        print "Logging out any user if he's already logged-in."
                        session.clear()

                        try:
                            conn = mysql.connect()
                            cursor = conn.cursor()
                            sql_query_for_user_preference = "SELECT QuesNo FROM user_preference WHERE user_id = %s" % str(uid)
                            cursor.execute(sql_query_for_user_preference)
                            user_preference = [row[0] for row in cursor.fetchall()]
                            conn.commit()
                            conn.close()
                            print user_preference

                        except Exception as e:
                            print "Error in database query : ",e

                        # Log the user in.
                        session['uid'] = uid
                        session['user_response'] = user_preference
                        print "User:",uid,"successfully logged-in. Redirecting to home page."

                        return redirect(url_for('home'))

                    else:
                        flash('Invalid credentials, try again.')
                        return render_template('login.html')

                except Exception as e:
                    print "error : ",e
                    flash('Invalid credentials, try again.')
                    return render_template('login.html')
            else:
                flash('Please enter a valid email address')
                return render_template('login.html')

@app.route('/home')
def home():
    try:
        user_response = session['user_response']                # user response is a list containing answers
	user_response = map(int,user_response)
        conn = mysql.connect()
        cursor = conn.cursor()
        if user_response != []:
            answers_tuple = tuple(user_response)                    # converting user response into tuple
            print answers_tuple
            query = "SELECT cc.CId,cc.card_name,cc.image,cc.detail,Sum(qc.Points) AS sum FROM questions_for_credit_cards AS qc INNER JOIN credit_card AS cc ON cc.CID = qc.CardNo WHERE QuesNo in " + str(answers_tuple) + "GROUP BY cc.CId,cc.card_name ORDER BY sum DESC;"
        else:
            print user_response
            query = "SELECT cc.CId,cc.card_name,cc.image,cc.detail,Sum(qc.Points) AS sum FROM questions_for_credit_cards AS qc INNER JOIN credit_card AS cc ON cc.CID = qc.CardNo GROUP BY cc.CId,cc.card_name ORDER BY sum DESC;"
        cursor.execute(query)
        results = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('home.html',results=results)

    except Exception as e:
        print "Error :",e
        return redirect(url_for('login'))

@app.route('/logout',methods=['GET'])
def logout():
    session.clear()
    print 'deleted session: ', session
    return render_template('logout.html')

if __name__ == "__main__":
    app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
    app.run()



