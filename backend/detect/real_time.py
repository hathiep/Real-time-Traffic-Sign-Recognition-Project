import pickle
import cv2
import numpy as np
import tensorflow as tf
from datetime import datetime
from tensorflow import keras
import urllib.request
import numpy as np
# import schedule
import time
from datetime import timedelta, datetime,date
classes = [ 'Speed Limit 20 km/h',
            'Speed Limit 30 km/h', 
            'Speed Limit 50 km/h',
            'Speed Limit 60 km/h',
            'Speed Limit 70 km/h',
            'Speed Limit 80 km/h',
            'End of Speed Limit 80 km/h',
            'Speed Limit 100 km/h',
            'Speed Limit 120 km/h',
            'No passing',
            'No passing for vechiles over 3.5 metric tons',
            'Right-of-way at the next intersection',
            'Priority road',
            'Yield',
            'Stop',
            'No vechiles',
            'Vechiles over 3.5 metric tons prohibited',
            'No entry',
            'General caution',
            'Dangerous curve to the left',
            'Dangerous curve to the right',
            'Double curve',
            'Bumpy road',
            'Slippery road',
            'Road narrows on the right',
            'Road work',
            'Traffic signals',
            'Pedestrians',
            'Children crossing',
            'Bicycles crossing',
            'Beware of ice/snow',
            'Wild animals crossing',
            'End of all speed and passing limits',
            'Turn right ahead',
            'Turn left ahead',
            'Ahead only',
            'Go straight or right',
            'Go straight or left',
            'Keep right',
            'Keep left',
            'Roundabout mandatory',
            'End of no passing',
            'End of no passing by vechiles over 3.5 metric tons']

url='http://192.168.247.242/cam-lo.jpg'
def save_img(filename,img):
  cv2.imwrite(filename,img)
# cam=cv2.VideoCapture(0)
pickle_in=open("E:\Traffic_model\model_trained.p","rb")  ## rb = READ BYTE
model=pickle.load(pickle_in)

while True:
    # ret,frame=cam.read()
    img=urllib.request.urlopen(url)
    img_np= np.array(bytearray(img.read()),dtype=np.uint8)
    frame=cv2.imdecode(img_np,-1)
    box=[5,5,260,220]
    if box is not None:
      (x,y,w,h) =box[0],box[1], box[2],box[3]
      img=frame[y:h, x:w]
      img1 = cv2.resize(img,(224,224))
      img2 = cv2.resize(img,(256,256))
      img_array = np.expand_dims(img1, axis=0)
      pImg = preprocess_input(img_array)
      
      prediction = model.predict(pImg)
      prediction=prediction[0]
      predicted_class = np.argmax(prediction, axis=-1)
      pro=prediction[predicted_class]
      # s=str(predicted_class)+"    xsuat"+ str(pro)
      
      s="Label: {}".format(str(classes[predicted_class]))
      s2="Pro: {}".format(str(pro))

      print(prediction)
      print(f"label {s}")
      
      
        #.....
    cv2.rectangle(frame, (x,y), (w,h), (255,0,0), 2)
    cv2.putText(frame, s , (x+5, y+15),cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,255,0), 2)
    cv2.putText(frame, s2, (x+35, y+45),cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0,255,0), 2)
    print(f"predict class: {predicted_class}")
    print(f"img2: {img2}")
      # camera_run(1,img2,0)
      # camera_run(1,img2,1)

      # time.sleep(0.5)  
    cv2.imshow("frame", frame)
    if cv2.waitKey(10) & 0xFF == ord('q'):
            break
# cam.release()
cv2.destroyAllWindows()