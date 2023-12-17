import cv2  # Thư viện OpenCV để xử lý video và hình ảnh
import numpy as np  # Thư viện NumPy để làm việc với mảng và ma trận.
import pickle  # Thư viện để đọc và ghi dữ liệu dưới dạng đối tượng Python.

import urllib.request  # Thư viện để tạo yêu cầu HTTP và lấy dữ liệu từ một URL.
from flask import Flask, render_template, Response  # Các thư viện Flask để xây dựng ứng dụng web.
from flask_socketio import SocketIO  # Thư viện kết nối thời gian thực giữa máy chủ và trình duyệt.

import threading  # Thư viện để thực hiện các tác vụ đồng thời.
import mysql.connector  # Thư viện để kết nối và tương tác với cơ sở dữ liệu MySQL.
from gtts import gTTS  # Thư viện Google Text-to-Speech để chuyển văn bản thành giọng nói.
import pygame  # Thư viện để phát các tệp âm thanh.
import time, os, requests  # Các thư viện hỗ trợ xử lý thời gian, thư mục và gửi yêu cầu HTTP.

app = Flask(__name__)  # Đối tượng ứng dụng Flask.

socketio = SocketIO(app)  # Đối tượng SocketIO để xử lý kết nối thời gian thực.
url = 'http://192.168.113.242/cam-lo.jpg'  # Đường dẫn URL của video từ Esp32-CAM.

pickle_in = open("model_trained.p", "rb")  # Mở mô hình đã được huấn luyện
model = pickle.load(pickle_in)   # Đọc mô hình đã được huấn luyện từ tệp pickle.

current_name = 'a'  # Biến lưu trữ tên hiện tại của biển báo được nhận dạng
threshold = 0.9  # Ngưỡng để quyết định xem biển báo có được nhận dạng hay không.
font = cv2.FONT_HERSHEY_SIMPLEX  # Font chữ được sử dụng để vẽ lên hình ảnh.

pygame.init()  # Khởi tạo pygame
OUTPUT_DIR = 'temp'  # Đường dẫn thư mục lưu trữ các tệp âm thanh tạm thời.
MAX_FILES = 10  # Số lượng file âm thanh tối đa để giữ lại

# Kết nối với cơ sở dữ liệu Traffic_signs trong Mysql
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Hvtmk12@",
    database="traffic_signs"
)
mycursor = mydb.cursor()

# Hàm để xử lý hình ảnh trước khi đưa vào mô hình nhận dạng.
def preprocessing(img):
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    img = cv2.equalizeHist(img)
    img = img / 255
    return img
# Hàm sinh các khung hình để hiển thị trong video và thực hiện nhận dạng biển báo.

def gen_frames():
    global current_name
    while True:
        img_rq = urllib.request.urlopen(url)
        img_np = np.array(bytearray(img_rq.read()), dtype=np.uint8)
        frame = cv2.imdecode(img_np, -1)
        imgOrignal = frame.copy()
        img = np.asarray(imgOrignal)
        img = cv2.resize(img, (32, 32))
        img = preprocessing(img)
        img = img.reshape(1, 32, 32, 1)
        imgOrignal = cv2.putText(imgOrignal, "CLASS: ", (20, 35), font, 0.5, (0, 0, 255), 2, cv2.LINE_AA)
        imgOrignal = cv2.putText(imgOrignal, "PROBABILITY: ", (20, 55), font, 0.5, (255, 0, 0), 2, cv2.LINE_AA)

        predictions = model.predict(img)
        classIndex = np.argmax(predictions, axis=1)
        probabilityValue = np.amax(predictions)

        if probabilityValue > threshold:
            sign_info = get_sign_info(classIndex[0] + 1)
            class_name, class_des, class_warning = sign_info
            if(class_name != current_name):
                current_name = class_name
                print(class_name)
                cv2.putText(imgOrignal, class_name, (80, 35), font, 0.5, (0, 0, 255), 2, cv2.LINE_AA)
                cv2.putText(imgOrignal, str(round(probabilityValue * 100, 2)) + "%", (130, 55), font, 0.5, (255, 0, 0), 2,
                            cv2.LINE_AA)
                ret, buffer = cv2.imencode('.jpg', imgOrignal)
                if not ret:
                    return
                frame = buffer.tobytes()
                emit_result(class_name, round(probabilityValue * 100, 2), class_des, class_warning)
                message_to_send = ('Class_name: ' + class_name + '\nProbabilityValue: ' + str(round(probabilityValue * 100, 2))
                                   + '\nMeaning: ' + class_des + '\nWarning: \n' + class_warning)
                send_telegram_message('6985735580:AAG3v1FKhm6rSH8PWuk6cr_2BwRR89vQrHs', '5736560518', message_to_send)
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

# Hàm truy vấn cơ sở dữ liệu để lấy thông tin về biển báo dựa trên classIndex.
def get_sign_info(classIndex):
    query = f"SELECT name, des, warning FROM sign WHERE id = {classIndex}"
    mycursor.execute(query)
    result = mycursor.fetchone()

    if result:
        sign_name, sign_description, sign_warning = result
        return sign_name, sign_description, sign_warning
    else:
        return None

# Hàm gửi kết quả nhận dạng tới client thông qua SocketIO và phát âm thanh thông qua hàm speak_result.
def emit_result(class_name, probability_value, class_des, class_warning):
    socketio.emit('update_result', {'class_name': class_name, 'probability_value': probability_value,
                                    'class_des': class_des, 'class_warning': class_warning})
    # Speak the result
    threading.Thread(target=speak_result, args=(class_name,)).start()

# Hàm phát âm thanh tên biển báo đã được nhận dạng
def speak_result(class_name):
    # Tạo tên file duy nhất dựa trên thời gian hiện tại
    current_time = str(int(time.time()))
    file_name = f'result_{current_time}.mp3'
    file_path = os.path.join(OUTPUT_DIR, file_name)

    tts = gTTS(text=class_name, lang='en')
    tts.save(file_path)  # Lưu file âm thanh từ văn bản

    pygame.mixer.music.load(file_path)  # Tải file âm thanh
    pygame.mixer.music.play()  # Phát file âm thanh

    delete_old_audio_files()

# Hàm xoá file âm thanh cũ nếu số lượng vượt quá giới hạn
def delete_old_audio_files():
    files = os.listdir(OUTPUT_DIR)
    if len(files) <= MAX_FILES:
        return

    files.sort(key=os.path.getmtime)
    num_files_to_delete = len(files) - MAX_FILES

    for i in range(num_files_to_delete):
        file_path = os.path.join(OUTPUT_DIR, files[i])
        os.remove(file_path)

# Hàm gửi dữ liệu qua ứng dụng telegram đến client
def send_telegram_message(bot_token, chat_id, message):
    url = f'https://api.telegram.org/bot{bot_token}/sendMessage'
    params = {
        'chat_id': chat_id,
        'text': message
    }

    response = requests.post(url, params=params)
    return response.json()

# Gọi đến trang HTML
@app.route('/')
def index():
    return render_template('index.html')
git
#Gọi đến hàm nhận diện ảnh
@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

# Chương trình chạy ứng dụng
if __name__ == "__main__":
    socketio.run(app, host='0.0.0.0', port=5000, debug=True, use_reloader=False)
